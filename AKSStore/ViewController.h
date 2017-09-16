//
//  ViewController.h
//  AKSStore
//
//  Created by surya on 9/15/17.
//  Copyright © 2017 surya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    NSArray *categoriesArray;
    NSMutableArray *subMenuArray;
}
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;


@end

