//
//  ActivityInformationCell.h
//  BliaYadApp
//
//  Created by User on 2016/4/5.
//  Copyright © 2016年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityInformationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *activityInfoBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *activityInfoItemLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityInfoDetailLabel;

@end
