//
//  MenuView.h
//  BliaYadApp
//
//  Created by User on 2016/3/20.
//  Copyright © 2016年 User. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum MenuViewListPageType
{
    MenuViewPageTypeHomePage  = 1,
    MenuViewPageTypeActivityPage,
    MenuViewPageTypeMyTicketPage,
    MenuViewPageTypeWebsitePage,
    MenuViewPageTypeFaceBookPage,
    MenuViewPageTypeContactPage

} MenuViewListPageType;


@protocol MenuViewDelegate <NSObject>

@required

- (void) selectMenuCell:(MenuViewListPageType)page;


@end




@interface MenuView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) id<MenuViewDelegate> delegate;

@property (strong, nonatomic) IBOutlet UIView *menuBasicView;
@property (weak, nonatomic) IBOutlet UIView *menuHeaderView;
@property (weak, nonatomic) IBOutlet UIButton *privacyStatementButton;

@end
