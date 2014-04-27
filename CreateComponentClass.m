//
//  CreateComponentClass.m
//  abnews
//
//  Created by 遠藤 豪 on 2014/04/27.
//  Copyright (c) 2014年 endo.neural. All rights reserved.
//

#import "CreateComponentClass.h"

@implementation CreateComponentClass



//manufact
+(UITextView *)createTextView:(CGRect)rect
                         text:(NSString *)text
                         font:(NSString *)font
                         size:(int)size
                    textColor:(UIColor *)textColor
                    backColor:(UIColor *)backColor
                   isEditable:(Boolean)isEditable{
    UITextView *tv = [[UITextView alloc]initWithFrame:rect];
    [tv setFont:[UIFont fontWithName:font size:size]];
    tv.text = [NSString stringWithFormat:@"%@", text];
    tv.textColor = textColor;
    tv.backgroundColor = backColor;
    tv.editable = isEditable;
    return tv;
    
    
    //    return nil;
}

//standard1
+(UIView *)createView{
    CGRect rect = CGRectMake(10, 50, 300, 400);
    return [self createView:rect];
    
}

//standard2
+(UIView *)createView:(CGRect)rect{
    UIColor *color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
    float cornerRadius = 10.0f;
    UIColor *borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
    float borderWidth = 2.0f;
    
    return [self createView:rect
                      color:color
               cornerRaidus:cornerRadius
                borderColor:borderColor
                borderWidth:borderWidth];
}

//manufact
+(UIView *)createView:(CGRect)rect
                color:(UIColor*)color
         cornerRaidus:(float)cornerRadius
          borderColor:(UIColor*)borderColor
          borderWidth:(float)borderWidth{
    
    
    UIView *view = [[UIView alloc]init];
    
    //            view.frame = self.view.bounds;//画面全体
    view.frame = rect;
    
    view.backgroundColor = color;
    //    view.alpha = alpha;
    
    //丸角にする
    [[view layer] setCornerRadius:cornerRadius];
    [view setClipsToBounds:YES];
    
    //UIViewに枠線を追加する
    [[view layer] setBorderColor:[borderColor CGColor]];
    [[view layer] setBorderWidth:borderWidth];
    
    //    [self.view bringSubviewToFront:view];
    //    [self.view addSubview:view];
    return view;
}

//manufact2:tapイベントを付ける(フレームなし)
+(UIView *)createViewNoFrame:(CGRect)rect
                       color:(UIColor *)color
                         tag:(int)tag
                      target:(id)target
                    selector:(NSString *)selName{
    //    UIView *v = [self createView:rect];
    UIView *v = [[UIView alloc]initWithFrame:rect];
    [v setBackgroundColor:color];
    v.tag = tag;
    v.userInteractionEnabled = YES;
    //NSSelectorFromString(selName)
    [v addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:target
                                                                   action:NSSelectorFromString(selName)]];
    return v;
}
//manufact3:tapイベントを付ける(デフォルトフレームあり)
+(UIView *)createViewWithFrame:(CGRect)rect
                         color:(UIColor *)color
                           tag:(int)tag
                        target:(id)target
                      selector:(NSString *)selName{
    
    return [self createViewWithFrame:rect
                               color:color
                                 tag:tag
                              target:target
                            selector:selName];
}

//manufact4:tapイベントを付ける(任意フレームあり)
+(UIView *)createViewWithFrame:(CGRect)rect
                         color:(UIColor *)color
                   borderColor:(UIColor *)borderColor
                           tag:(int)tag
                        target:(id)target
                      selector:(NSString *)selName{
    float cornerRadius = 10.0f;
    float borderWidth = 2.0f;
    
    UIView *v = [self createView:rect
                           color:color
                    cornerRaidus:cornerRadius
                     borderColor:borderColor
                     borderWidth:borderWidth];
    v.tag = tag;
    v.userInteractionEnabled = YES;
    [v addGestureRecognizer:
     [[UITapGestureRecognizer alloc]
      initWithTarget:target
      action:NSSelectorFromString(selName)]];
    return v;
}


+(UIView *)createIndicatorWithFrame:(CGRect)rect
                         frameColor:(UIColor *)frameColor
                     indicatorColor:(UIColor *)indicatorColor{
    
    @autoreleasepool {
        
        UIView *uivIndicatorWithFrame =
        [CreateComponentClass
         createViewWithFrame:rect
         color:frameColor
         borderColor:[UIColor clearColor]
         tag:0 target:nil selector:nil];
        
        UIActivityIndicatorView *indicator =
        [[UIActivityIndicatorView alloc]
         initWithActivityIndicatorStyle:
         UIActivityIndicatorViewStyleWhiteLarge];
        indicator.color = indicatorColor;
        
        indicator.center = CGPointMake(uivIndicatorWithFrame.bounds.size.width/2,
                                       uivIndicatorWithFrame.bounds.size.height/2);
        [uivIndicatorWithFrame addSubview:indicator];
        [indicator startAnimating];//待機表示開始
        
        
        
        return uivIndicatorWithFrame;
    }
}



@end
