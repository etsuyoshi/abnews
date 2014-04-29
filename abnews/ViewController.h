//
//  ViewController.h
//  NewsAbst
//
//  Created by 遠藤 豪 on 2014/02/08.
//  Copyright (c) 2014年 endo.news. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseManage.h"
//#import "TextAnalysis.h"
//#import "ArticleCell.h"
//#import "BackgroundView.h"
@class BackgroundView;
#import "TabBar.h"
#import "CreateComponentClass.h"
#import "Preservation.h"

//#import "Mecab.h"
//#import "Node.h"

#import "ArticleData.h"
#import "TextViewController.h"

@interface ViewController : UIViewController{
    //    Mecab *mecab;
    BackgroundView *backgroundView;
//    TabBar *tabBar;
}

//@property (nonatomic) Mecab *mecab;
//@property (nonatomic) TabBar *tabBar;

-(void)moveRightTab;
-(void)moveLeftTab;
@end
