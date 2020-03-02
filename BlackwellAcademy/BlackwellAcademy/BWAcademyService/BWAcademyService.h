//
//  BWAcademyService.h
//  BlackwellAcademy
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"
#import <sqlite3.h>
#import "Constants.h"

typedef enum {
    ExceptionError = 5,
    StatementError = 6
} registerStudentErrorType;

@protocol BWDatabaseDelegate <NSObject>
@optional
- (void)dbDidFailWithErrorMessage: (NSString *)message andTitle:(NSString *)title;
- (void)dbDidReturnDataSuccessfully;
- (void)newStudentDidRegistered:(Student *)student;
- (void)failToRegisterStudent:(registerStudentErrorType)errorType;

@end

@interface BWAcademyService : NSObject

@property (strong, nonatomic) NSMutableArray<Student *> *students;
@property (strong, nonatomic) Student *lastStudentSelected;
@property (weak, nonatomic) id <BWDatabaseDelegate> delegate;

- (void)fetchAllStudents;
- (void)registerNewStudent: (Student *)student;
+ (instancetype)sharedInstance;

@end

