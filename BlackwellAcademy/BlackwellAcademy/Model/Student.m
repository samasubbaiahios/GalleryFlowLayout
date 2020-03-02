//
//  Student.m
//  BlackwellAcademy
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import "Student.h"

@implementation Student

- (id)init{
    return [self initWithName:@"No name" withAge:0 InGrade:0 withScholarShipType:@"No scholarship" withPictureUrl:@""];
}

- (id)initWithName:(NSString *)name withAge:(NSInteger)age InGrade:(NSInteger)grade withScholarShipType:(NSString *)scholarshipType withPictureUrl:(NSString *)pictureUrl {
    
    self = [super init];
    
    if(self) {
        self.name = name;
        self.age = age;
        self.grade = grade;
        self.scholarshipType = scholarshipType;
        self.pictureUrl = pictureUrl;
    }
    return self;
}

@end
