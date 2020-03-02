//
//  StudentProfileImageV.m
//  BlackwellAcademy
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import "StudentProfileImageV.h"
#import "Constants.h"

@implementation StudentProfileImageV

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpView];
}

- (void) setUpView {
    [self setBackgroundColor: [UIColor colorWithRed:(154/255.0f) green:(154/255.0f) blue:(154/255.0f) alpha:1.0f]];
    [[self layer ] setCornerRadius:self.frame.size.height/2];
    [self setClipsToBounds:YES];
    [[self layer] setBorderWidth:1.0f];
    [[self layer] setBorderColor:UIColor.darkGrayColor.CGColor];
    [self setContentMode:UIViewContentModeScaleAspectFill];
}

- (void)prepareForInterfaceBuilder{
    [super prepareForInterfaceBuilder];
    [self setUpView];
    UIImage *image = [UIImage imageNamed:studentDefaultImageName inBundle:
                      [NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
    [self setImage:image];
}

@end
