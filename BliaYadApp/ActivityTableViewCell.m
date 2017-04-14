//
//  ActivityTableViewCell.m
//  BliaYadApp
//
//  Created by User on 2016/4/4.
//  Copyright © 2016年 User. All rights reserved.
//

#import "ActivityTableViewCell.h"

@implementation ActivityTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.activityBgImage.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.activityBgImage.layer.shadowOffset = CGSizeMake(0.0f, 0.0f); // [水平偏移, 垂直偏移]
    self.activityBgImage.layer.shadowOpacity = 0.4f; // 0.0 ~ 1.0 的值
    self.activityBgImage.layer.shadowRadius = 5.0f;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
