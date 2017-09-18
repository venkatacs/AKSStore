//
//  ProductSearchViewController.h
//  AKSStore
//
//  Created by surya on 9/17/17.
//  Copyright © 2017 surya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductSearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *productTable;

@property (nonatomic, strong) NSMutableArray *productArray;

@end
