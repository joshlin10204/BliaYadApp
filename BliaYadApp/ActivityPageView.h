//
//  ActivityPageView.h
//  BliaYadApp
//
//  Created by User on 2016/3/27.
//  Copyright © 2016年 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuView.h"

@interface ActivityPageView : UIViewController<MenuViewDelegate,NSURLConnectionDelegate,UITableViewDelegate,UITableViewDataSource>
{
    MenuView *menuView;
}


@end
