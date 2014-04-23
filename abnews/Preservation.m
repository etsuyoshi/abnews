//
//  Preservation.m
//  abnews
//
//  Created by 遠藤 豪 on 2014/04/21.
//  Copyright (c) 2014年 endo.neural. All rights reserved.
//

#define LOG true
#import "Preservation.h"

@implementation Preservation


+(NSString *)updateDate{
    //現在日時を取得
    NSDate *now = [NSDate date];
    //NsDate→NSString変換用のフォーマッタを作成
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyyMMddHH"];//現在時刻をyyyyMMddhhで表示
    //日付から文字列に変換
    NSString *strNow = [outputFormatter stringFromDate:now];
    
    return strNow;
}

//NSUserDefaultsに保存
//日時：strNow
//オブジェクト(データ)型：articleData型
+(void)preserveArticleData:(ArticleData *)articleData{
    //@autopoolrelease
    
    //データ保存用変数
    NSUserDefaults *ud = [[NSUserDefaults alloc] init];
    
    NSString *strNow = [self updateDate];
    //日付データを保存
    [ud setObject:strNow forKey:@"updateDate"];
#if LOG
    NSLog(@"データ保存完了@ %@", strNow);
    
    NSLog(@"保存データ %@", [ud stringForKey:@"updateDate"]);
#endif
    
    //articleData型を保存
    [ud setObject:
     [NSKeyedArchiver archivedDataWithRootObject:articleData]
           forKey:[NSString stringWithFormat:@"%d",articleData.noID]];
    
    
}

//articleDataを格納したarrを保存する
+(void)preserveArrArticleData:(NSMutableArray *)arr
                       nameAs:(NSString *)key{
    //@autopoolrelease
    
    //データ保存用変数
    NSUserDefaults *ud = [[NSUserDefaults alloc] init];
    
    
    //日付データ取得
    NSString *strNow = [self updateDate];
    //日付データを保存
    [ud setObject:strNow forKey:@"updateDate"];
#if LOG
    NSLog(@"配列データ保存完了@ %@", strNow);
    
    NSLog(@"配列保存データ %@", [ud stringForKey:@"updateDate"]);
#endif
    
    //配列型を保存
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr];
//    [ud setObject:data forKey:key];
    [ud setObject:
     [NSKeyedArchiver archivedDataWithRootObject:arr]
           forKey:key];
    
    
}


+(NSMutableArray *)getArrArticleDataAsName:(NSString *)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    
}

//前回の更新から１時間以上が経過している場合、保存する
+(Boolean)shouldUpdate{
    //現在時刻を取得し、最新のデータから１時間離れている場合はyesを返す
    
    
    //現在日時を取得
    NSDate *now = [NSDate date];
    //NsDate→NSString変換用のフォーマッタを作成
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyyMMddHH"];//現在時刻をyyyyMMddhhで表示
    //日付から文字列に変換
    NSString *strNow = [outputFormatter stringFromDate:now];
    
    //保存されているデータを取得する
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *strBefore = [ud stringForKey:@"updateDate"];
    
    NSLog(@"strNow = %@, strBefore = %@", strNow, strBefore);
    
    if([strNow isEqualToString:strBefore]){
        NSLog(@"前回更新時間と同じです。");
        
        return NO;
    }else{
        NSLog(@"前回更新時間と異なります");
        return YES;
    }
}


+(void)removeAllData{
    NSLog(@"removeAllData");
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] setPersistentDomain:[NSDictionary dictionary] forName:appDomain];
}

@end
