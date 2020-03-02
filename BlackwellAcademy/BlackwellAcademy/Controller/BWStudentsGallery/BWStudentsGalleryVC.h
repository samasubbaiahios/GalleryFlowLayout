//
//  BWStudentsGalleryVC.h
//  BlackwellAcademy
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BWStudentsGalleryVC : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *studentsCollectionView;
@property (strong, nonatomic) NSMutableArray <UIImage *> *studentPictures;

@end
