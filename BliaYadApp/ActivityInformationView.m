//
//  ActivityInformationView.m
//  BliaYadApp
//
//  Created by User on 2016/4/5.
//  Copyright © 2016年 User. All rights reserved.
//

#import "ActivityInformationView.h"
#import "ActivityPageView.h"
#import "ActivityInformationTopCell.h"
#import "ActivityInformationCell.h"



@interface ActivityInformationView ()
{
    UITableView* activityInformationTableView;

}
@property (weak, nonatomic) IBOutlet UIView *singUpBtnBackgroundView;
@property (weak, nonatomic) IBOutlet UIButton *singUpButton;

@end

@implementation ActivityInformationView

- (void)viewDidLoad
{
    [super viewDidLoad];

    activityInformationTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];

    [activityInformationTableView registerNib:[UINib nibWithNibName:@"ActivityInformationTopCell"
                                                  bundle:nil]
            forCellReuseIdentifier:@"ActivityInformationTopCell"];
    [activityInformationTableView registerNib:[UINib nibWithNibName:@"ActivityInformationCell"
                                                             bundle:nil]
                       forCellReuseIdentifier:@"ActivityInformationCell"];

    activityInformationTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    activityInformationTableView.delegate=self;
    activityInformationTableView.dataSource=self;

    //讓TableVIew 不會被擋住
    activityInformationTableView.contentInset=UIEdgeInsetsMake(0, 0,self.singUpBtnBackgroundView.frame.size.height+self.singUpBtnBackgroundView.frame.size.height/3, 0);
    [self.view addSubview:activityInformationTableView];
    [self.view sendSubviewToBack:activityInformationTableView];

    self.singUpButton.layer.cornerRadius=15;
    NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Registration", @"LocalizationPlist", nil)];
    [self.singUpButton setTitle:text forState:0];
    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewDidAppear:(BOOL)animated
{


}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *topCellID = @"ActivityInformationTopCell";
    static NSString *cellID = @"ActivityInformationCell";
    
    ActivityInformationTopCell *topCell = [tableView dequeueReusableCellWithIdentifier:topCellID];
    ActivityInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    topCell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

    if (indexPath.row==0)
    {
        
        topCell.activityInfoTitleLabel.text=[self.choiceActivityInfoDictionary objectForKey:@"actionname"];
        topCell.activityInfoLocationLabel.text=[self.choiceActivityInfoDictionary objectForKey:@"location"];
        
        NSString *begenDate=[self.choiceActivityInfoDictionary objectForKey:@"begindate"];
        NSString *endDate=[self.choiceActivityInfoDictionary objectForKey:@"enddate"];
        topCell.activityInfoDateLabel.text=[NSString stringWithFormat:@"%@ - %@",begenDate,endDate];
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *urlString=[self.choiceActivityInfoDictionary objectForKey:@"photopath"];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (image!=nil)
                {
                    topCell.activityInfoImage.contentMode=UIViewContentModeScaleAspectFill;
                    topCell.activityInfoImage.clipsToBounds=YES;
                    topCell.activityInfoImage.image=image;
                    
                }
                
                
                
            });
        });

        
        
        return topCell;
        
    }
    else if(indexPath.row==1)
    {
        NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Date of Application", @"LocalizationPlist", nil)];
        cell.activityInfoItemLabel.text=text;
        NSString *registrationBegenDate=[self.choiceActivityInfoDictionary objectForKey:@"actionbegindate"];
        NSString *registrationEndDate=[self.choiceActivityInfoDictionary objectForKey:@"actionexpiredate"];
        cell.activityInfoDetailLabel.text=[NSString stringWithFormat:@"%@ - %@",registrationBegenDate,registrationEndDate];
        
        return cell;
        
    }
    else if(indexPath.row==2)
    {
        NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Activities introduction", @"LocalizationPlist", nil)];
        cell.activityInfoItemLabel.text=text;
        cell.activityInfoDetailLabel.text=[self.choiceActivityInfoDictionary objectForKey:@"description"];
        
        return cell;
        
    }
    else
    {
        NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"Main Organizer", @"LocalizationPlist", nil)];
        cell.activityInfoItemLabel.text=text;
        cell.activityInfoDetailLabel.text=[self.choiceActivityInfoDictionary objectForKey:@"masterdept"];
        
        return cell;
        
    }
    

    

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        CGFloat collectionViewHight=activityInformationTableView.frame.size.height;
        
        
        return collectionViewHight * 1/2;
    }
    else
    {
        CGFloat collectionViewHight=activityInformationTableView.frame.size.height;
        
        
        return collectionViewHight * 1/4;
    
    }
    
    

}
- (IBAction)onClickSingUpActivity:(id)sender
{
    NSString* urlString=[self.choiceActivityInfoDictionary objectForKey:@"actionurl"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];

}


@end
