//
//  BackgroundView.h
//  NewsAbst
//
//  Created by 遠藤 豪 on 2014/02/10.
//  Copyright (c) 2014年 endo.news. All rights reserved.
//

#import "ArticleTable.h"
#import <UIKit/UIKit.h>
//#import "TabBar.h"
@class ViewController;//循環参照を回避するためimportせずにコンパイラディレクティブにする
//@class TabBar;
@interface BackgroundView : UIImageView{
    ViewController *viewController;
//    TabBar *tabBar;
}


@property (nonatomic) NSMutableArray *arrTable;
- (id)initWithTable:(NSArray *)_arrTableArg;
@end
