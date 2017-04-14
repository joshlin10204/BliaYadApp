 //
//  RegisteredView.m
//  BliaYadApp
//
//  Created by User on 2016/3/22.
//  Copyright © 2016年 User. All rights reserved.
//

#import "RegisteredView.h"
static RegisteredView *instance=nil;

@interface RegisteredView ()<UITextFieldDelegate>
{
    UIView * setView;
    UIActivityIndicatorView *loadIndicatorView;
    
    BOOL *isLogIn;

}

@end

@implementation RegisteredView
//
+(RegisteredView*)initregisterView:(UIView *)view
{
    @synchronized(self)
    {
        if (instance == nil)
        {
            NSLog(@"00000");
            instance=[[RegisteredView alloc]initWithFrame:CGRectMake(0, 0,view.window.frame.size.width,view.window.frame.size.height)];
            [view.window addSubview:instance];
            [UIView animateWithDuration:0.5
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 instance.registeredBasicView.frame=CGRectMake(0,0, instance.frame.size.width, instance.frame.size.height);
                                 
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
                                 instance.registeredBasicView.frame=CGRectMake(0,0, instance.frame.size.width, instance.frame.size.height);
                                 
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
        
        [[NSBundle mainBundle]loadNibNamed:@"RegisteredView" owner:self options:nil];
        self.registeredBasicView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
        [self addSubview:self.registeredBasicView];
        
        loadIndicatorView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectZero];
        [loadIndicatorView setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height*92/100)];
        [loadIndicatorView setHidesWhenStopped:YES];
        
        [loadIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [loadIndicatorView setColor:[UIColor grayColor]];
        
        [self addSubview:loadIndicatorView];
        
        
        [self.actionButton.layer setBorderColor:[[UIColor colorWithRed:255/255.0f
                                                                 green:155/255.0f
                                                                  blue:168/255.0f
                                                                 alpha:1.0f]CGColor]];
        [self.actionButton.layer setBorderWidth:2.0f];
        self.actionButton.layer.cornerRadius=10;
        self.actionWarnLabel.clipsToBounds=YES;
        self.actionWarnLabel.layer.cornerRadius=10;
        
        self.userNameText.delegate=self;
        self.emailAdressText.delegate=self;
        self.phoneNumberText.delegate=self;
        self.passwordText.delegate=self;
        self.confirmPasswordText.delegate=self;
        
        NSString *text=[NSString stringWithFormat:NSLocalizedStringFromTable(@"Already has accunt？\n Please click here to login", @"LocalizationPlist", nil)];
        
        self.changeActionButton.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
        self.changeActionButton.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self.changeActionButton setTitle:text forState:UIControlStateNormal];
        
        
        NSString *buttontext=[NSString stringWithFormat:NSLocalizedStringFromTable(@"Register", @"LocalizationPlist", nil)];
        [self.actionButton setTitle:buttontext forState:UIControlStateNormal];
        
        NSString *imagetext=[NSString stringWithFormat:NSLocalizedStringFromTable(@"RegisteredBuddhaImage_eg.png", @"LocalizationPlist", nil)];
        self.actionImage.image=[UIImage imageNamed:imagetext];
        
        
        
        
    }


    
    return self;
}


- (IBAction)OnClickChangeActionBtn:(id)sender
{
    if (isLogIn)
    {

        NSString *text=[NSString stringWithFormat:NSLocalizedStringFromTable(@"Already has accunt？\n Please click here to login", @"LocalizationPlist", nil)];
        
        self.changeActionButton.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
        self.changeActionButton.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self.changeActionButton setTitle:text forState:UIControlStateNormal];
        
        
        NSString *buttontext=[NSString stringWithFormat:NSLocalizedStringFromTable(@"Register", @"LocalizationPlist", nil)];
        [self.actionButton setTitle:buttontext forState:UIControlStateNormal];
        
        NSString *imagetext=[NSString stringWithFormat:NSLocalizedStringFromTable(@"RegisteredBuddhaImage_eg.png", @"LocalizationPlist", nil)];
        self.actionImage.image=[UIImage imageNamed:imagetext];
        [self initRegisterText];
        isLogIn=NO;


    }
    else
    {
         NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Don't have account yet？\n Please click here to register", @"LocalizationPlist", nil)];
        self.changeActionButton.titleLabel.lineBreakMode=NSLineBreakByWordWrapping;
        self.changeActionButton.titleLabel.textAlignment=NSTextAlignmentCenter;
        [self.changeActionButton setTitle:text forState:UIControlStateNormal];
        
        
        
        
        NSString *buttontext=[NSString stringWithFormat:NSLocalizedStringFromTable(@"Login", @"LocalizationPlist", nil)];
        [self.actionButton setTitle:buttontext forState:UIControlStateNormal];
        
        
        NSString *imagetext=[NSString stringWithFormat:NSLocalizedStringFromTable(@"LogInBuddhaImage_eg.png", @"LocalizationPlist", nil)];
        
        self.actionImage.image=[UIImage imageNamed:imagetext];

        [self initLogInText];

        isLogIn=YES;


    }
    
    
    
}

- (IBAction)OnClickActionBtn:(id)sender
{
    [loadIndicatorView startAnimating];

    if (isLogIn)
    {
        [self checkLogInInfoText];
    }
    else
    {
        [self checkRegisterInfoText];

    
    }
    
    
}
#pragma mark - Log In


-(void)initLogInText
{
    self.userNameText.text=@"";
    self.emailAdressText.text=@"";
    self.phoneNumberText.text=@"";
    self.passwordText.text=@"";
    self.confirmPasswordText.text=@"";


    [UIView animateWithDuration:0.3
                          delay:0.3
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGPoint movePoint;
                         movePoint.x=self.frame.size.width;
                         movePoint.y=self.frame.size.height*48/100;
                         self.phoneNumberText.frame=CGRectMake(movePoint.x,movePoint.y,0, self.frame.size.height/20);
                         
                         movePoint.y=self.frame.size.height*60/100;
                         self.confirmPasswordText.frame=CGRectMake(movePoint.x,movePoint.y,0, self.frame.size.height/20);
                         
                         
                         movePoint.x=self.frame.size.width*5/100;
                         movePoint.y=self.frame.size.height*48/100;
                         self.passwordText.frame=CGRectMake(movePoint.x,movePoint.y,self.frame.size.width*9/10, self.frame.size.height/20);
                         
                         

                         
                     }
                     completion:nil];

}
-(void)checkLogInInfoText
{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *checkEmailText = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];

    if (self.userNameText.text.length==0)
    {
        NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Not filled,name", @"LocalizationPlist", nil)];
        self.actionWarnLabel.lineBreakMode=NSLineBreakByWordWrapping;
        self.actionWarnLabel.text=text;
        [self showWarningLabel];
        [loadIndicatorView stopAnimating];
        
        
    }
    else if (self.emailAdressText.text.length==0)
    {
        NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Not filled,email", @"LocalizationPlist", nil)];
        self.actionWarnLabel.lineBreakMode=NSLineBreakByWordWrapping;
        self.actionWarnLabel.text=text;
        [self showWarningLabel];
        [loadIndicatorView stopAnimating];
    
    }
    else if (self.passwordText.text.length==0)
    {
        NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Not filled,password", @"LocalizationPlist", nil)];
        self.actionWarnLabel.lineBreakMode=NSLineBreakByWordWrapping;
        self.actionWarnLabel.text=text;
        [self showWarningLabel];
        [loadIndicatorView stopAnimating];
        
    }
//    else if(![checkEmailText evaluateWithObject:self.emailAdressText.text])
//    {
//        NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"The format of email key in is incorrect",@"LocalizationPlist", nil)];
//        self.actionWarnLabel.lineBreakMode=NSLineBreakByWordWrapping;
//        self.actionWarnLabel.text=text;
//        [self showWarningLabel];
//        
//        [loadIndicatorView stopAnimating];
//        
//        
//    }

    

    else
    {
          NSString *urlAdress=[NSString stringWithFormat:@"http://61.216.101.65/actionservice/service/members/register?username=%@&password=%@&email=%@",self.userNameText.text,self.passwordText.text,self.emailAdressText.text];
        [self onLoadURLData:urlAdress];
    }
    



}


#pragma mark - Register
-(void)initRegisterText
{
    self.userNameText.text=@"";
    self.emailAdressText.text=@"";
    self.phoneNumberText.text=@"";
    self.passwordText.text=@"";
    self.confirmPasswordText.text=@"";
    
    
    [UIView animateWithDuration:0.3
                          delay:0.3
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGPoint movePoint;
                         movePoint.x=self.frame.size.width*5/100;
                         movePoint.y=self.frame.size.height*48/100;
                         self.phoneNumberText.frame=CGRectMake(movePoint.x,movePoint.y,self.frame.size.width*9/10
                                                               , self.frame.size.height/20);
                         
                         movePoint.y=self.frame.size.height*60/100;
                         self.confirmPasswordText.frame=CGRectMake(movePoint.x,movePoint.y,self.frame.size.width*9/10, self.frame.size.height/20);
                         
                         
                         movePoint.y=self.frame.size.height*54/100;
                         self.passwordText.frame=CGRectMake(movePoint.x,movePoint.y,self.frame.size.width*9/10, self.frame.size.height/20);
                         
                         
                         
                         
                     }
                     completion:nil];
    
}
-(void)checkRegisterInfoText
{

    NSRegularExpression *numRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger numMatchCount = [numRegularExpression numberOfMatchesInString:self.passwordText.text
                                                                options:NSMatchingReportProgress
                                                                  range:NSMakeRange(0,self.passwordText.text.length)];

    NSRegularExpression *letterRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Za-z]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSInteger letterMatchCount = [letterRegularExpression numberOfMatchesInString:self.passwordText.text
                                                                      options:NSMatchingReportProgress range:NSMakeRange(0, self.passwordText.text.length)];

    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *checkEmailText = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    
    NSString *phoneNumberRegex = @"[0-9]{5,15}";
    NSPredicate *checkPhoneNumberText = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneNumberRegex];
    
    
    if (self.userNameText.text.length==0||
        self.emailAdressText.text.length==0||
        self.phoneNumberText.text.length==0||
        self.passwordText.text.length==0||
        self.confirmPasswordText.text.length==0)
    {
        NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Form to be filled",@"LocalizationPlist", nil)];
        self.actionWarnLabel.text=text;
        [self showWarningLabel];
        [loadIndicatorView stopAnimating];

        
    }
    
    else if(![checkEmailText evaluateWithObject:self.emailAdressText.text])
    {
        NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"The format of email key in is incorrect",@"LocalizationPlist", nil)];
        self.actionWarnLabel.lineBreakMode=NSLineBreakByWordWrapping;
        self.actionWarnLabel.numberOfLines = 0;
        self.actionWarnLabel.text=text;
        [self showWarningLabel];

        [loadIndicatorView stopAnimating];

    
    }
    else if(![checkPhoneNumberText evaluateWithObject:self.phoneNumberText.text])
    {
        NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"The format is incorrect for phone number",@"LocalizationPlist", nil)];
        self.actionWarnLabel.lineBreakMode=NSLineBreakByWordWrapping;
        self.actionWarnLabel.numberOfLines = 0;
        self.actionWarnLabel.text=text;
        [self showWarningLabel];

        [loadIndicatorView stopAnimating];

    
    }
    else if(self.passwordText.text.length<6 || self.passwordText.text.length>12)
    {
        NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Password length must be from 6 to 12",@"LocalizationPlist", nil)];
        self.actionWarnLabel.lineBreakMode=NSLineBreakByWordWrapping;
        self.actionWarnLabel.numberOfLines = 0;
        self.actionWarnLabel.text=text;
        [self showWarningLabel];

        [loadIndicatorView stopAnimating];

    }
    
    else if(numMatchCount==self.passwordText.text.length||letterMatchCount==self.passwordText.text.length)
    {
    
        NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Password has to include letters & numbers",@"LocalizationPlist", nil)];
        self.actionWarnLabel.lineBreakMode=NSLineBreakByWordWrapping;
        self.actionWarnLabel.numberOfLines = 0;
        self.actionWarnLabel.text=text;
        [self showWarningLabel];

        [loadIndicatorView stopAnimating];

    }
    else if(numMatchCount+letterMatchCount!=self.passwordText.text.length)
    {
        NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Password cannot have special characters",@"LocalizationPlist", nil)];
        self.actionWarnLabel.lineBreakMode=NSLineBreakByWordWrapping;
        self.actionWarnLabel.numberOfLines = 0;
        self.actionWarnLabel.text=text;
        [self showWarningLabel];

        [loadIndicatorView stopAnimating];

    }
    else if(![self.passwordText.text isEqualToString:self.confirmPasswordText.text])
    {
        NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"The password key in doesn't match with the previous one",@"LocalizationPlist", nil)];
        self.actionWarnLabel.lineBreakMode=NSLineBreakByWordWrapping;
        self.actionWarnLabel.numberOfLines = 0;
        self.actionWarnLabel.text=text;
        [self showWarningLabel];

        [loadIndicatorView stopAnimating];

    
    }
    else
    {
    
        
         NSString *urlAdress=[NSString stringWithFormat:
                              @"http://61.216.101.65/actionservice/service/members/register?username=%@&password=%@&email=%@&mobile=%@",self.userNameText.text,self.passwordText.text,self.emailAdressText.text,self.phoneNumberText.text];
        [self onLoadURLData:urlAdress];
    }



}


-(void)onLoadURLData:(NSString*)urlAdress
{
    NSLog(@"Loading....:%@",urlAdress);


    NSURL *url=[NSURL URLWithString:urlAdress];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          
                                          if (!error)
                                          {
                                              NSLog(@"1111");
                                               NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);

                                              
                                              [self onAnalyzeJsonData:data];
                                              
                                              
                                              
                                          }
                                          else
                                          {
                                              NSLog(@"ERROR :%@",error);
                                              [loadIndicatorView stopAnimating];

                                          }
                                          
                                      }];
    [dataTask resume];
    
    
}
- (void)onAnalyzeJsonData:(NSData *)jsonData
{
    
    NSLog(@"進入！！");
    
    NSError *error = nil;
    NSMutableDictionary* jsonObjectArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&error];
    NSLog(@"jsonObjectArray:%@",jsonObjectArray);
    NSLog(@"jsonObjectArray:%@",[jsonObjectArray objectForKey:@"userName"]);
    
    if (jsonObjectArray != nil && error == nil)

    {
        NSString *message=[jsonObjectArray objectForKey:@"Message"];

        
        
        if (message.length>0)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Someone already has that username.Try another?",@"LocalizationPlist", nil)];
                self.actionWarnLabel.lineBreakMode=NSLineBreakByWordWrapping;
                self.actionWarnLabel.numberOfLines = 0;
                self.actionWarnLabel.text=text;
                [self showWarningLabel];
                [loadIndicatorView stopAnimating];
                
                
            });


        }
        else
        {
            NSString *userName=[jsonObjectArray objectForKey:@"userName"];
            NSString *uuid=[jsonObjectArray objectForKey:@"uuid"];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:uuid forKey:@"userUUID"];
            
            NSLog(@"userName:%@",userName);
            NSLog(@"uuid:%@",uuid);
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self onClickCancelBtn:nil];
                    [loadIndicatorView stopAnimating];
                    
                    
                });
            });
        
        }
        

        

    }

    


    
}

#pragma mark - Other Action
-(void)showWarningLabel
{
    
    [UIView animateWithDuration:0
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{

                         self.actionWarnLabel.hidden=NO;

                         
                     }
                     completion:nil];
    
    [UIView animateWithDuration:1
                          delay:1
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.actionWarnLabel.alpha=0;
    
                         
                     }
                     completion:^(BOOL finished){
                         self.actionWarnLabel.hidden=YES;
                         self.actionWarnLabel.alpha=1;


                     }];



}


- (IBAction)onClickCancelBtn:(id)sender
{

    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.registeredBasicView.frame=CGRectMake(0,self.frame.size.height, self.frame.size.width, self.frame.size.height);
                         
                     }
                     completion:^(BOOL finished){
                         NSLog(@"結束");
                         [self removeFromSuperview];
                     
                     
                     }];




}
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    //當有如按下Return key 的時候
    [textField resignFirstResponder];
    //使用著第一個點取的元件 稱之為FirstResponder
    //resignFirstResponder, 當使用者點選的元件是可以輸入文字的時候
    return false;
}


@end
