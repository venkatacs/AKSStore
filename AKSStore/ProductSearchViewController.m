//
//  ProductSearchViewController.m
//  AKSStore
//
//  Created by surya on 9/17/17.
//  Copyright © 2017 surya. All rights reserved.
//

#import "ProductSearchViewController.h"
#import "ProductDetails.h"
#import "DatabaseLayer.h"
#import "SearchViewCell.h"

@interface ProductSearchViewController ()

@property (nonatomic, strong) DatabaseLayer *dbLayer;

-(void) loadProductDetails;

@end

@implementation ProductSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dbLayer = [[DatabaseLayer alloc] initWithDatabase:@"AKS.db"];
    self.productArray = [[NSMutableArray alloc]init];
    self.productTable.delegate = self;
    self.productTable.dataSource = self;
    [self loadProductDetails];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadProductDetails
{
    NSString *query = @"select * from product_details";
    
    if (self.productArray != nil) {
        self.productArray = nil;
    }
    self.productArray = [[NSMutableArray alloc] initWithArray:[self.dbLayer loadData:query]];
    
    NSLog(@"%@", self.productArray);
    
    [self.productTable reloadData];
}


#pragma mark - TableView Datasource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.productArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ProductSearchCell";
    SearchViewCell *searchViewCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    ProductDetails *pDetails = (self.productArray)[indexPath.row];
    
    searchViewCell.productName.text = pDetails.productName;
    searchViewCell.productDesc.text = pDetails.productDescription;
    searchViewCell.productPrice.text = [NSString stringWithFormat:@"$%@",pDetails.productPrice];
    
    return searchViewCell;
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
