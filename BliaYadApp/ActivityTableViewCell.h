//
//  ActivityTableViewCell.h
//  BliaYadApp
//
//  Created by User on 2016/4/4.
//  Copyright © 2016年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *activityImage;
@property (weak, nonatomic) IBOutlet UILabel *activityTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityLocationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *activityBgImage;

@end
