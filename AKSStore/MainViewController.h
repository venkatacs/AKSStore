//
//  MainViewController.h
//  AKSStore
//
//  Created by surya on 9/17/17.
//  Copyright © 2017 surya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITabBarDelegate>
{
    UIStoryboard *mainStoryboard ;
}
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITabBar *sbTabBar;
@property (nonatomic, retain)UIViewController *browseViewController;
@property (nonatomic, retain)UIViewController *pSearchViewController;
@property (nonatomic, retain)UIViewController *vSearchViewController;

@end
