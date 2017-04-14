//
//  RegisteredView.h
//  BliaYadApp
//
//  Created by User on 2016/3/22.
//  Copyright © 2016年 User. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RegisteredView : UIView


+(RegisteredView*)initregisterView:(UIView *)view;

@property (strong, nonatomic) IBOutlet UIView *registeredBasicView;
@property (weak, nonatomic) IBOutlet UITextField *userNameText;
@property (weak, nonatomic) IBOutlet UITextField *emailAdressText;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordText;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UIButton *changeActionButton;
@property (weak, nonatomic) IBOutlet UIImageView *actionImage;
@property (weak, nonatomic) IBOutlet UILabel *actionWarnLabel;

@end
