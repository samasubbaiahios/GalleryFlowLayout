//
//  BWStudentsTVC.m
//  BlackwellAcademy
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import "BWStudentsTVC.h"
#import "Constants.h"
#import "StudentCellV.h"
#import "Student.h"
#import "BWAcademyService.h"
#import "BWStudentDetailsVC.h"

@interface BWStudentsTVC () <ExpandableStudentCellDelegate, UIViewControllerPreviewingDelegate>
@property (strong, nonatomic) NSMutableArray <Student *> *students;
@property (nonatomic, strong) id previewingContext;
@end

@implementation BWStudentsTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    _students = [NSMutableArray new];
    _students = [[BWAcademyService sharedInstance] students];
    
    [self forceTouchIntialize];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)forceTouchIntialize{
    if ([self isForceTouchAvailable]) {
        self.previewingContext = [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
}

- (BOOL)isForceTouchAvailable {
    BOOL isForceTouchAvailable = NO;
    if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
        isForceTouchAvailable = self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable;
    }
    return isForceTouchAvailable;
}

#pragma mark - UIViewController Previewing Delegate

- (void)previewingContext:(nonnull id<UIViewControllerPreviewing>)previewingContext commitViewController:(nonnull UIViewController *)viewControllerToCommit {
    //[self.navigationController showViewController:viewControllerToCommit sender:nil];
    [self.navigationController presentViewController:viewControllerToCommit animated:YES completion:nil];
}

- (nullable UIViewController *)previewingContext:(nonnull id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    CGPoint cellPostion = [self.tableView convertPoint:location fromView:self.view];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:cellPostion];
    
    if (indexPath) {
        StudentCellV *studentCell = [self.tableView cellForRowAtIndexPath:indexPath];
        Student *student = [self.students objectAtIndex:indexPath.row];
        [[BWAcademyService sharedInstance] setLastStudentSelected:student];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        BWStudentDetailsVC *previewController = [storyboard instantiateViewControllerWithIdentifier:@"BWStudentDetailsVC"];
        
        previewController.studentProfileImageView.image = [UIImage imageNamed:studentDefaultImageName];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [previewController getStudentImage:student];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[previewController studentProfileImageView] setImage:previewController.studentProfileImage];
            });
        });
        
        [previewController.studentNameLbl setText:student.name];
        [previewController.studentAgeLbl setText:[NSString stringWithFormat:@"Age: %ld", (long)student.age]];
        [previewController.studentGradeLbl setText:[NSString stringWithFormat:@"Grade: %ld", (long)student.grade]];
        [previewController.studentScholarshipTypeLbl setText:[NSString stringWithFormat:@"Scholarship: %@",student.scholarshipType]];
        
        int scholarshipId = [previewController getScholarshipType:student.scholarshipType];
        [previewController setScholarshipDescription:scholarshipId];
        
        previewingContext.sourceRect = [self.view convertRect:studentCell.frame fromView: self.tableView];
        return previewController;
    }
    return nil;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return numberOfSectionsForStudentList;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self students].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self students][indexPath.row].isExpanded) {
        return heightForExpandedStudentCell;
    } else {
        return heightForStudentCell;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StudentCellV *studentCell = (StudentCellV *)[self.tableView dequeueReusableCellWithIdentifier:studentCellIdentifier];
    [studentCell setExpandableStudentCellDelegate:self atIndexPath:indexPath];
    
    if (studentCell == nil) {
        studentCell = [tableView dequeueReusableCellWithIdentifier:studentCellIdentifier];
        studentCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    studentCell.accessoryType = UITableViewCellAccessoryDetailButton;
    [studentCell setTintColor:[UIColor whiteColor]];
    
    [[studentCell studentNameLbl] setText:self.students[indexPath.row].name];
    [[studentCell studentAgeLbl] setText:[NSString stringWithFormat:@"Age: %ld", (long)self.students[indexPath.row].age]];
    [[studentCell studentGradeLbl] setText:[NSString stringWithFormat:@"Current grade: %ld", (long)self.students[indexPath.row].grade]];
    [[studentCell studentScholarshipLbl] setText:[NSString stringWithFormat:@"Scholarship: %@", self.students[indexPath.row].scholarshipType]];
    
    return studentCell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    
    [[BWAcademyService sharedInstance] setLastStudentSelected:[self.students objectAtIndex:indexPath.row]];
    [self performSegueWithIdentifier:studentDetailsSegueIdentifier sender:nil];
}

#pragma mark - Expandable HeaderCell delegate

- (void)toggleStudentCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    [self students][indexPath.row].isExpanded = ![self students][indexPath.row].isExpanded;
    
    if ([self students][indexPath.row].isExpanded) {
        
        [UIView transitionWithView:[self.tableView cellForRowAtIndexPath:indexPath]
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            
                               [[self.tableView cellForRowAtIndexPath:indexPath] setBackgroundColor: [UIColor colorWithRed:(50/255.0f) green:(50/255.0f) blue:(50/255.0f) alpha:0.6f]];
        } completion:NULL];
    } else if (![self students][indexPath.row].isExpanded) {
        
        [UIView transitionWithView:[self.tableView cellForRowAtIndexPath:indexPath]
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                               
                               [[self.tableView cellForRowAtIndexPath:indexPath] setBackgroundColor: UIColor.clearColor];
                           } completion:NULL];
    }
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

#pragma mark - UINavigation

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    if ([[segue identifier] isEqualToString:studentDetailsSegueIdentifier]) {
//        NSLog(@"\n--------~ Presenting student's detail view ~--------\n");
//    }
//}

@end
