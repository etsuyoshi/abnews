//
//  ArticleTile.m
//  Newsab
//
//  Created by 遠藤 豪 on 2014/02/08.
//  Copyright (c) 2014年 endo.news. All rights reserved.
//

#define LOG false
#import "ArticleCell.h"
#import "TextViewController.h"

@implementation ArticleCell
//@synthesize strTitle;
//@synthesize text = _text;
@synthesize articleData;
//@synthesize imv = _imv;


//-(id)initWithFrame:(CGRect)frame{
//
//    return [self initWithFrame:frame
//                      withText:(NSString *)_text];
//}
//-(id)initWithFrame:(CGRect)frame withText:(NSString *)_textArg{
//    self = [super initWithFrame:frame];
//    NSLog(@"text=%@", _textArg);
//
//
//
//    if(self){
//        [self initializerWithText:_textArg];
//        self.text = _textArg;
//
//    }
//
//    return self;
//}

-(id)initWithFrame:(CGRect)frame
   withArticleData:(ArticleData *)_articleData{
    self = [super initWithFrame:frame];
    self.articleData = _articleData;
    
#if LOG
    NSLog(@"ArticleCell initWithArticleData : %@",
          self.articleData.title);
#endif
    
    if(self){
        [self initializerWithText:self.articleData];
        
        
    }
    
    return self;
}



-(void)initializerWithText:(ArticleData *)_articleData{
    @autoreleasepool {
        //デフォルト値：インスタンス化した後も設定可能
        self.translucentAlpha = 0.8f;
        self.translucentStyle = UIBarStyleDefault;
        self.translucentTintColor = [UIColor yellowColor];
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *uil = [[UILabel alloc] init];
        uil.frame = self.bounds;
        uil.backgroundColor = [UIColor clearColor];
        
        //文字色はセルの色(＝カテゴリ)によって変えていく必要がある
        if(_articleData.category == 0){
            uil.textColor = [UIColor blueColor];
        }else{//いろいろ試行錯誤していく必要あり
            uil.textColor = [UIColor yellowColor];
        }
        uil.font = [UIFont fontWithName:@"AppleGothic" size:12];
        uil.textAlignment = NSTextAlignmentCenter;
        uil.text = [NSString stringWithFormat:@"【%@】\n%@,\n<%@>",
                    _articleData.title,
                    _articleData.strSentence,
                    _articleData.strKeyword];
        uil.numberOfLines = 5;
        //        NSLog(@"text=%@", _strText);
        [self addSubview:uil];
    }
}



@end
