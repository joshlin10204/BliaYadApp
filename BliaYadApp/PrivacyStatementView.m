//
//  PrivacyStatementView.m
//  BliaYadApp
//
//  Created by User on 2016/5/10.
//  Copyright © 2016年 User. All rights reserved.
//

#import "PrivacyStatementView.h"
static PrivacyStatementView *instance=nil;

@interface PrivacyStatementView ()

@end

@implementation PrivacyStatementView
+(PrivacyStatementView*)initprivacyStatementViewView:(UIView *)view
{
    @synchronized(self)
    {
        if (instance == nil)
        {
            NSLog(@"00000");
            instance=[[PrivacyStatementView alloc]initWithFrame:CGRectMake(0, 0,view.window.frame.size.width,view.window.frame.size.height)];
            [view.window addSubview:instance];
            [UIView animateWithDuration:0.5
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 instance.privacyStatementBasicView.frame=CGRectMake(0,0, instance.frame.size.width, instance.frame.size.height);
                                 
                             }
                             completion:nil];
            
            return instance;
        }
        else
        {
            [view.window addSubview:instance];
            [UIView animateWithDuration:0.5
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 instance.privacyStatementBasicView.frame=CGRectMake(0,0, instance.frame.size.width, instance.frame.size.height);
                                 
                             }
                             completion:nil];
            
        }
    }
    return instance;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    
    
    self = [super initWithFrame:frame];
    
    
    if (self)
    {
        
        [[NSBundle mainBundle]loadNibNamed:@"PrivacyStatementView" owner:self options:nil];
        self.privacyStatementBasicView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
        [self addSubview:self.privacyStatementBasicView];
        NSString*titleText =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Privacy Statement", @"LocalizationPlist", nil)];
        self.privacyStatementLabel.text=titleText;
        
        NSString*buttonText =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Close", @"LocalizationPlist", nil)];
        [self.closeButton setTitle:buttonText forState:UIControlStateNormal];
        
    }
    
    return self;

}
- (IBAction)onClickCloseBtn:(id)sender
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.privacyStatementBasicView.frame=CGRectMake(0,self.frame.size.height, self.frame.size.width, self.frame.size.height);
                         
                     }
                     completion:^(BOOL finished){
                         NSLog(@"結束");
                         [self removeFromSuperview];
                         
                         
                     }];
}
@end
