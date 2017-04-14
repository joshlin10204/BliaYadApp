//
//  PrivacyStatementView.h
//  BliaYadApp
//
//  Created by User on 2016/5/10.
//  Copyright © 2016年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrivacyStatementView : UIView
+(PrivacyStatementView*)initprivacyStatementViewView:(UIView *)view;

@property (strong, nonatomic) IBOutlet PrivacyStatementView *privacyStatementBasicView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UILabel *privacyStatementLabel;

@end
