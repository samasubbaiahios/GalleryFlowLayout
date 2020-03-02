//
//  Constants.h
//  BlackwellAcademy
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

typedef void (^CompletionHandler)(BOOL);

extern NSString *const blackwellsDBDirectory;
extern NSString *const blackwellAcademyDBFileName;

extern char *const createNewTable_QUERY;

extern NSString *const sqlite3_exec_FAILED_message;
extern NSString *const sqlite3_open_FAILED_message;
extern NSString *const sqlite3_open_EMPTY_message;
extern NSString *const sqlite3_prepare_FAILED_message;

extern NSString *const description_for_ACADEMIC_SH;
extern NSString *const description_for_ATHLETIC_SH;
extern NSString *const description_for_CREATIVE_SH;
extern NSString *const description_for_CREATIVE_AND_ACADEMIC_SH;

extern NSString *const studentCellIdentifier;
extern NSString *const studentGallerySegueIdentifier;
extern NSString *const studentDetailsSegueIdentifier;
extern NSString *const registerNewStudentSegueIdentifier;
extern NSString *const studentPhotoCellIdentifier;
extern NSString *const studentDefaultImageName;
extern NSString *const validCharacterSetForStudentName;

extern NSString *const studentNameFormatIsWrongMsg;
extern NSString *const studentInfoMissingMsg;
extern NSString *const exceptionErrorTypeDesc;
extern NSString *const statementErrorTypeDesc;
extern NSString *const newStudentEntryDesc;
extern NSString *const uploadingNewStudentAlertTitle;

extern const int numberOfSectionsForStudentList;
extern const int heightForExpandedStudentCell;
extern const int heightForStudentCell;
extern const int blackwellGalleryNumOfColumns;
extern const int heightForRowsInComponents;
extern const int widthForComponents;
extern const int numberOfAvailableScholarships;

extern const int numberOfComponentsForPickerView;
extern const int numberOfAvailableAges;
extern const int numberOfAvailableGrades;
extern const int widthForComponentAge;
extern const int widthForComponentGrade;
extern const int widthForComponentScholarshipType;

extern const int blackwellGalleryInsetX;
extern const int blackwellGalleryInsetY;
extern const int blackwellGalleryInsetLeft;
extern const int blackwellGalleryInsetRight;
extern const int blackwellGalleryCellsPadding;
extern const int blackwellStudentPhotoHeight;
@end
