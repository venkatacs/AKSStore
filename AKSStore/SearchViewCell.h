//
//  SearchViewCell.h
//  AKSStore
//
//  Created by surya on 9/18/17.
//  Copyright © 2017 surya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *productName;
@property (weak, nonatomic) IBOutlet UITextView *productPrice;
@property (weak, nonatomic) IBOutlet UITextView *productDesc;
@property (weak, nonatomic) IBOutlet UITextView *inStockOrNot;

@end
