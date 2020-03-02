//
//  BWStudentDetailsVC.m
//  BlackwellAcademy
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import "BWStudentDetailsVC.h"
#import "BWAcademyService.h"
#import "Constants.h"

typedef enum {
    NoScholarship = 0,
    Academic = 1,
    Creative = 2,
    Athletic = 3,
    AcademicAndCreative = 4
} ScholarshipType;

@interface BWStudentDetailsVC ()

@end

@implementation BWStudentDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    Student *student = [[BWAcademyService sharedInstance] lastStudentSelected];
    
    self.studentProfileImage = [UIImage imageNamed:studentDefaultImageName];
    [[self studentProfileImageView] setImage:self.studentProfileImage];
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakSelf getStudentImage:student];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[weakSelf studentProfileImageView] setImage:weakSelf.studentProfileImage];
        });
    });
    
    [self.studentNameLbl setText:student.name];
    [self.studentAgeLbl setText:[NSString stringWithFormat:@"Age: %ld", (long)student.age]];
    [self.studentGradeLbl setText:[NSString stringWithFormat:@"Grade: %ld", (long)student.grade]];
    [self.studentScholarshipTypeLbl setText:[NSString stringWithFormat:@"Scholarship: %@",student.scholarshipType]];
    
    int scholarshipId = [self getScholarshipType:student.scholarshipType];
    [self setScholarshipDescription:scholarshipId];
}

# pragma mark - Helper methods

- (void)getStudentImage: (Student *)student {
    NSURL *url = [NSURL URLWithString:student.pictureUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    self.studentProfileImage = [UIImage imageWithData:data];
}

- (int)getScholarshipType: (NSString *)scholarshipTypeStr {
    
    if ([scholarshipTypeStr isEqualToString:@"No Scholarship"]){
        return NoScholarship;
    }
    else if ([scholarshipTypeStr isEqualToString:@"Academic"]) {
        return Academic;
    }
    else if ([scholarshipTypeStr isEqualToString:@"Creative"]) {
        return Creative;
    }
    else if ([scholarshipTypeStr isEqualToString:@"Athletic"]) {
        return Athletic;
    }
    else if ([scholarshipTypeStr isEqualToString:@"Creative & Academic"]) {
        return AcademicAndCreative;
    }
    return 0;
}

- (void)setScholarshipDescription: (int)scholarshipId {
    
    switch (scholarshipId) {
        case NoScholarship:
            [self.studentScholarshipDescription setText:@"No description."];
            break;
        case Academic:
            [self.studentScholarshipDescription setText:description_for_ACADEMIC_SH];
            break;
        case Creative:
            [self.studentScholarshipDescription setText:description_for_CREATIVE_SH];
            break;
        case Athletic:
            [self.studentScholarshipDescription setText:description_for_ATHLETIC_SH];
            break;
        case AcademicAndCreative:
            [self.studentScholarshipDescription setText:description_for_CREATIVE_AND_ACADEMIC_SH];
            break;
        default:
            [self.studentScholarshipDescription setText:@"N/A."];
            break;
    }
}

- (IBAction)backBtnPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
