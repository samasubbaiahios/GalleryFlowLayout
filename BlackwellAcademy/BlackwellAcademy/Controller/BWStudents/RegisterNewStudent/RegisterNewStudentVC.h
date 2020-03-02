//
//  RegisterNewStudentVC.h
//  BlackwellAcademy
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentProfileImageV.h"

@interface RegisterNewStudentVC : UIViewController

@property (weak, nonatomic) IBOutlet StudentProfileImageV *studentImageView;
@property (weak, nonatomic) IBOutlet UITextField *studentNameTF;
@property (weak, nonatomic) IBOutlet UIPickerView *studentAgeAndGradePickerView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

