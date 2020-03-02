//
//  BWAcademyHomepageVC.m
//  BlackwellAcademy
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import "BWAcademyHomepageVC.h"
#import "Constants.h"
#import "BWAcademyService.h"

@interface BWAcademyHomepageVC () <BWDatabaseDelegate>

@end

@implementation BWAcademyHomepageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],
                                                                      NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Light" size:19]}];
    
    [[BWAcademyService sharedInstance] setDelegate:self];
    [[BWAcademyService sharedInstance] fetchAllStudents];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [UIView transitionWithView:self.studentsBtn duration:0.8 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.studentsBtn.hidden = NO;
    } completion:NULL];
    [UIView transitionWithView:self.registerStudentBtn duration:0.8 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.registerStudentBtn.hidden = NO;
    } completion:NULL];
}

# pragma mark - Helper methods

- (void)showUIAlertWithMessage: (NSString *)message andTitle:(NSString *)title{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                         }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)registerBtnPressed:(id)sender {
    [self performSegueWithIdentifier:registerNewStudentSegueIdentifier sender:self];
}


#pragma mark - BWDatabase Delegate

- (void)dbDidReturnDataSuccessfully {
    NSLog(@"\n\n -------------~ Data fetched SUCCESSFULLY ~-------------\n\n");
    for (Student *student in [[BWAcademyService sharedInstance] students]) {
        NSLog(@"%@", [NSString stringWithFormat:@"\n\nName: %@, \nAge: %ld, \nGrade: %ld, \nScholarship: %@, \nPictureUrl: %@\n",
                      [student name], (long)[student age], (long)[student grade], [student scholarshipType], [student pictureUrl]]);
    }
}

- (void)dbDidFailWithErrorMessage:(NSString *)message andTitle:(NSString *)title {
    [self showUIAlertWithMessage:message andTitle:title];
}

@end
