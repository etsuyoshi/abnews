//
//  Preservation.h
//  abnews
//
//  Created by 遠藤 豪 on 2014/04/21.
//  Copyright (c) 2014年 endo.neural. All rights reserved.
//

#import "ArticleData.h"
#import <Foundation/Foundation.h>

@interface Preservation : NSObject
+(void)preserveArticleData:(ArticleData *)articleData;
+(void)preserveArrArticleData:(NSMutableArray *)arr
                       nameAs:(NSString *)key;
+(Boolean)shouldUpdate;
+(void)removeAllData;
+(NSString *)updateDate;
+(NSMutableArray *)getArrArticleDataAsName:(NSString *)key;
@end
