//
//  Student.h
//  BlackwellAcademy
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger age;
@property (assign, nonatomic) NSInteger grade;
@property (strong, nonatomic) NSString *scholarshipType;
@property (strong, nonatomic) NSString *pictureUrl;
@property (assign, nonatomic) BOOL isExpanded;

- (id)init;
- (id)initWithName:(NSString *)name withAge:(NSInteger)age InGrade:(NSInteger)grade withScholarShipType: (NSString *)scholarshipType withPictureUrl:(NSString *)pictureUrl;

@end

