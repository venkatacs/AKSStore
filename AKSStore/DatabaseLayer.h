//
//  DatabaseLayer.h
//  AKSStore
//
//  Created by surya on 9/18/17.
//  Copyright © 2017 surya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseLayer : NSObject

- (instancetype)initWithDatabase:(NSString *)myDB;
- (NSArray *)loadData:(NSString *)query;
- (void) executeQuery:(NSString *)query;

@property (nonatomic, strong) NSMutableArray *arrColNames;
@property (nonatomic) int rowsChanged;
@property (nonatomic) long long lastInsertedRowID;

@end
