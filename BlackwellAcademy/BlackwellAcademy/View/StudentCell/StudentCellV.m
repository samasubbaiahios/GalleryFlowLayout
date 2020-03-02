//
//  StudentCellV.m
//  BlackwellAcademy
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import "StudentCellV.h"
#import "Constants.h"
#import "StudentCellV.h"

@implementation StudentCellV

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpView];
}

- (void) setUpView {
    [self setBackgroundColor:UIColor.clearColor];
    //[self setBackgroundColor: [UIColor colorWithRed:(50/255.0f) green:(50/255.0f) blue:(50/255.0f) alpha:0.6f]];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.studentNameLbl setTextColor:UIColor.whiteColor];
    [self.studentNameLbl setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18]];
    [self.studentAgeLbl setTextColor:UIColor.lightTextColor];
    [self.studentAgeLbl setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16]];
    [self.studentGradeLbl setTextColor:UIColor.lightTextColor];
    [self.studentGradeLbl setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16]];
    [self.studentScholarshipLbl setTextColor:UIColor.lightTextColor];
    [self.studentScholarshipLbl setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16]];
}

- (void)prepareForInterfaceBuilder{
    [super prepareForInterfaceBuilder];
    [self setUpView];
}

- (NSString *)reuseIdentifier {
    return studentCellIdentifier;
}

- (id)setExpandableStudentCellDelegate:(id<ExpandableStudentCellDelegate>)delegate atIndexPath:(NSIndexPath *)indexPath {
    self.delegate = delegate;
    self.indexPath = indexPath;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                initWithTarget:self
                                action:@selector(selectCellAction:)]];
    return self;
}

- (void)selectCellAction: (UITapGestureRecognizer *)tapGesture {
    StudentCellV *studentCell = (StudentCellV *)tapGesture.view;
    [self.delegate toggleStudentCell:studentCell atIndexPath:self.indexPath];
}

@end
