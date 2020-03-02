//
//  AppDelegate.m
//  BlackwellAcademy
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import "AppDelegate.h"
#import "Constants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self copyDBFile];
    return YES;
}

-(void)copyDBFile {
    NSArray *dbPaths=[AppDelegate getWritableDBPath];
    
    for (NSString *dbPath in dbPaths){
        
        BOOL databaseFileExists;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        databaseFileExists = [fileManager fileExistsAtPath:dbPath];
        
        if(!databaseFileExists){
            NSArray *arrPathSplit = [dbPath componentsSeparatedByString:@"/"];
            NSString *strDatabaseFileName = [arrPathSplit lastObject];
            NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:strDatabaseFileName];
            
            BOOL copySuccess = [fileManager copyItemAtPath:databasePathFromApp toPath:dbPath error:nil];
            if(copySuccess){ }else{ }
        }
    }
}

+ (NSArray *) getWritableDBPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    NSString *documentsDir = [paths objectAtIndex:0];
    return @[[documentsDir stringByAppendingPathComponent:blackwellAcademyDBFileName]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}

#pragma mark - Quick Actions

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    BOOL handledShortcutItem = [self handleShortcutItem:shortcutItem];
    completionHandler(handledShortcutItem);
}

- (BOOL)handleShortcutItem : (UIApplicationShortcutItem *)shortcutItem {
    
    BOOL handled = NO;
    NSString *bundleId = [NSBundle mainBundle].bundleIdentifier;
    NSString *shortcutRegisterNewStudent = [NSString stringWithFormat:@"%@.RegisterNewStudent", bundleId];
    
    if ([shortcutItem.type isEqualToString:shortcutRegisterNewStudent]) {
        handled = YES;
        
        UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *destinationVC = [storyboard instantiateViewControllerWithIdentifier:@"RegisterNewStudentVCID"];
        [navigationController presentViewController:destinationVC animated:NO completion:nil];
    }
    return handled;
}

@end
