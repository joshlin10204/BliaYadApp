//
//  MyTicketPageView.h
//  BliaYadApp
//
//  Created by User on 2016/4/18.
//  Copyright © 2016年 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuView.h"


@interface MyTicketPageView : UIViewController<MenuViewDelegate,NSURLConnectionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    MenuView *menuView;
}

@end
