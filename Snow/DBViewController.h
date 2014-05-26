//
//  DBViewController.h
//  Snow
//
//  Created by 靳杰 on 14-5-22.
//  Copyright (c) 2014年 JinJay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphKit.h"

@interface DBViewController : UIViewController<GKLineGraphDataSource>
+ (id)getInstance;
@end
