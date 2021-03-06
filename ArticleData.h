//
//  ArticleData.h
//  Newsab
//
//  Created by 遠藤 豪 on 2014/02/27.
//
//

#import <Foundation/Foundation.h>

@interface ArticleData : NSObject <NSCoding>

@property (nonatomic) int category;
@property (nonatomic) int noID;
@property (nonatomic) NSString *title;
//@property (nonatomic) NSString *text;
@property (nonatomic) NSString *strUrl;
@property (nonatomic) NSString *strSentence;
@property (nonatomic) NSString *strKeyword;
@property (nonatomic) NSString *strImageUrl;
@end
