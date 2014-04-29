//
//  TabBar.m
//  abnews
//
//  Created by 遠藤 豪 on 2014/04/28.
//  Copyright (c) 2014年 endo.neural. All rights reserved.
//

#import "TabBar.h"

@implementation TabBar

int widthUnit;

-(id)initWithTable:(NSArray *)arrTable{
    //縦スクロールする場合は以下の長さを変更する
    self = [super
            initWithFrame:
            CGRectMake(0, 0,
                       [UIScreen mainScreen].bounds.size.width,
                       50)];
    if(self){
        widthUnit = 100;
        self.contentSize = CGSizeMake(widthUnit * [arrTable count], self.bounds.size.height);
        //インジケータ非表示
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        //背景色
        self.backgroundColor = [UIColor whiteColor];
        
        
        TableType tableType;
//        NSString *strName;
        //名称表示
        for(int i = 0;i < [arrTable count];i++){
            tableType = ((ArticleTable *)arrTable[i]).tableType;
            
            UILabel *lblName =
            [[UILabel alloc]
        initWithFrame:
            CGRectMake(i*widthUnit, 0, widthUnit, self.bounds.size.height)];
//            strName = nil;
            [self addSubview:lblName];
            switch (tableType) {
                case TableTypeArts:{
                    lblName.text = @"芸術";
                    break;
                }
                case TableTypeBlog:{
                    lblName.text = @"ブログ";
                    break;
                }
                case TableTypeBusiness:{
                    lblName.text = @"ビジネス";
                    break;
                }
                default:{
                    lblName.text = @"その他";
                    break;
                }
            }
            
            
        }
    }
    
    return self;
}


@end
