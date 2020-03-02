//
//  Constants.m
//  BlackwellAcademy
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import "Constants.h"

@implementation Constants

NSString *const blackwellsDBDirectory = @"/Users/mp/Desktop/OBJ-C/BlackwellAcademy/BlackwellAcademy/SqliteDatabase/";
NSString *const blackwellAcademyDBFileName = @"BlackwellAcademyDB.sqlite";

char *const createNewTable_QUERY = "CREATE TABLE IF NOT EXISTS Students(name TEXT, age INTEGER, grade INTEGER, scolarship TEXT)";

NSString *const sqlite3_exec_FAILED_message = @"Command failed: sqlite3_exec.\nFailed to create table.";
NSString *const sqlite3_open_FAILED_message = @"Command failed: sqlite3_open.\nFailed to open table.";
NSString *const sqlite3_open_EMPTY_message = @"Database empty. \nNo students found in table.";
NSString *const sqlite3_prepare_FAILED_message = @"Failed preparation. \nFailed while searching the database.";

NSString *const description_for_ACADEMIC_SH = @"This student has proven strong merits throughout the academy's academic career, maintaining both a equal or higher GPA of 3.0 and no more than 3 class absences. Blackwell has granted recognition to this student and presented them with the Blackwell-Academic scholarship which covers the student's tuition 35% share and special honorary privileges.";
NSString *const description_for_CREATIVE_SH = @"This student has proven strong merits throughout the academy's creative career, performing brilliantly in the craftmanship and arts department giving Blackwell recognition in state art-competitions. Blackwell has granted recognition to this student and presented them with the Blackwell-Creative scholarship which covers the student's tuition 20% share and special honorary privileges.";
NSString *const description_for_ATHLETIC_SH = @"This student has proven high skills on their physical work throughout their competitive career in any sport represented in Blackwell Academy, therefor the institute of sports covers the student's tuition 35% share and gives this student special privileges.";
NSString *const description_for_CREATIVE_AND_ACADEMIC_SH = @"This student has accomplished strong merits in both academic & creative institutes of the Academy, maintaining both a equal or higher GPA of 3.0 and showcasing state-of-the-art craftsmanship in their art work in state art-competitions. Blackwell has granted recognition to this student and presented them with the Blackwell-Academic scholarship which covers the student's tuition 75% share and special honorary privileges.";

NSString *const studentCellIdentifier = @"studentCell";
NSString *const studentGallerySegueIdentifier = @"showStudentsGallery";
NSString *const studentDetailsSegueIdentifier = @"showStudentDetails";
NSString *const studentPhotoCellIdentifier = @"studentPhotoCell";
NSString *const registerNewStudentSegueIdentifier = @"registerNewStudent";
NSString *const studentDefaultImageName = @"default";
NSString *const validCharacterSetForStudentName = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ";
NSString *const exceptionErrorTypeDesc = @"Unexpected exception occured. Unable to register student.";
NSString *const statementErrorTypeDesc = @"Server error. Try again later.";
NSString *const newStudentEntryDesc = @"New student added successfully.";
NSString *const studentNameFormatIsWrongMsg = @"Student's name field only accepts characters [a-z][A-Z].";
NSString *const studentInfoMissingMsg = @"All new students require a picture and name when registering.";
NSString *const uploadingNewStudentAlertTitle = @"Uploading new student   ";

const int numberOfSectionsForStudentList = 1;
const int heightForExpandedStudentCell = 133;
const int heightForStudentCell = 43;
const int blackwellGalleryNumOfColumns = 2;
const int numberOfComponentsForPickerView = 3;
const int numberOfAvailableAges = 6;
const int numberOfAvailableGrades = 3;
const int numberOfAvailableScholarships = 5;
const int widthForComponentAge = 53;
const int widthForComponentGrade = 82;
const int widthForComponentScholarshipType = 169;
const int widthForComponents = 100;
const int heightForRowsInComponents = 50;

const int blackwellGalleryInsetX = 8;
const int blackwellGalleryInsetY = 8;
const int blackwellGalleryInsetLeft = 8;
const int blackwellGalleryInsetRight = 8;
const int blackwellGalleryCellsPadding = 6;
const int blackwellStudentPhotoHeight = 100.0f;
@end
