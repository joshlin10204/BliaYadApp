//
//  MenuView.m
//  BliaYadApp
//
//  Created by User on 2016/3/20.
//  Copyright © 2016年 User. All rights reserved.
//

#import "MenuView.h"
#import "MenuTableViewCell.h"

#import "ActivityPageView.h"
#import "RegisteredView.h"

#import "PrivacyStatementView.h"

@interface MenuView ()
{
    UITableView *menuTableView;
    RegisteredView *registeredView;
    PrivacyStatementView *privacyStatementView;

}

@end

@implementation MenuView

- (instancetype)initWithFrame:(CGRect)frame {
    
    
    self = [super initWithFrame:frame];
    
    
    if (self)
    {
        
        
        [[NSBundle mainBundle]loadNibNamed:@"MenuView" owner:self options:nil];
        self.menuBasicView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.menuBasicView.layer.shadowColor = [[UIColor blackColor] CGColor];
        self.menuBasicView.layer.shadowOffset = CGSizeMake(3.0f, 3.0f); // [水平偏移, 垂直偏移]
        self.menuBasicView.layer.shadowOpacity = 0.5f; // 0.0 ~ 1.0 的值
        self.menuBasicView.layer.shadowRadius = 10.0f;
        [self addSubview:self.menuBasicView];
        
        
        CGRect menuTableViewRect;
        menuTableViewRect.origin.y=self.frame.size.height*20/100;
        menuTableViewRect.size.height=self.frame.size.height*77/100;
        menuTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, menuTableViewRect.origin.y, self.frame.size.width, menuTableViewRect.size.height)];
        
        menuTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        menuTableView.scrollEnabled=NO;
        [self addSubview:menuTableView];
        
        [menuTableView  setDelegate:self];
        [menuTableView setDataSource:self];
        [menuTableView registerNib:[UINib nibWithNibName:@"MenuTableViewCell"
                                                       bundle:nil]
                 forCellReuseIdentifier:@"MenuTableViewCell"];
        
        
        NSString*buttonText =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Privacy Statement", @"LocalizationPlist", nil)];
        [self.privacyStatementButton setTitle:buttonText forState:UIControlStateNormal];
        
    }
    
    return self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 6;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"MenuTableViewCell";
    
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

 
    if (indexPath.row==0)
    {
        
        
        NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Home", @"LocalizationPlist", nil)];
        cell.menuCellLable.text=text;
        cell.menuCellImage.image=[UIImage imageNamed:@"HomeImage.png"];
            
    }
    else if(indexPath.row==1)
    {

        NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Activity Information", @"LocalizationPlist", nil)];
        cell.menuCellLable.text=text;
        cell.menuCellImage.image=[UIImage imageNamed:@"ActivityImage.png"];

        
    }
    else if(indexPath.row==2)
    {
        NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"My Activity QRCode", @"LocalizationPlist", nil)];
        cell.menuCellLable.text=text;
        cell.menuCellImage.image=[UIImage imageNamed:@"TicketImage.png"];

        
    }
    else if(indexPath.row==3)
    {
        NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Taiwan YAD HQ Website", @"LocalizationPlist", nil)];

        cell.menuCellLable.text=text;
        cell.menuCellImage.image=[UIImage imageNamed:@"WebImage.png"];

    }

    else if(indexPath.row==4)
    {
        NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Facebook Fans Group", @"LocalizationPlist", nil)];
        cell.menuCellLable.text=text;
        cell.menuCellImage.image=[UIImage imageNamed:@"FBImage.png"];

        
    }
    else if(indexPath.row==5)
    {
        NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Contact Us", @"LocalizationPlist", nil)];
        cell.menuCellLable.text=text;
        cell.menuCellImage.image=[UIImage imageNamed:@"PhoneImage.png"];

    
    }
    
    
    
    
    
    return cell;
 }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat collectionViewHight=menuTableView.frame.size.height;
    
    
    return collectionViewHight * 1/8;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0)
    {
        [self.delegate selectMenuCell:MenuViewPageTypeHomePage];
    
    }
    else if(indexPath.row==1)
    {
        
        [self.delegate selectMenuCell:MenuViewPageTypeActivityPage];
            
    }
    else if(indexPath.row==2)
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *userUUID = [defaults objectForKey:@"userUUID"];
        if (userUUID ==nil)
        {
            NSLog(@"!!!!!!");
            
            registeredView=[RegisteredView initregisterView:self];
            
        }

        else
        {
            NSLog(@"!!userUUID:%@",userUUID);
            [self.delegate selectMenuCell:MenuViewPageTypeMyTicketPage];
        
        }
        

    }
    else if(indexPath.row==3)
    {
        [self.delegate selectMenuCell:MenuViewPageTypeWebsitePage];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.bliayad.org.tw"]];
    }

    else if(indexPath.row==4)
    {
        [self.delegate selectMenuCell:MenuViewPageTypeFaceBookPage];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/taiwanyad.headquarters/"]];

    }
    else if(indexPath.row==5)
    {
        [self.delegate selectMenuCell:MenuViewPageTypeContactPage];
        
    }
    
    

    



}

- (IBAction)onClickPrivacyStatementBtn:(id)sender
{


    privacyStatementView=[PrivacyStatementView initprivacyStatementViewView:self];
}


@end
