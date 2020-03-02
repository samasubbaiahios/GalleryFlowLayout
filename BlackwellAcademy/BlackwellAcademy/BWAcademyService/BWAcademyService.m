//
//  BWAcademyService.m
//  BlackwellAcademy
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import "BWAcademyService.h"
#import "AppDelegate.h"
#import "Constants.h"

typedef enum {
    OpenDBError = 1,
    PrepareDBError = 2,
    EmptyDBError = 3,
    FailedToExecDBError = 4
} dbErrorType;

@implementation BWAcademyService

+ (instancetype)sharedInstance {
    static BWAcademyService *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BWAcademyService alloc] init];
    });
    return sharedInstance;
}

- (sqlite3*)openConnection:(NSString*)forDatabase{
    @autoreleasepool {
        sqlite3 *database;
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
        NSString *documentsDir = [paths objectAtIndex:0];
        
        NSString *databasePath = [[NSString alloc] initWithString:[documentsDir stringByAppendingPathComponent: forDatabase]];
        NSFileManager *filemgr = [NSFileManager defaultManager];
        
        if ([filemgr fileExistsAtPath: databasePath ] == NO) {
            [[NSFileManager defaultManager] createFileAtPath:databasePath contents:NULL attributes:NULL];
        }
        
        const char *dbpath = [databasePath UTF8String];
        int result = sqlite3_open_v2(dbpath, &database, SQLITE_OPEN_READWRITE, NULL);
        
        if ( result != SQLITE_OK) {
            return nil;
        }
        return database;
    }
}

- (void)registerNewStudent: (Student *)student{
    
    sqlite3_stmt *statement = NULL;
    sqlite3 *database;
    
    database = [self openConnection:blackwellAcademyDBFileName];
    
    @try {
        if (database) {
            NSString *querySQL = [NSString stringWithFormat:@"INSERT INTO Students(name, age, grade, scholarship, pictureUrl) VALUES(?, ?, ?, ?, ?)"];
            const char *query_statement = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(database, query_statement, -1, &statement, NULL) != SQLITE_OK){
                NSAssert1(0, @"Error while creating insert statement. '%s'", sqlite3_errmsg(database));
                [self.delegate failToRegisterStudent:StatementError];
            } else {
                sqlite3_bind_text(statement, 1, [student.name UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_int(statement, 2, (int)student.age);
                sqlite3_bind_int(statement, 3, (int)student.grade);
                sqlite3_bind_text(statement, 4, [student.scholarshipType UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(statement, 5, [student.pictureUrl UTF8String], -1, SQLITE_TRANSIENT);
            }
            if (sqlite3_step(statement) == SQLITE_DONE){
                NSLog(@"\n\n-------------!!!~### New Student SUCCESSFULLY REGISTERED ###~!!!-------------\n\n");
                [self.students addObject:student];
                [self.delegate newStudentDidRegistered:student];
            }
            else {
                NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
                [self.delegate failToRegisterStudent:StatementError];
            }
        }
    } @catch (NSException *exception) {
        NSLog(@"Exception is %@, %@", [exception name], [exception reason]);
        [self.delegate failToRegisterStudent:ExceptionError];
    } @finally {
        if (statement != NULL) {
            sqlite3_finalize(statement);
            sqlite3_close_v2(database);
            statement = NULL;
        }
    }
}

- (void)fetchAllStudents {
    
    sqlite3_stmt *statement = NULL;
    sqlite3 *database;
    int errorType;
    
    database = [self openConnection:blackwellAcademyDBFileName];
    self.students = [NSMutableArray new];
    
    @try {
        if (database) {
            NSString *querySQL = @"SELECT * FROM Students";
            const char *query_statement = [querySQL UTF8String];
            
            if (sqlite3_prepare_v2(database, query_statement, -1, &statement, NULL) == SQLITE_OK) {
                
                while(sqlite3_step(statement) == SQLITE_ROW) {
                    NSString *studentName = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                    
                    NSString *studentAgeStr = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                    NSInteger studentAge = [studentAgeStr integerValue];
                    
                    NSString *studentGradeStr = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                    NSInteger studentGrade = [studentGradeStr integerValue];
                    
                    NSString *studentScholarshipType = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                    NSString *studentPictureUrl = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement, 4)];
                    
                    Student *newStudent = [[Student alloc] initWithName:studentName
                                                                withAge:studentAge
                                                                InGrade:studentGrade
                                                    withScholarShipType:studentScholarshipType
                                                         withPictureUrl:studentPictureUrl];
                    [self.students addObject:newStudent];
                }
                if ([self.students count] == 0) {
                    errorType = EmptyDBError;
                }
                else {
                    [self.delegate dbDidReturnDataSuccessfully];
                }
            } else {
                errorType = PrepareDBError;
            }
        } else {
            errorType = OpenDBError;
        }
        
        switch (errorType) {
            case OpenDBError:
                [self.delegate dbDidFailWithErrorMessage:sqlite3_open_FAILED_message andTitle:@"Message"];
                break;
            case PrepareDBError:
                [self.delegate dbDidFailWithErrorMessage:sqlite3_prepare_FAILED_message andTitle:@"Failed"];
                break;
            case EmptyDBError:
                [self.delegate dbDidFailWithErrorMessage:sqlite3_open_EMPTY_message andTitle:@"Message"];
                break;
            case FailedToExecDBError:
                [self.delegate dbDidFailWithErrorMessage:sqlite3_exec_FAILED_message andTitle:@"Error"];
                break;
            default:
                break;
        }
    }@catch (NSException * e) {
        NSLog(@"Exception is %@, %@", [e name], [e reason]);
    }
    @finally {
        if (statement != NULL) {
            sqlite3_finalize(statement);
            sqlite3_close_v2(database);
            statement = NULL;
        }
    }
}

@end
