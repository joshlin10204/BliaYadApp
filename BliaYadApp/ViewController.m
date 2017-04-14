//
//  ViewController.m
//  BliaYadApp
//
//  Created by User on 2016/3/20.
//  Copyright © 2016年 User. All rights reserved.
//

#import "ViewController.h"


#import "ActivityPageView.h"
#import "RegisteredView.h"

@interface ViewController ()
{

    UIView * menuViewBackground;
    RegisteredView * registeredView;
    
    
    UIDynamicAnimator* animator;
    UIAttachmentBehavior*attachBehavior;
}
@property (weak, nonatomic) IBOutlet UIView *bliayaLogoView;
@property (weak, nonatomic) IBOutlet UIButton *facebookLinkBtn;
@property (weak, nonatomic) IBOutlet UIButton *googleplusLinkBtn;
@property (weak, nonatomic) IBOutlet UIButton *youtubeLinkBtn;
@property (weak, nonatomic) IBOutlet UIView *linkButtonView;
@property (strong, nonatomic)  UILabel *sponsorLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [self initMenuView];
    [self initLogoAnimation];
    [self initLinkButton];
    [self initSponsorLabel];
    

}
#pragma mark - MenuView

-(void)initMenuView
{

    menuViewBackground=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height)];
    menuViewBackground.opaque=YES;
    menuViewBackground.hidden=YES;
    menuViewBackground.backgroundColor=[UIColor colorWithRed:(255/255.0)
                                                       green:(255/255.0)
                                                        blue:(255/255.0)
                                                       alpha:0.5];
    

    
    menuView=[[MenuView alloc]initWithFrame:CGRectMake(-(self.view.frame.size.width*2/3+50), 0,self.view.frame.size.width*2/3,self.view.frame.size.height)];
    [self.view.window addSubview:menuViewBackground];
    [self.view.window  addSubview:menuView];
    
    
    
    
    
    UITapGestureRecognizer *tapGestureRecognizer;
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickMenuButton:)];
    [menuViewBackground addGestureRecognizer:tapGestureRecognizer];
    menuView.delegate=self;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:102/255.0 alpha:1];
//    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];

    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
   
    NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Home", @"LocalizationPlist", nil)];
    self.navigationItem.title=text;

}

- (IBAction)onClickMenuButton:(id)sender
{
    if (menuViewBackground.hidden)
    {
        menuViewBackground.hidden=NO;
    }
    else
    {
    
        menuViewBackground.hidden=YES;
    }
    

    [UIView beginAnimations:@"animation1" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    CGRect frame=menuView.frame;
    
    if (frame.origin.x<0)
    {
        frame.origin.x=0;

    }
    else
    {
        frame.origin.x -=frame.size.width+50;

        
    }
    menuView.frame=frame;
    
    [UIView commitAnimations];
    
}
-(void)selectMenuCell:(MenuViewListPageType)page
{
    if (page==MenuViewPageTypeHomePage)
    {
        

        NSLog(@"收到;%u",page);
    }
    else if(page==MenuViewPageTypeActivityPage)
    {
        [self onClickMenuButton:nil];
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

        id activityPageView = [storyboard instantiateViewControllerWithIdentifier:@"ActivityPageView"];

        [self.navigationController pushViewController:activityPageView animated:YES];


    }
    else if(page==MenuViewPageTypeMyTicketPage)
    {
        [self onClickMenuButton:nil];
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        id myTicketPageView = [storyboard instantiateViewControllerWithIdentifier:@"MyTicketPageView"];
        
        [self.navigationController pushViewController:myTicketPageView animated:YES];
        
        

    }
    else if(page==MenuViewPageTypeWebsitePage)
    {

    }
    else if(page==MenuViewPageTypeFaceBookPage)
    {

 
    }
    else if(page==MenuViewPageTypeContactPage)
    {
        [self onClickMenuButton:nil];

        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        id contactPageView = [storyboard instantiateViewControllerWithIdentifier:@"ContactPageView"];
        
        [self.navigationController pushViewController:contactPageView animated:YES];

    }
    
}
#pragma mark - Sponsor Label
-(void)initSponsorLabel
{
    CGSize sponsorSize;
    sponsorSize.height=self.view.frame.size.height*10/100;
    sponsorSize.width=self.view.frame.size.width*50/100;
    
    CGPoint sponsorPoint;
    sponsorPoint.x=self.view.frame.size.width*50/100;
    sponsorPoint.y=self.view.frame.size.height*92/100;
    
    self.sponsorLabel=[[UILabel alloc]initWithFrame:CGRectMake(sponsorPoint.x, sponsorPoint.y, sponsorSize.width, sponsorSize.height)];
    NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Sponsor :Bureau of Foreign Trade, MOEA",@"LocalizationPlist", nil)];
    self.sponsorLabel.text=text;
    [self.sponsorLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
    self.sponsorLabel.minimumFontSize = 8;
    self.sponsorLabel.adjustsFontSizeToFitWidth=YES;


    [self.sponsorLabel setTextAlignment:UITextAlignmentCenter];
    self.sponsorLabel.textColor=[UIColor blackColor];
    [self.view.window addSubview:self.sponsorLabel];
    self.sponsorLabel.hidden=YES;

}

#pragma mark - Link Button

-(void)initLinkButton
{
    self.facebookLinkBtn.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.facebookLinkBtn.layer.shadowOffset = CGSizeMake(3.0f, 3.0f); // [水平偏移, 垂直偏移]
    self.facebookLinkBtn.layer.shadowOpacity = 0.5f; // 0.0 ~ 1.0 的值
    self.facebookLinkBtn.layer.shadowRadius = 10.0f;
    
    self.googleplusLinkBtn.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.googleplusLinkBtn.layer.shadowOffset = CGSizeMake(3.0f, 3.0f); // [水平偏移, 垂直偏移]
    self.googleplusLinkBtn.layer.shadowOpacity = 0.5f; // 0.0 ~ 1.0 的值
    self.googleplusLinkBtn.layer.shadowRadius = 10.0f;
    
    self.youtubeLinkBtn.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.youtubeLinkBtn.layer.shadowOffset = CGSizeMake(3.0f, 3.0f); // [水平偏移, 垂直偏移]
    self.youtubeLinkBtn.layer.shadowOpacity = 0.5f; // 0.0 ~ 1.0 的值
    self.youtubeLinkBtn.layer.shadowRadius = 10.0f;
    
}

- (IBAction)OnClickFBLinkBtn:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/taiwanyad.headquarters/"]];
    
}

- (IBAction)OnClickGPLinkBtn:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://plus.google.com/100164245644664301628/videos"]];
    
}

- (IBAction)OnClickYTLinkBtn:(id)sender
{
    
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.youtube.com/channel/UCKUbuTd3n_AD6CAPMD6_4PQ"]];
    
}

#pragma mark - LogAnimation
-(void)initLogoAnimation
{
    //背景
    UIImageView *BliaYaLogoBg=[[UIImageView alloc]initWithFrame:CGRectMake(0, -self.bliayaLogoView.frame.size.height,self.bliayaLogoView.frame.size.width,self.bliayaLogoView.frame.size.height)];
    BliaYaLogoBg.image=[UIImage imageNamed:@"BliaYaLogo_Bg.png"];
    [self.bliayaLogoView addSubview:BliaYaLogoBg];
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         BliaYaLogoBg.frame=CGRectMake(0,-self.bliayaLogoView.frame.origin.y/2, self.bliayaLogoView.frame.size.width, self.bliayaLogoView.frame.size.height);
                         
                     }
                     completion:^(BOOL finished){
                         NSLog(@"結束11111");
                     }];
    
    // 藍色三角
    UIImageView *blueTriangle=[[UIImageView alloc]initWithFrame:CGRectMake(-self.bliayaLogoView.frame.size.width, 0,self.bliayaLogoView.frame.size.width,self.bliayaLogoView.frame.size.height)];
    blueTriangle.image=[UIImage imageNamed:@"BliaYaLogo_Blue.png"];
    [self.bliayaLogoView addSubview:blueTriangle];
    
    [UIView animateWithDuration:0.8
                          delay:0.3
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         blueTriangle.frame=CGRectMake(0,self.bliayaLogoView.frame.size.height/3.85, self.bliayaLogoView.frame.size.width, self.bliayaLogoView.frame.size.height);
                         
                     }
                     completion:^(BOOL finished){
                         NSLog(@"結束333333333");
                         
                         
                     }];
    // 粉色三角
    UIImageView *pinkTriangle=[[UIImageView alloc]initWithFrame:CGRectMake(self.bliayaLogoView.frame.size.width*2, 0,self.bliayaLogoView.frame.size.width,self.bliayaLogoView.frame.size.height)];
    pinkTriangle.image=[UIImage imageNamed:@"BliaYaLogo_Pink.png"];
    [self.bliayaLogoView addSubview:pinkTriangle];
    
    [UIView animateWithDuration:0.5
                          delay:0.6
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         pinkTriangle.frame=CGRectMake(0,0, self.bliayaLogoView.frame.size.width, self.bliayaLogoView.frame.size.height);
                         
                     }
                     completion:^(BOOL finished){
                         NSLog(@"結束2222222");
                         
                         
                     }];
    
    
    
    // 佛青
    UIImageView *bliaYaLogoBY=[[UIImageView alloc]initWithFrame:CGRectMake(0, -self.bliayaLogoView.frame.size.height,self.bliayaLogoView.frame.size.width,self.bliayaLogoView.frame.size.height)];
    bliaYaLogoBY.image=[UIImage imageNamed:@"BliaYaLogo_BY.png"];
    bliaYaLogoBY.alpha=0;
    [self.bliayaLogoView addSubview:bliaYaLogoBY];
    [UIView animateWithDuration:2
                          delay:1.3
         usingSpringWithDamping:0.5
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         bliaYaLogoBY.alpha=1;
                         
                         bliaYaLogoBY.frame=CGRectMake(0,-self.bliayaLogoView.frame.origin.y/5, self.bliayaLogoView.frame.size.width, self.bliayaLogoView.frame.size.height);
                         
                         
                     }
     
                     completion:^(BOOL finished){
                         NSLog(@"結束44444444");
                         
                     }];
    
    //20th
    UIImageView *bliaYaLogo20=[[UIImageView alloc]initWithFrame:CGRectMake(0, -self.bliayaLogoView.frame.size.height/2,self.bliayaLogoView.frame.size.width,self.bliayaLogoView.frame.size.height)];
    bliaYaLogo20.image=[UIImage imageNamed:@"BliaYaLogo_20.png"];
    bliaYaLogo20.alpha=0;
    [self.bliayaLogoView addSubview:bliaYaLogo20];
    [UIView animateWithDuration:3.5
                          delay:2.5
         usingSpringWithDamping:0.5
          initialSpringVelocity:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         bliaYaLogo20.alpha=1;

                         bliaYaLogo20.frame=CGRectMake(0,0, self.bliayaLogoView.frame.size.width, self.bliayaLogoView.frame.size.height);
                         
                         
                     }
     
                     completion:^(BOOL finished){
                         NSLog(@"結束55555555555");
                         
                     }];
    
    //1997
    UIImageView *bliaYaLogo1997=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.bliayaLogoView.frame.size.width,self.bliayaLogoView.frame.size.height)];
    bliaYaLogo1997.image=[UIImage imageNamed:@"BliaYaLogo_1997.png"];
    [self.bliayaLogoView addSubview:bliaYaLogo1997];
    bliaYaLogo1997.alpha=0;
    
    [UIView animateWithDuration:3
                          delay:5.5
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         bliaYaLogo1997.alpha=1;

                     }
                     completion:^(BOOL finished){
                         NSLog(@"結束7777777777");
                         
                         
                     }];

    
    //2016
    
    UIImageView *bliaYaLogo2016=[[UIImageView alloc]initWithFrame:CGRectMake(0, -self.bliayaLogoView.frame.origin.y/5,self.bliayaLogoView.frame.size.width,self.bliayaLogoView.frame.size.height)];
    bliaYaLogo2016.image=[UIImage imageNamed:@"BliaYaLogo_2016.png"];
    [self.bliayaLogoView addSubview:bliaYaLogo2016];
    bliaYaLogo2016.alpha=0;
    
    



    [UIView animateWithDuration:1
                          delay:6.5
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         bliaYaLogo2016.alpha=1;
                         
                     }
                     completion:^(BOOL finished){
                         NSLog(@"結束66666666666");
                         self.sponsorLabel.hidden=NO;

                         self.facebookLinkBtn.hidden=NO;
                         animator=[[UIDynamicAnimator alloc]initWithReferenceView:self.view];
                         CGPoint fbBtnPoint;
                         fbBtnPoint.x=self.linkButtonView.frame.origin.x+self.linkButtonView.frame.size.width/5;
                         fbBtnPoint.y=self.linkButtonView.frame.origin.y+self.linkButtonView.frame.size.height*3/5;
                         
                         UISnapBehavior * snapBehavior1=[[UISnapBehavior alloc]initWithItem:self.facebookLinkBtn snapToPoint:fbBtnPoint];
                         snapBehavior1.damping=0.2;
                         [animator addBehavior:snapBehavior1];
                         
                         self.googleplusLinkBtn.hidden=NO;
                         CGPoint gpBtnPoint;
                         gpBtnPoint.x=self.linkButtonView.frame.origin.x+self.linkButtonView.frame.size.width/2;
                         gpBtnPoint.y=self.linkButtonView.frame.origin.y+self.linkButtonView.frame.size.height*3/5;
                         UISnapBehavior * snapBehavior2=[[UISnapBehavior alloc]initWithItem:self.googleplusLinkBtn snapToPoint:gpBtnPoint];
                         snapBehavior2.damping=0.2;
                         [animator addBehavior:snapBehavior2];
                         
                         self.youtubeLinkBtn.hidden=NO;
                         CGPoint ybBtnPoint;
                         ybBtnPoint.x=self.linkButtonView.frame.origin.x+self.linkButtonView.frame.size.width*4/5;
                         ybBtnPoint.y=self.linkButtonView.frame.origin.y+self.linkButtonView.frame.size.height*3/5;
                         UISnapBehavior * snapBehavior3=[[UISnapBehavior alloc]initWithItem:self.youtubeLinkBtn snapToPoint:ybBtnPoint];
                         snapBehavior3.damping=0.2;
                         [animator addBehavior:snapBehavior3];
                     }];



}


@end
