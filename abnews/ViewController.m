//
//  ViewController.m
//  NewsAbst
//
//  Created by 遠藤 豪 on 2014/02/08.
//  Copyright (c) 2014年 endo.news. All rights reserved.
//

#define ONLINEMODE true
#define LOG false
#define DispDatabaseLog

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//@synthesize mecab;

NSMutableArray *arrArticleData;

BackgroundView *backgroundView;
CGPoint pntStartDrag;
int noStatus;//現在の状態(どの区切りか)を判別:最初は一番左の状態
UIView *btnUpdate;

UIView *uivIndicatorWithFrame;

//UIActivityIndicatorView *indicator;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
//    //背景画像backgroundViewに記事を配置
//    [self updateBackgroundAndArticle];
    
    
    //更新ボタンの作成(backgroundViewの上に配置するのでも良い)
    btnUpdate = [[UIView alloc]initWithFrame:CGRectMake(150, 30, 100, 70)];
    [btnUpdate setBackgroundColor:[UIColor colorWithRed:1.0f green:1.0 blue:0 alpha:0.5f]];
    [backgroundView addSubview:btnUpdate];
    btnUpdate.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGestureUpdate;
    tapGestureUpdate = [[UITapGestureRecognizer alloc]
                        initWithTarget:self
                        action:@selector(updateBackgroundAndArticle)];
    [btnUpdate addGestureRecognizer:tapGestureUpdate];
    
    
    //待機中に表示される背景画像
    UIImageView *uivBackground = [[UIImageView alloc]initWithImage:
                                  [UIImage imageNamed:@"sunrising.jpg"]];
    [self.view addSubview:uivBackground];
    [self.view sendSubviewToBack:uivBackground];
    
    
    //待機インジケーター
    
    int indicatorWidth = 100;
    int indicatorHeight = 100;
    uivIndicatorWithFrame =
    [CreateComponentClass
     createIndicatorWithFrame:CGRectMake(self.view.bounds.size.width/2-indicatorWidth/2,
                                         self.view.bounds.size.height/2-indicatorHeight/2,
                                         indicatorWidth, indicatorHeight)
     frameColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5f]
     indicatorColor:[UIColor blackColor]];
    
    [uivBackground addSubview:uivIndicatorWithFrame];
    
}


/*
 *所定の数だけarticleDataを用意
 *articleDataをarrArticleDataに格納
 *(articleDataに対応した)articleCellをbackgroundViewに配置
 */
-(void)updateBackgroundAndArticle{
    NSLog(@"updateBackgroundAndArticle");
    
    
    //(背景画像である)backgroundにデータを格納した記事セルを配置する
    [self setArticleWithBackground];
    
    //backgroundの表示
    [backgroundView removeFromSuperview];
    [self.view addSubview:backgroundView];
//    [self.view sendSubviewToBack:backgroundView];
    
//    [indicator stopAnimating];//待機表示終了
//    [indicator removeFromSuperview];
    [uivIndicatorWithFrame removeFromSuperview];
}

-(void)onTapped:(UITapGestureRecognizer *)gr{
    
    [self dispNextViewController:(int)[gr.view tag]];
}

-(void)dispNextViewController:(int)noTapped{
//    ArticleData *articleData;
    for(int i = 0;i < [arrArticleData count];i++){
        for(int j = 0; j < [arrArticleData[i] count];j++){
            if(noTapped == ((ArticleData *)[arrArticleData[i] objectAtIndex:j]).noID){
                
                //タップされたarticleCellに該当するarticleDataを検索
                ArticleData *articleData = (ArticleData *)[arrArticleData[i] objectAtIndex:j];
                
                
                TextViewController *tvcon =
                [[TextViewController alloc]
                 initWithArticle:articleData];
//                 initWithArticle:(ArticleData *)arrArticleData[noTapped]];
                [self presentViewController:tvcon animated:NO completion:nil];
            }
        }
    }
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    //backgroundの表示
    //    [self.view addSubview:imvBackground];
    
    
//    [self.view addSubview:backgroundView];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [backgroundView removeFromSuperview];
    
    //背景画像backgroundViewに記事を配置
    [self updateBackgroundAndArticle];
    
    
    
    NSLog(@"exit viewDidAppear");
}


/*
 articleDataをデバイス(既存記事採用)もしくはウェブ(新規取得)から取得する
 ※articleDataを新規取得すべきかどうかは事前判定:[Preservation shouldUpdate]
 ※articleDataを既存記事採用する場合、NSUserDefaultsにデータを取りにいく
 articleDataをarticleCellに格納する
 articleCellをarrTableに対応づける
 arrTableをbackgroundViewに対応づける
 */
-(void)setArticleWithBackground{
    
    //表示コンポーネントやデータの初期化等
    NSArray *arrTable = [NSArray arrayWithObjects:
                         [[ArticleTable alloc] initWithType:TableTypeTechnology],//category:0
                         [[ArticleTable alloc] initWithType:TableTypeSports],//category:1
                         [[ArticleTable alloc] initWithType:TableTypeArts],
                         [[ArticleTable alloc] initWithType:TableTypePolitics],
                         [[ArticleTable alloc] initWithType:TableTypeFinance],
                         nil];
    
    arrArticleData = [NSMutableArray array];
    int numOfArticleAtDB;
    int maxDispArticle = 4;
    
    BOOL shouldUpdate = [Preservation shouldUpdate];
    
    
#if !ONLINEMODE
    shouldUpdate = false;
#endif
    NSLog(@"shouldUpdate = %d", shouldUpdate);
    
    //新規データ取得を判断する
    if(!shouldUpdate){
        
    
        //更新が必要ない場合
#if LOG
        NSLog(@"新規取得が必要ないです。");
#endif
        
        //通信を行わずにNSUserDefaultsからデータを取得して表示処理を行う
        //arrArticleDataにデータを格納
        arrArticleData = [Preservation getArrArticleDataAsName:
                          [Preservation updateDate]];
        
        NSLog(@"%d個のカテゴリを取得しました。", (int)[arrArticleData count]);
    }else{
        
        
        //更新が必要である場合
#if LOG
        NSLog(@"更新が必要です。");
#endif
        
        
        [Preservation removeAllData];
        
        int category = 0;
        int lastID;
        
        
        for(int i = 0 ;i < [arrTable count];i++){//全てのテーブルに対して
            lastID = 100000;
            category = i;
            
            //カテゴリ毎の記事数を確認
            numOfArticleAtDB = [DatabaseManage getCountFromDBUnderNaive:lastID category:i];
#if LOG
            NSLog(@"記事数:numOfArticle = %d", numOfArticleAtDB);
#endif
            if(numOfArticleAtDB < 1){//if categoy's article data does not exist..
                continue;//記事が存在しないので次のカテゴリへ(当該カテゴリにはarticleCellを配置しない)
            }
#if LOG
            NSLog(@"記事取得中...");
#endif
            
            //当該テーブルに配置するarticleCell(に対応するarticleData)を格納するarrArticleData(その中にarrTmpArticleDataを格納)
            NSMutableArray *arrTmpArticleData = [NSMutableArray array];
            
            for(int j = 0;j < MIN(maxDispArticle, numOfArticleAtDB);j++){//各テーブルに最大表示数までのセルを配置
                
                
                //naiveはblog_id999とかispost判定をしていないphpファイル実行
#if LOG
                NSLog(@"id取得中...");
#endif
                lastID = [DatabaseManage
                          getLastIDFromDBUnderNaive:lastID
                          category:category];
#if LOG
                NSLog(@"id取得完了");
#endif
                
                //            lastID = 17054;//test用
                
                
                //上記キー値を元にデータを取得
#if LOG
                NSLog(@"記事取得中..");//以下の処理が最も時間がかかる(５秒程度)
#endif
                NSDictionary *dictTmp = [DatabaseManage getRecordFromDBAt:lastID];//指定したIDを取得する
#if LOG
                NSLog(@"記事取得完了");
#endif
                lastID = (int)[[dictTmp objectForKey:@"id"] integerValue];
                
                NSString *strTitle = [dictTmp objectForKey:@"title"];
//            NSString *strReturnBody = [dictTmp objectForKey:@"body"];//未使用
                NSString *strAbst = [dictTmp objectForKey:@"abstforblog"];
                NSString *strKeyword = [dictTmp objectForKey:@"keywordblog"];
                NSString *strImageUrl = [dictTmp objectForKey:@"imageurl"];
                NSString *strUrl = [dictTmp objectForKey:@"url"];
                int category = (int)[[dictTmp objectForKey:@"category"] integerValue];
                
                
#if LOG
                NSLog(@"id=%d", lastID);
                NSLog(@"strTitle = %@", strTitle);
//                NSLog(@"strBody = %@", strReturnBody);
                NSLog(@"abstforblog = %@", strAbst);
                NSLog(@"keyword=%@", strKeyword);
#endif
                
                //既に要約文が作成されている前提なのでテキスト解析は行わない
                //            TextAnalysis *textAnalysis = [[TextAnalysis alloc]initWithText:strReturnBody];
                //            NSArray *arrImportantSentence = textAnalysis.getImportantSentence;
                //            NSArray *arrImportantNode = textAnalysis.getImportantNode;
                
                
                //記事セルにテキストを格納
                //            articleCell.text = arrImportantSentence[j];
                
                ArticleData *articleData = [[ArticleData alloc]init];
                articleData.noID = lastID;
                articleData.title = strTitle;
                articleData.strKeyword = strKeyword;
                articleData.strSentence = strAbst;
                articleData.category = category;
                articleData.strImageUrl = strImageUrl;
                articleData.strUrl = strUrl;
                
                
                //[Preservation removeAllData];
                //            NSLog(@"preservation");
                //            [Preservation preserveArticleData:articleData];
                
                
                [arrTmpArticleData addObject:articleData];
                
            }
            //二次元配列：各テーブルにarrTmpArticleDataを配置する
            [arrArticleData addObject:arrTmpArticleData];
            
        
        }
        
        //現在時刻(YMDH)というキーで二次元配列そのものを格納する
        [Preservation preserveArrArticleData:arrArticleData
                                      nameAs:[Preservation updateDate]];
        
    }
    
    
    
    
    for(int i = 0 ;i < [arrArticleData count];i++){//全てのテーブルに対して
        
        numOfArticleAtDB = (int)[((NSMutableArray *)arrArticleData[i]) count];
        
#if LOG
        NSLog(@"カテゴリ%dの記事数は%d", i, numOfArticleAtDB);
#endif
        
        for(int j = 0;j < MIN(maxDispArticle, numOfArticleAtDB);j++){//各テーブルに最大表示数までのセルを配置
            
            ArticleData *articleData = [arrArticleData[i] objectAtIndex:j];
            //記事セル作成
            ArticleCell *articleCell =
            [[ArticleCell alloc]
             initWithFrame:
             CGRectMake(0, 0, 250, 100)
             withArticleData:articleData
             ];//位置はaddCellメソッド内で適切に配置
            
            [((ArticleTable *)arrTable[i]) addCell:articleCell];
            
            UITapGestureRecognizer *tapGesture;
            tapGesture = [[UITapGestureRecognizer alloc]
                          initWithTarget:self
                          action:@selector(onTapped:)];
            
            //参考：http://stackoverflow.com/questions/16882737/scrollview-gesture-recognizer-eating-all-touch-events
            //※tapGestureをNOにしてしまうとセルを貼付けるArticleTableに関連づけた"シングル"タップイベントが機能しないのでyesにする
            tapGesture.cancelsTouchesInView = YES;
            [articleCell addGestureRecognizer:tapGesture];
            articleCell.userInteractionEnabled = YES;
//            articleCell.tag=[arrArticleData count]-1;//カテゴリによらず単調増加型のtag番号を作成
            articleCell.tag = articleData.noID;
            
            //            NSLog(@"arrtable%d = %@", i, arrTable[i]);
        }//各テーブル内のセルに対して
    }//各テーブルに対して
#if LOG
    NSLog(@"記事取得完了");
#endif
    
    
    backgroundView = [[BackgroundView alloc]initWithTable:arrTable];
}


//使用していない(必要性なければ後で削除)
-(void)getDataFromDB{
    //databasemanageクラスからデータを取得(引数なしだと最大100記事を取得)
    NSArray *array = [DatabaseManage getRecordFromDBAll];//100個取得
    
    NSString *strId = nil;
    NSString *strBody = nil;
    NSString *strSaved = nil;
    NSString *strDate = nil;
    NSDictionary *_dict = nil;
    for(int i = 0;i < [array count];i++){
        _dict = array[i];
        strId = [_dict objectForKey:@"id"];
        strBody = [_dict objectForKey:@"body"];
        strSaved = [_dict objectForKey:@"saveddate"];
        strDate = [_dict objectForKey:@"datetime"];
#ifdef DispDatabaseLog
        NSLog(@"id=%@",strId);
        
        NSLog(@"id=%@",strBody);
        NSLog(@"id=%@",strSaved);
        NSLog(@"id=%@",strDate);
#endif
    }
}


@end
