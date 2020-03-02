//
//  StudentsBtn.m
//  BlackwellAcademy
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import "StudentsBtn.h"

@implementation StudentsBtn

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpView];
}

- (void) setUpView {
    [self setBackgroundColor: [UIColor colorWithRed:(154/255.0f) green:(154/255.0f) blue:(154/255.0f) alpha:1.0f]];
    [[self layer ] setCornerRadius:8.0f];
    [self setClipsToBounds:YES];
    [[self layer] setBorderWidth:1.0f];
    [[self layer] setBorderColor:UIColor.darkGrayColor.CGColor];
}

- (void)prepareForInterfaceBuilder{
    [super prepareForInterfaceBuilder];
    [self setUpView];
}

@end
