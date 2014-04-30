//
//  TabBar.m
//  abnews
//
//  Created by 遠藤 豪 on 2014/04/28.
//  Copyright (c) 2014年 endo.neural. All rights reserved.
//

#import "TabBar.h"

@implementation TabBar
@synthesize noForcus;
@synthesize arrLabel;


int widthUnit;
int heightUnit;



-(id)initWithTable:(NSArray *)arrTable{
    
    return [self initWithTable:arrTable
                      forcusTo:0];
}
-(id)initWithTable:(NSArray *)arrTable
          forcusTo:(int)noForcusArg{//表示されている背景画像番号(カテゴリー)
    //縦スクロールする場合は以下の長さを変更する
    heightUnit = 30;
    
    self = [super
            initWithFrame:
            CGRectMake(0, 0,
                       [UIScreen mainScreen].bounds.size.width,
                       heightUnit)];
    
    if(self){
        self.noForcus = noForcusArg;
        widthUnit = 100;
        self.contentSize = CGSizeMake(widthUnit * [arrTable count], self.bounds.size.height);
        //インジケータ非表示
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        //背景色
        self.backgroundColor = [UIColor whiteColor];
        //操作
        [self setScrollEnabled:NO];
        
        self.arrLabel = [NSMutableArray array];
        
        TableType tableType;
//        NSString *strName;
        //名称表示
        for(int i = 0;i < [arrTable count];i++){
            tableType = ((ArticleTable *)arrTable[i]).tableType;
            
//            UILabel *lblName =
            
            [self.arrLabel addObject:
             [[UILabel alloc]
              initWithFrame:
              CGRectMake(i*widthUnit, 0, widthUnit, self.bounds.size.height)]
             ];
//            lblName.textAlignment = NSTextAlignmentCenter;//水平方向中心
            ((UILabel *)[arrLabel lastObject]).textAlignment = NSTextAlignmentCenter;//水平方向中心
            
//            NSLog(@"color = %f",(double)i/(double)[arrTable count]);
            //temporary-color:実際には以下のswitch-caseで個別に指定する
//            ((UILabel *)[arrLabel lastObject]).backgroundColor =
//            [UIColor colorWithRed:(double)i/(double)[arrTable count]
//                            green:0
//                             blue:1
//                            alpha:0.5f];
            
            ((UILabel *)[arrLabel lastObject]).font = [UIFont systemFontOfSize:12];
            ((UILabel *)[arrLabel lastObject]).textColor = [self getTextColor:i];
            [self addSubview:((UILabel *)[arrLabel lastObject])];
            switch (tableType) {
                case TableTypeArts:{
                    ((UILabel *)[arrLabel lastObject]).text = @"芸術";
                    break;
                }
                case TableTypeBlog:{
                    ((UILabel *)[arrLabel lastObject]).text = @"ブログ";
                    break;
                }
                case TableTypeBusiness:{
                    ((UILabel *)[arrLabel lastObject]).text = @"ビジネス";
                    break;
                }
                case TableTypeEntertainment:{
                    ((UILabel *)[arrLabel lastObject]).text = @"エンタ";
                    break;
                }
                case TableTypeFinance:{
                    ((UILabel *)[arrLabel lastObject]).text = @"金融";
                    break;
                }
                case TableTypeMatome:{
                    ((UILabel *)[arrLabel lastObject]).text = @"まとめ";
                    
                    break;
                }
                case TableTypePolitics:{
                    ((UILabel *)[arrLabel lastObject]).text = @"政治";
                    break;
                }
                case TableTypeSports:{
                    ((UILabel *)[arrLabel lastObject]).text = @"スポーツ";
                    break;
                }
                case TableTypeTechnology:{
                    ((UILabel *)[arrLabel lastObject]).text = @"テクノロジー";
                    break;
                }
                default:{
                    ((UILabel *)[arrLabel lastObject]).text = @"その他";
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
    NSLog(@"move left from tabbar");
    [UIView
     animateWithDuration:0.5f
     animations:^{
         if(self.noForcus < [self.arrLabel count]-1 &&
            self.noForcus > 1){//左側にタブがないときはタブ移動しない
             self.contentOffset =
             CGPointMake(self.contentOffset.x - widthUnit,
                         self.contentOffset.y);
         }
     }
     completion:^(BOOL finished){
         if(finished){
             NSLog(@"content = %d", (int)self.contentOffset.x);
//             NSLog(@"noStatus = %d", noStatus);
             self.noForcus --;
             [self setLabelColorAll];
         }
     }];
}

-(void)moveRight{
    NSLog(@"move right from tabbar, %d, %d",
          self.noForcus,(int)[self.arrLabel count]);
    [UIView
     animateWithDuration:0.5f
     animations:^{
         if(self.noForcus < [self.arrLabel count]-2 &&
            self.noForcus > 0){
             self.contentOffset =
             CGPointMake(self.contentOffset.x + widthUnit,
                         self.contentOffset.y);
         }
     }
     completion:^(BOOL finished){
         if(finished){
             NSLog(@"content = %d", (int)self.contentOffset.x);
             
             self.noForcus ++;
             [self setLabelColorAll];
         }
     }];
    
    
}


-(UIColor *)getTextColor:(int)no{
    if(no == self.noForcus){
        return [UIColor blueColor];
    }else{
        return [UIColor grayColor];
    }
    
}

-(void)setLabelColorAll{
    for(int i = 0;i < [arrLabel count];i++){
        ((UILabel *)arrLabel[i]).textColor = [self getTextColor:i];
    }
}

@end
