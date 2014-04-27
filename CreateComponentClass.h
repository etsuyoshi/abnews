//
//  CreateComponentClass.h
//  abnews
//
//  Created by 遠藤 豪 on 2014/04/27.
//  Copyright (c) 2014年 endo.neural. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreateComponentClass : NSObject



//manufact
+(UITextView *)createTextView:(CGRect)rect
                         text:(NSString *)text
                         font:(NSString *)font
                         size:(int)size
                    textColor:(UIColor *)textColor
                    backColor:(UIColor *)backColor
                   isEditable:(Boolean)isEditable;

//standard1
+(UIView *)createView;

//standard2
+(UIView *)createView:(CGRect)rect;

//manufact
+(UIView *)createView:(CGRect)rect
                color:(UIColor*)color
         cornerRaidus:(float)cornerRadius
          borderColor:(UIColor*)borderColor
          borderWidth:(float)borderWidth;

//manufact2:tapイベントを付ける(フレームなし)
+(UIView *)createViewNoFrame:(CGRect)rect
                       color:(UIColor *)color
                         tag:(int)tag
                      target:(id)target
                    selector:(NSString *)selName;
//manufact3:tapイベントを付ける(フレームあり)
+(UIView *)createViewWithFrame:(CGRect)rect
                         color:(UIColor *)color
                           tag:(int)tag
                        target:(id)target
                      selector:(NSString *)selName;

+(UIView *)createIndicatorWithFrame:(CGRect)rect
                         frameColor:(UIColor *)frameColor
                     indicatorColor:(UIColor *)indicatorColor;
@end
