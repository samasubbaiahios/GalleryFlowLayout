//
//  StudentCVCell.m
//  BlackwellAcademy
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import "StudentCVCell.h"
#import "Constants.h"

@implementation StudentCVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUpView];
}

- (void) setUpView {
    [self setBackgroundColor:[UIColor colorWithRed:(120/255.0f) green:(120/255.0f) blue:(120/255.0f) alpha:1.0f]];
    self.studentImageView.layer.cornerRadius = 10.0f;
    self.studentImageView.clipsToBounds = YES;
    self.layer.cornerRadius = 10.0f;
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)prepareForInterfaceBuilder{
    [super prepareForInterfaceBuilder];
    [self setUpView];
}

- (void) prepareForReuse {
    [super prepareForReuse];
    self.studentImageView.image = nil;
}

- (void) downloadImageFrom: (NSString *)urlString {
    __weak typeof(self) weakSelf = self;
    
    NSURLSessionDownloadTask *downloadTask = [[NSURLSession sharedSession] downloadTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSData *imageData = [NSData dataWithContentsOfURL:location];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        if ([fileManager fileExistsAtPath:[location path]]) {
            NSError *err=nil;
            NSDictionary *tempAtt = [fileManager attributesOfItemAtPath:[location path] error:nil];
            NSString *docsTempPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
            
            if (tempAtt != nil && [tempAtt valueForKey:NSFileSize] > 0) {
                NSString *imageFilePath = [docsTempPath stringByAppendingPathComponent:urlString.lastPathComponent];
                [imageData writeToFile:imageFilePath atomically:YES];
        
                if (err) {
                    NSLog(@"%@", [err debugDescription]);
                }
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (imageData != nil) {
                weakSelf.studentImageView.image = [UIImage imageWithData:imageData];
            }
        });
    }];
    [downloadTask resume];
}

@end
