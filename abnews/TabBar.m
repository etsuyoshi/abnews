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
int heightUnit;

-(id)initWithTable:(NSArray *)arrTable{
    //縦スクロールする場合は以下の長さを変更する
    heightUnit = 30;
    self = [super
            initWithFrame:
            CGRectMake(0, 0,
                       [UIScreen mainScreen].bounds.size.width,
                       heightUnit)];
    if(self){
        widthUnit = 100;
        self.contentSize = CGSizeMake(widthUnit * [arrTable count], self.bounds.size.height);
        //インジケータ非表示
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        //背景色
        self.backgroundColor = [UIColor whiteColor];
        //操作
        [self setScrollEnabled:NO];
        
        TableType tableType;
//        NSString *strName;
        //名称表示
        for(int i = 0;i < [arrTable count];i++){
            tableType = ((ArticleTable *)arrTable[i]).tableType;
            
            UILabel *lblName =
            [[UILabel alloc]
             initWithFrame:
             CGRectMake(i*widthUnit, 0, widthUnit, self.bounds.size.height)];
            lblName.textAlignment = NSTextAlignmentCenter;//水平方向中心
            
            if(i %2 == 0){
                lblName.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5f];
            }else{
                lblName.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.5f];
            }
            lblName.font = [UIFont systemFontOfSize:12];
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
                case TableTypeEntertainment:{
                    lblName.text = @"エンタ";
                    break;
                }
                case TableTypeFinance:{
                    lblName.text = @"金融";
                    break;
                }
                case TableTypeMatome:{
                    lblName.text = @"まとめ";
                    
                    break;
                }
                case TableTypePolitics:{
                    lblName.text = @"政治";
                    break;
                }
                case TableTypeSports:{
                    lblName.text = @"スポーツ";
                    break;
                }
                case TableTypeTechnology:{
                    lblName.text = @"テクノロジー";
                    break;
                }
                default:{
                    lblName.text = @"その他";
                    break;
                }
            }
        }//for-i
        
        //自動スクロール
        //self.contentOffset = CGPointMake(300, 0);
    }
    
    return self;
}


-(void)moveLeft{
    [UIView
     animateWithDuration:0.5f
     animations:^{
         self.contentOffset =
         CGPointMake(self.contentOffset.x - widthUnit,
                     self.contentOffset.y);
     }];
}

-(void)moveRight{
    [UIView
     animateWithDuration:0.5f
     animations:^{
         self.contentOffset =
         CGPointMake(self.contentOffset.x + widthUnit,
                     self.contentOffset.y);
     }];
}




@end
