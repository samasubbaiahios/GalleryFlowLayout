//
//  StudentAgeAndGradePV.m
//  BlackwellAcademy
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import "StudentAgeAndGradePV.h"

@implementation StudentAgeAndGradePV

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpView];
}

- (void) setUpView {
    [self setBackgroundColor: [UIColor colorWithRed:(113/255.0f) green:(126/255.0f) blue:(135/255.0f) alpha:1.0f]];
    [self setTintColor:UIColor.whiteColor];
    [[self layer] setCornerRadius:5.0f];
    [self setClipsToBounds:YES];
    [[self layer] setBorderWidth:1.0f];
    [[self layer] setBorderColor:UIColor.darkGrayColor.CGColor];
}

- (void)prepareForInterfaceBuilder{
    [super prepareForInterfaceBuilder];
    [self setUpView];
}

@end
