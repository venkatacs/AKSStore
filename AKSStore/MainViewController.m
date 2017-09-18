//
//  MainViewController.m
//  AKSStore
//
//  Created by surya on 9/17/17.
//  Copyright © 2017 surya. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"
#import "ProductSearchViewController.h"
#import "VehicleSearchViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize browseViewController;
@synthesize pSearchViewController;
@synthesize vSearchViewController;

const CGFloat tbHeight = 20;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:30.0f green:144.0f blue:255.0f alpha:0];
    }
    else{
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:30.0f green:144.0f blue:255.0f alpha:0];
        self.navigationController.navigationBar.translucent = NO;
    }
    
     mainStoryboard = self.storyboard;
    _sbTabBar.delegate = self;
    
    //First Default selection and View
    [_sbTabBar setSelectedItem: [_sbTabBar.items objectAtIndex:0]];
    if (browseViewController == nil) {
        browseViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"ViewController"];
    }
    [self.containerView addSubview:browseViewController.view];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TabBar Delegate Methods

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    switch (item.tag) {
        case 1:
            if (browseViewController == nil) {
                browseViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"ViewController"];
            }
            [self.containerView addSubview:browseViewController.view];
            
            break;
        case 2:
            if (pSearchViewController == nil) {
                pSearchViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"ProductSearchViewController"];
            }
            [self.containerView addSubview:pSearchViewController.view];
            
            break;
        case 3:
            if (vSearchViewController == nil) {
                vSearchViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"VehicleSearchViewController"];
            }
            [self.containerView addSubview:vSearchViewController.view];
            
            break;
        default:
            
            
            break;
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
