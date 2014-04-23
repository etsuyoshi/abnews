//
//  ArticleData.m
//  Newsab
//
//  Created by 遠藤 豪 on 2014/02/27.
//
//

#import "ArticleData.h"

@implementation ArticleData

@synthesize category;
@synthesize noID;
//@synthesize text;
@synthesize title;
@synthesize strUrl;//url of article
@synthesize strSentence;
@synthesize strKeyword;
@synthesize strImageUrl;//url of image

//NSUserDefaults格納の際のシリアライズ時に呼ばれる
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:[NSNumber numberWithInt:category] forKey:@"category"];
    [coder encodeObject:[NSNumber numberWithInt:noID] forKey:@"noID"];
    [coder encodeObject:title forKey:@"title"];
    [coder encodeObject:strUrl forKey:@"strUrl"];
    [coder encodeObject:strSentence forKey:@"strSentence"];
    [coder encodeObject:strKeyword forKey:@"strKeyword"];
    [coder encodeObject:strImageUrl forKey:@"strImageUrl"];
    
}

// デシリアライズ時に呼ばれる
- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    if (self) {
        category = [[coder decodeObjectForKey:@"category"] intValue];
        noID = [[coder decodeObjectForKey:@"noID"] intValue];
        title = [coder decodeObjectForKey:@"title"];
        strUrl = [coder decodeObjectForKey:@"strUrl"];
        strSentence = [coder decodeObjectForKey:@"strSentence"];
        strKeyword = [coder decodeObjectForKey:@"strKeyword"];
        strImageUrl = [coder decodeObjectForKey:@"strImageUrl"];
    }
    return self;
}

@end
