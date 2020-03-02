//
//  BWStudentsGalleryVC.m
//  BlackwellAcademy
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import "BWStudentsGalleryVC.h"
#import "Constants.h"
#import "BWAcademyService.h"
#import "StudentCVCell.h"
#import "BWLayout.h"
#define RAND(min, max) (min + arc4random_uniform(max - min + 1))

@interface BWStudentsGalleryVC () <UICollectionViewDelegate, UICollectionViewDataSource, BWLayoutDelegate>

@end

@implementation BWStudentsGalleryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.studentsCollectionView.contentInset = UIEdgeInsetsMake(blackwellGalleryInsetX,
                                                                blackwellGalleryInsetY,
                                                                blackwellGalleryInsetLeft,
                                                                blackwellGalleryInsetRight);
    [self.studentsCollectionView setBackgroundColor:[UIColor colorWithRed:(94/255.0f)
                                                                    green:(105/255.0f)
                                                                     blue:(114/255.0f)
                                                                    alpha:1.0f]];
    BWLayout *customLayout = [[BWLayout alloc] init];
    self.studentsCollectionView.collectionViewLayout = customLayout;
    customLayout.delegate = self;
    
    [self clearContentsOfDirectoryAtPath:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]];
}

# pragma mark - Helper methods

- (void)clearContentsOfDirectoryAtPath: (NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *enumerator = [fileManager enumeratorAtPath:path];
    NSString *file;
    
    while (file = [enumerator nextObject]) {
        NSError *error = nil;
        BOOL result = [fileManager removeItemAtPath:[path stringByAppendingPathComponent:file] error:&error];
        
        if (!result && error) {
            NSLog(@"Error: %@", error);
        }
    }
}

- (IBAction)refreshBtnPressed:(id)sender {
    [self clearContentsOfDirectoryAtPath:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]];
    [self.studentsCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]
                                        atScrollPosition:UICollectionViewScrollPositionTop
                                                animated:YES];
    [self.studentsCollectionView reloadData];
}

#pragma mark - BWLayout Delegate

-(NSInteger)cellPadding:(UICollectionView *)padding{
    return blackwellGalleryCellsPadding;
}

-(NSInteger)numberOfColumns:(UICollectionView *)column{
    return blackwellGalleryNumOfColumns;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView heightForPhotoAtIndexPath:(NSIndexPath *)indexPath{
    return blackwellStudentPhotoHeight * RAND(2, 3);
}

# pragma mark - Collection view datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[BWAcademyService sharedInstance] students].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StudentCVCell *studentCVCell = [collectionView dequeueReusableCellWithReuseIdentifier:studentPhotoCellIdentifier forIndexPath:indexPath];
    
    [[studentCVCell studentImageView] setImage:[UIImage imageNamed:studentDefaultImageName]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *imgURLStr = [[BWAcademyService sharedInstance] students][indexPath.row].pictureUrl;
        [studentCVCell downloadImageFrom:imgURLStr];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgURLStr]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[studentCVCell studentImageView] setImage:[UIImage imageWithData:data]];
        });
    });
    
    [[studentCVCell studentImageView] setContentMode:UIViewContentModeScaleAspectFill];
    return studentCVCell;
}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [self.studentsCollectionView.collectionViewLayout invalidateLayout];
}

@end
