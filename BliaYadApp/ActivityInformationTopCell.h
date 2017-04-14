//
//  ActivityInformationTopCell.h
//  BliaYadApp
//
//  Created by User on 2016/4/5.
//  Copyright © 2016年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityInformationTopCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *activityInfoImage;
@property (weak, nonatomic) IBOutlet UILabel *activityInfoTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityInfoDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityInfoLocationLabel;

@end
