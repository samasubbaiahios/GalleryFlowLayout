//
//  StudentCellV.h
//  BlackwellAcademy
//
//  Created by Venkata Subbaiah Sama on 9/25/18.
//  Copyright © 2018 Venkata. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExpandableStudentCellDelegate <NSObject>
@required
- (void)toggleStudentCell: (UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end

IB_DESIGNABLE
@interface StudentCellV : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *studentNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *studentAgeLbl;
@property (weak, nonatomic) IBOutlet UILabel *studentGradeLbl;
@property (weak, nonatomic) IBOutlet UILabel *studentScholarshipLbl;

@property (nonatomic, assign) NSIndexPath *indexPath;
@property (nonatomic, weak) id <ExpandableStudentCellDelegate> delegate;

- (id)setExpandableStudentCellDelegate:(id<ExpandableStudentCellDelegate>)delegate atIndexPath:(NSIndexPath *)indexPath;
@end
