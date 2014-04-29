//
//  TabBar.h
//  abnews
//
//  Created by 遠藤 豪 on 2014/04/28.
//  Copyright (c) 2014年 endo.neural. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "ArticleCell.h"
//#import "ArticleData.h"
#import "ArticleTable.h"

@interface TabBar : UIScrollView

-(id)initWithTable:(NSArray *)arrTable;
-(void)moveLeft;
-(void)moveRight;
@end
