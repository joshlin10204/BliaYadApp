//
//  ActivityInformationCell.m
//  BliaYadApp
//
//  Created by User on 2016/4/5.
//  Copyright © 2016年 User. All rights reserved.
//

#import "ActivityInformationCell.h"

@implementation ActivityInformationCell

- (void)awakeFromNib
{
    // Initialization code
//    self.activityInfoBackgroundView.layer.borderWidth = 1;
//    self.activityInfoBackgroundView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.activityInfoBackgroundView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.activityInfoBackgroundView.layer.shadowOffset = CGSizeMake(3.0f, 0.0f); // [水平偏移, 垂直偏移]
    self.activityInfoBackgroundView.layer.shadowOpacity = 0.3f; // 0.0 ~ 1.0 的值
    self.activityInfoBackgroundView.layer.shadowRadius = 5.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
