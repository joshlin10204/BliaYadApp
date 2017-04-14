//
//  ContactPageView.m
//  BliaYadApp
//
//  Created by User on 2016/4/12.
//  Copyright © 2016年 User. All rights reserved.
//

#import "ContactPageView.h"
#import <MapKit/MapKit.h>


@interface ContactPageView ()<MKMapViewDelegate,MKAnnotation>
{
    UIView * menuViewBackground;

}

@property (weak, nonatomic) IBOutlet MKMapView *contactLocationMapView;

@end

@implementation ContactPageView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Contact Us", @"LocalizationPlist", nil)];
    self.navigationItem.title=text;

    [self initContactLocationMapView];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self initMenuView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)initContactLocationMapView
{
    self.contactLocationMapView.delegate=self;
    self.contactLocationMapView.mapType=MKMapTypeStandard;
    MKCoordinateRegion region= self.contactLocationMapView.region;
    //定義地圖的縮放及位置
    
    region.center.latitude = 25.0485288;
    region.center.longitude = 121.57883;
    region.span.latitudeDelta=0.005;
    region.span.longitudeDelta=0.005;
    [self.contactLocationMapView setRegion:region animated:true];
    
    MKPointAnnotation *annotation=[MKPointAnnotation new];
    annotation.coordinate=CLLocationCoordinate2DMake(25.0485288, 121.57883);
    [self.contactLocationMapView addAnnotation: annotation ];


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
        [self onClickMenuButton:nil];
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        id viewController = [storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        
        [self.navigationController pushViewController:viewController animated:YES];
        
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
        NSLog(@"收到;%u",page);
        [self onClickMenuButton:nil];
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        id myTicketPageView = [storyboard instantiateViewControllerWithIdentifier:@"MyTicketPageView"];
        
        [self.navigationController pushViewController:myTicketPageView animated:YES];
    }
    else if(page==MenuViewPageTypeWebsitePage)
    {
        NSLog(@"收到;%u",page);
        
    }
    else if(page==MenuViewPageTypeFaceBookPage)
    {
        NSLog(@"收到;%u",page);
        
        
    }
    else if(page==MenuViewPageTypeContactPage)
    {
        NSLog(@"收到;%u",page);
        
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
