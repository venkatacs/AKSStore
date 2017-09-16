//
//  ViewController.m
//  AKSStore
//
//  Created by surya on 9/15/17.
//  Copyright © 2017 surya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.categoryTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    NSDictionary *plistData = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CustomList" ofType:@"plist"]];
    
    categoriesArray = [plistData valueForKey:@"Objects"];
    
    subMenuArray = [[NSMutableArray alloc] init];
    
    [subMenuArray addObjectsFromArray:categoriesArray];
    
    
    
}

#pragma mark - TableView Datasoruce Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [subMenuArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *categoryTableIdentfier = @"CategoryCell";
    
    UITableViewCell *categoryCell = [tableView dequeueReusableCellWithIdentifier:categoryTableIdentfier];
    
    if(categoryCell == nil) {
        categoryCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:categoryTableIdentfier];
    }

    categoryCell.textLabel.text = [[subMenuArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    [categoryCell setIndentationLevel:[[[subMenuArray objectAtIndex:indexPath.row] valueForKey:@"level"] intValue]];
    [categoryCell setIndentationWidth:[[[subMenuArray objectAtIndex:indexPath.row] valueForKey:@"level"] intValue]*20];
    
    if ([[[subMenuArray objectAtIndex:indexPath.row] valueForKey:@"level"] intValue] == 0) {
        [categoryCell setBackgroundColor:[UIColor lightGrayColor]];
    }
    else{
        [categoryCell setBackgroundColor:[UIColor whiteColor]];
    }

    return categoryCell;
}


#pragma mark - TableView Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0f;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *arrayDictionary = [subMenuArray objectAtIndex:indexPath.row];
    
    if ([arrayDictionary valueForKey:@"Objects"]) {
        
        NSArray *subArray = [arrayDictionary valueForKey:@"Objects"];
        
        BOOL inserted = NO;
        
        for (NSDictionary *innerMenu in subArray) {
            NSInteger index = [subMenuArray indexOfObjectIdenticalTo:innerMenu];
            inserted = (index>0 && index != NSIntegerMax);
            if (inserted) {
                break;
            }
        }
        if (inserted) {
            //mimize the submenu
            [self minimizeSubMenu:subArray];
        }
        else
        {
            NSUInteger count = indexPath.row + 1;
            NSMutableArray *arrayCells = [NSMutableArray array];
            
            for (NSDictionary *innerMenu in subArray) {
                [arrayCells addObject:[NSIndexPath indexPathForRow:count inSection:0]];
                [subMenuArray insertObject:innerMenu atIndex:count++];
            }
            [tableView setBackgroundColor:[UIColor whiteColor]];
            [tableView insertRowsAtIndexPaths:arrayCells withRowAnimation:UITableViewRowAnimationAutomatic];
            
        }
    }
}

#pragma mark - User Methods

- (void) minimizeSubMenu:(NSArray*) subArray
{
    for (NSDictionary *innerMenu in subArray) {
        NSUInteger indexToRemove = [subMenuArray indexOfObjectIdenticalTo:innerMenu];
        
        NSArray *innerArrayForMenu = [innerMenu valueForKey:@"Objects"];
        
        if (innerArrayForMenu && [innerArrayForMenu count] > 0) {
            [self minimizeSubMenu:innerArrayForMenu];
        }
        
        if ([subMenuArray indexOfObjectIdenticalTo:innerMenu]!= NSNotFound) {
            [subMenuArray removeObjectIdenticalTo:innerMenu];
            [_categoryTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexToRemove inSection:0]] withRowAnimation:UITableViewRowAnimationRight];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
