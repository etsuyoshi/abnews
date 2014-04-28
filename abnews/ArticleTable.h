//
//  ArticleTable.h
//  NewsAbst
//
//  Created by 遠藤 豪 on 2014/02/10.
//  Copyright (c) 2014年 endo.news. All rights reserved.
//
#import "DatabaseManage.h"
#import "ArticleCell.h"
#import "CreateComponentClass.h"
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, TableType) {
    TableTypeSports,
    TableTypeTechnology,
    TableTypeArts,
    TableTypeBusiness,
    TableTypeFinance,
    TableTypeEntertainment,
    TableTypeBlog,
    TableTypePolitics,
    TableTypeMatome
};

@interface ArticleTable : UIView <UIScrollViewDelegate>

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) TableType tableType;
@property (nonatomic) UIColor *cellColor;
@property (nonatomic) NSMutableArray *arrCells;
-(id)initWithType:(TableType)tableType;
-(void)addCell:(ArticleCell *)articleCell;

-(void)scrollViewDidScroll:(UIScrollView *)scrollView;
@end
