//
//  MyTicketPageView.m
//  BliaYadApp
//
//  Created by User on 2016/4/18.
//  Copyright © 2016年 User. All rights reserved.
//

#import "MyTicketPageView.h"
#import "ActivityTableViewCell.h"


@interface MyTicketPageView ()
{

    UIView * menuViewBackground;
    UITableView *activityTableView;
    NSMutableArray * allActivityDictionary;
    NSMutableArray * userActivityDictionary;

    UIActivityIndicatorView *loadIndicatorView;
    BOOL isSearchRegisteredActivity;
    int checkActivityNumber;


}

@end

@implementation MyTicketPageView

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    userActivityDictionary =[NSMutableArray array];
    
    
    self.navigationItem.hidesBackButton = YES;
    NSString*text =[NSString stringWithFormat:NSLocalizedStringFromTable(@"My Activity QRCode", @"LocalizationPlist", nil)];
    self.navigationItem.title=text;
    
    isSearchRegisteredActivity=NO;

    activityTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height)];
    [activityTableView registerNib:[UINib nibWithNibName:@"ActivityTableViewCell"
                                                  bundle:nil]
            forCellReuseIdentifier:@"ActivityTableViewCell"];
    
    activityTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    activityTableView.delegate=self;
    activityTableView.dataSource=self;
    [self.view addSubview:activityTableView];
//
//    
    loadIndicatorView=[[UIActivityIndicatorView alloc]initWithFrame:CGRectZero];
    [loadIndicatorView setCenter:self.view.center];
    [loadIndicatorView setHidesWhenStopped:YES];
    
    [loadIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [loadIndicatorView setColor:[UIColor grayColor]];
    
    [self.view addSubview:loadIndicatorView];
    
    [loadIndicatorView startAnimating];

    [self onLoadURLData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [self initMenuView];
    
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

        NSLog(@"收到;%u",page);
        
    }
    else if(page==MenuViewPageTypeMyTicketPage)
    {
        NSLog(@"收到;%u",page);
        
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
        [self onClickMenuButton:nil];
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        id contactPageView = [storyboard instantiateViewControllerWithIdentifier:@"ContactPageView"];
        
        [self.navigationController pushViewController:contactPageView animated:YES];
        
    }
 
    
}

#pragma mark - Loading Activity Data

-(void)onLoadURLData
{

    dispatch_queue_t serialQueue = dispatch_queue_create("serial_queue",
                                                         DISPATCH_QUEUE_SERIAL);
    dispatch_async(serialQueue, ^{
        NSLog(@"s1");
        NSString *url=@"http://61.216.101.65/actionservice/service/actions/allactions";
        [self onLoadURLActivityData:url];
    });
    dispatch_async(serialQueue, ^{
        sleep(2);
        NSLog(@"s2");
        isSearchRegisteredActivity=YES;
        
        for (int i=0; i<allActivityDictionary.count; i++)
        {
            NSString * actionId=[[allActivityDictionary objectAtIndex:i]objectForKey:@"id"];
            NSString *url=[NSString stringWithFormat:@"http://61.216.101.65/actionservice/service/Actions/GetactionConfirm?actionid=%@&uuid=7AA4BC7E-5686-45FD-907A-97F3395B2E36",actionId];
            [self onLoadURLActivityData:url];
            
            checkActivityNumber=i;
            
        }
        
        


    });
    

    

}

-(void)onLoadURLActivityData:(NSString*)urlAdress
{
    NSLog(@"Loading....");
    
    NSURL *url=[NSURL URLWithString:urlAdress];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          
                                          if (!error)
                                          {
                                              
                                              [self onAnalyzeJsonData:data];
                                              
                                              
                                          }
                                          else
                                          {
                                              NSLog(@"ERROR :%@",error);
                                            
                                              
                                          }
                                          
                                      }];
    [dataTask resume];
    
    
}

- (void)onAnalyzeJsonData:(NSData *)jsonData
{
    
    if (isSearchRegisteredActivity)
    {
        NSError *error = nil;
        NSMutableDictionary* jsonObjectDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                          options:NSJSONReadingMutableContainers
                                                                            error:&error];
        

        if (jsonObjectDictionary != nil && error == nil)
        {
            
            [self checkRegisteredActivity:jsonObjectDictionary];
            
        }
        else
        {
            // 解析错误
            NSLog(@"error!!!");
        }
    }
    else
    {
        NSError *error = nil;
        NSMutableArray* jsonObjectArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                          options:NSJSONReadingMutableContainers
                                                                            error:&error];
        
        NSLog(@"jsonObjectArray:%@",jsonObjectArray
              );
        if (jsonObjectArray != nil && error == nil)
        {
            
            
            allActivityDictionary =jsonObjectArray;
            
        }
        else
        {
            // 解析错误
            NSLog(@"error!!!");
        }
    
    }
    
    
}
-(void)checkRegisteredActivity:(NSMutableDictionary*)jsonObjectDictionary
{
    if ([[jsonObjectDictionary objectForKey:@"id"] isEqualToString:@"none"])
    {
        [allActivityDictionary removeObjectAtIndex:checkActivityNumber];
        
        
    }
    else
    {
        [userActivityDictionary addObject:jsonObjectDictionary];
        NSLog(@"userActivityDictionary :%@",userActivityDictionary);
        NSLog(@"allActivityDictionary :%@",allActivityDictionary);

    
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [activityTableView reloadData];
            [loadIndicatorView stopAnimating];
            
            
        });
    });


}

#pragma mark - Activity TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [allActivityDictionary count];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"ActivityTableViewCell";
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.activityTitleLabel.text=[[allActivityDictionary objectAtIndex:indexPath.row]objectForKey:@"actionname"];
    cell.activityDateLabel.text=[[allActivityDictionary objectAtIndex:indexPath.row]objectForKey:@"begindate"];
    cell.activityLocationLabel.text=[[allActivityDictionary objectAtIndex:indexPath.row]objectForKey:@"location"];
    
    if (userActivityDictionary.count!=0)
    {
        NSLog(@"userActivityDictionary:%@",[userActivityDictionary objectAtIndex:indexPath.row]);
        NSString *qrcoebase64String=[[userActivityDictionary objectAtIndex:indexPath.row]objectForKey:@"qrData"];
        NSData* data = [[NSData alloc] initWithBase64EncodedString:qrcoebase64String options:0];
        cell.activityImage.image= [UIImage imageWithData:data];

    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat collectionViewHight=activityTableView.frame.size.height;
    
    
    return collectionViewHight * 50/100;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"indexPath :%ld",(long)indexPath.row);
//    [self performSegueWithIdentifier:@"goActivityInformationView" sender:self];
//    
//    
//}
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    NSIndexPath *selectedRowIndex = [activityTableView indexPathForSelectedRow];
//    ActivityInformationView *activityInformationView=[segue destinationViewController];
//    activityInformationView.choiceActivityInfoDictionary=[allActivityDictionary objectAtIndex:selectedRowIndex.row];
//    
//    
//    NSLog(@"有進入！！:%ld",(long)selectedRowIndex.row);
//    
//}



#pragma mark - Serch Participate Activity Data


#pragma mark - Participate Activity TableView



@end
