//
//  RegisterNewStudentVC.m
//  BlackwellAcademy
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import "RegisterNewStudentVC.h"
#import "Constants.h"
#import "BWAcademyService.h"
#import "BWStudentDetailsVC.h"

@interface RegisterNewStudentVC () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, BWDatabaseDelegate>

@end

@implementation RegisterNewStudentVC {
    const NSArray *ages;
    const NSArray *grades;
    const NSArray *scholarships;
    NSString *ageSelected;
    NSString *gradeSelected;
    NSString *scholarshipSelected;
    NSString *newStudentPictureUrl;
    UIAlertController *uploadNewStudentAlert;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    
    ageSelected = @"18";
    gradeSelected = @"12";
    scholarshipSelected = @"No Scholarship";
    
    ages = @[@"18", @"19", @"20", @"21", @"22", @"23"];
    grades = @[@"12", @"13", @"14"];
    scholarships = @[@"No Scholarship", @"Academic", @"Creative", @"Athletic", @"Creative & Academic"];
    
    [[BWAcademyService sharedInstance] setDelegate:self];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [self.view addGestureRecognizer:tap];
    
    [self.studentImageView setImage:[UIImage imageNamed:studentDefaultImageName]];
    
    UITapGestureRecognizer *imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fetchImageFromGallery:)];
    [imageTap setNumberOfTapsRequired:1];
    [self.studentImageView addGestureRecognizer:imageTap];
    self.studentImageView.userInteractionEnabled = YES;
    
    self.studentAgeAndGradePickerView.delegate = self;
    self.studentAgeAndGradePickerView.dataSource = self;
}

# pragma mark - Helper methods

typedef enum {
    NoErrorsFound = 0,
    MissingStudentName = 1,
    MissingStudentPicture = 2
} VerificationErrorType;

-(void)dismissKeyboard: (id)sender {
    [self.view endEditing:YES];
}

- (IBAction)submitBtnPressed:(id)sender {
    BOOL verificationPasses = [self verifyAllInputFields];
    
    if (verificationPasses) {
        BOOL validationPasses = [self validateAllInputFields];
        
        if (validationPasses) {
            NSLog(@"\n\n----------~Everything OK, insert into database~----------\n\n");
            //[self saveImageCopy:self.studentImageView.image]; Incomplete, need of Firebase assistance
            [self showUpoadingNewStudentAlert];
        }
        else {
            [self showUIAlertWithMessage:studentNameFormatIsWrongMsg andTitle:@"Error" withSuccess:nil];
        }
    } else {
        [self showUIAlertWithMessage:studentInfoMissingMsg andTitle:@"Error" withSuccess:nil];
    }
}

- (IBAction)backBtnPressed: (id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)fetchImageFromGallery: (id)sender {
    UIImagePickerController *imagePickerController = [UIImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)saveImageCopy: (UIImage *)image {
    NSString *docsTempPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *imageFilePathCopy = [docsTempPath stringByAppendingPathComponent:
                                   [NSString stringWithFormat:@"%@.png",
                                    [[NSProcessInfo processInfo] globallyUniqueString]]];
    
    NSData* data = UIImagePNGRepresentation(image);
    [data writeToFile:imageFilePathCopy atomically:YES];
    
    newStudentPictureUrl = imageFilePathCopy;
}

- (BOOL)verifyAllInputFields {
    VerificationErrorType err = NoErrorsFound;
    
    if ([self.studentNameTF.text isEqualToString:@""]) {
        err = MissingStudentName;
    } else if ([self.studentImageView.image isEqual:[UIImage imageNamed:studentDefaultImageName]]) {
        err = MissingStudentPicture;
    }
    
    if (err == NoErrorsFound) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)validateAllInputFields {
    NSCharacterSet *validChars = [NSCharacterSet characterSetWithCharactersInString:validCharacterSetForStudentName];
    validChars = [validChars invertedSet];
    
    NSRange range = [self.studentNameTF.text rangeOfCharacterFromSet:validChars];
    if (NSNotFound != range.location) {
        return NO;
    }
    return YES;
}

- (void)showUIAlertWithMessage: (NSString *)message andTitle:(NSString *)title withSuccess:(BOOL)success{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             if (success) {
                                                                 [self backBtnPressed:nil];
                                                             }
                                                         }];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showUpoadingNewStudentAlert {
    
    UIActivityIndicatorView *(^setLoadingIndicatorInAlertController)(UIAlertController*) = ^(UIAlertController *alertController) {
        
        UIActivityIndicatorView *loadingIndicator;
        loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        loadingIndicator.center = CGPointMake(alertController.view.frame.size.width/2.75, 65);
        loadingIndicator.hidesWhenStopped = YES;
        [loadingIndicator startAnimating];
        [loadingIndicator setColor:UIColor.blackColor];
        [loadingIndicator setAutoresizingMask: (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleHeight)];
        [alertController.view addSubview:loadingIndicator];
        
        return loadingIndicator;
    };
    
    NSString *newStudentDefaultImageUrl = @"https://www.timeshighereducation.com/sites/default/files/byline_photos/default-avatar.png";
    
    Student *(^getNewStudentFromSelectedData)(Student *) = ^(Student *newStudent){
        newStudent = [[Student alloc] initWithName:self.studentNameTF.text
                                           withAge:[self->ageSelected intValue]
                                           InGrade:[self->gradeSelected intValue]
                               withScholarShipType:self->scholarshipSelected
                                    withPictureUrl:newStudentDefaultImageUrl]; //self->newStudentPictureUrl Needs Firebase assistance
        return newStudent;
    };
    
    uploadNewStudentAlert = [UIAlertController alertControllerWithTitle:uploadingNewStudentAlertTitle
                                                                message:@"\n"
                                                         preferredStyle:UIAlertControllerStyleAlert];
    
    setLoadingIndicatorInAlertController(uploadNewStudentAlert);
    
    [self presentViewController:uploadNewStudentAlert animated:YES completion:^{
        Student *newStudent;
        [[BWAcademyService sharedInstance] registerNewStudent:getNewStudentFromSelectedData(newStudent)];
    }];
}

# pragma mark - BWDatabase delegate

- (void)failToRegisterStudent:(registerStudentErrorType)errorType {
    [uploadNewStudentAlert dismissViewControllerAnimated:YES completion:^{
        if (errorType == ExceptionError) {
            [self showUIAlertWithMessage:exceptionErrorTypeDesc andTitle:@"Error" withSuccess:nil];
        }
        else if (errorType == StatementError) {
            [self showUIAlertWithMessage:statementErrorTypeDesc andTitle:@"Error" withSuccess:nil];
        }
    }];
}

- (void)newStudentDidRegistered:(Student *)student {
    [uploadNewStudentAlert dismissViewControllerAnimated:YES completion:^{
        [self showUIAlertWithMessage:newStudentEntryDesc andTitle:@"Success" withSuccess:true];
    }];
}

# pragma mark - UIImagePickerController delegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    NSURL *url = info[UIImagePickerControllerImageURL];
    [self dismissViewControllerAnimated:YES completion:^{
        
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[weakSelf studentImageView] setImage:image];
            });
        });
    }];
}

# pragma mark - UIPickerView delegate

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return numberOfComponentsForPickerView;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return numberOfAvailableAges;
    }
    else if (component == 1) {
        return numberOfAvailableGrades;
    }
    else if (component == 2){
        return numberOfAvailableScholarships;
    }
    else{
        return 0;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return heightForRowsInComponents;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return widthForComponentAge;
    }
    else if (component == 1) {
        return widthForComponentGrade;
    }
    else if (component == 2) {
        return widthForComponentScholarshipType;
    }
    else {
        return 0;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *label = [UILabel new];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:UIColor.lightTextColor];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue-Regular" size:18]];
    
    NSString *title = @"";
    if (component == 0) {
        title = [NSString stringWithFormat:@"%@", [ages objectAtIndex:row]];
    }
    else if (component == 1) {
        title = [NSString stringWithFormat:@"%@", [grades objectAtIndex:row]];
    }
    else if (component == 2) {
        title = [NSString stringWithFormat:@"%@", [scholarships objectAtIndex:row]];
    }
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title
                                                                    attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [label setText:[attString string]];
    
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        ageSelected = [ages objectAtIndex:row];
    }
    else if (component == 1) {
        gradeSelected = [grades objectAtIndex:row];
    }
    else if (component == 2) {
        scholarshipSelected = [scholarships objectAtIndex:row];
    }
}

@end
