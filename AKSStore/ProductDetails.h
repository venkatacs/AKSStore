//
//  ProductDetails.h
//  AKSStore
//
//  Created by surya on 9/18/17.
//  Copyright © 2017 surya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetails : NSObject

@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *productDescription;
@property (nonatomic, copy) NSString *productPrice;
@property (nonatomic, copy) NSString *productInStock;

@end
