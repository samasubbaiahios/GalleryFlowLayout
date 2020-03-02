//
//  BWStudentDetailsVC.h
//  BlackwellAcademy
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentProfileImageV.h"
#import "Student.h"

@interface BWStudentDetailsVC : UIViewController

@property (weak, nonatomic) IBOutlet StudentProfileImageV *studentProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *studentNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *studentAgeLbl;
@property (weak, nonatomic) IBOutlet UILabel *studentGradeLbl;
@property (weak, nonatomic) IBOutlet UILabel *studentScholarshipTypeLbl;
@property (weak, nonatomic) IBOutlet UITextView *studentScholarshipDescription;
@property (strong, nonatomic) UIImage *studentProfileImage;

- (void)getStudentImage: (Student *)student;
- (int)getScholarshipType: (NSString *)scholarshipTypeStr;
- (void)setScholarshipDescription: (int)scholarshipId;

@end
