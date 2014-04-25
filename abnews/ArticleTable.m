//
//  ArticleTable.m
//  NewsAbst
//
//  Created by 遠藤 豪 on 2014/02/10.
//  Copyright (c) 2014年 endo.news. All rights reserved.
//

#import "ArticleTable.h"

@implementation ArticleTable

@synthesize tableType = _tableType;
@synthesize cellColor = _cellColor;
@synthesize arrCells = _arrCells;
@synthesize scrollView = _scrollView;

int intervalCell;
int widthCell;
int heightCell;

int downThreasholdToUpdate;//スクロール時にこれ以上、下方向に引っ張ったら更新するという閾値
CGPoint _scrollPrevPoint;  //スクロールの開始位置
BOOL _cancelDecelerating;  //慣性スクロールをキャンセルするフラグ
int _scrolling_direction;  //0:未確定 1:上（offset.yが小さくなる）　2:下（offset.yが大きくなる）



-(id)initWithType:(TableType)tableType{
    //縦スクロールする場合は以下の長さを変更する
    self = [super
            initWithFrame:
            CGRectMake(0, 0,
                       [UIScreen mainScreen].bounds.size.width*.9,
                       [UIScreen mainScreen].bounds.size.height*.9)];
    
    
    if(self){
        downThreasholdToUpdate = 50;
        self.tableType = tableType;
        [self initializer];
    }
    
    return self;
}

-(void)initializer{
    
    //prohibit to let component allocated upon this be transparancy
//    self.alpha = 0.0f;
    
    
    //テーブル毎にセルの色を変更
//    UIColor *tableColor;
    switch (self.tableType) {
            
        case TableTypeSports:{
            self.cellColor = [UIColor redColor];
//            tableColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.3f];//test:red
            break;
        }
        case TableTypeTechnology:{
            self.cellColor = [UIColor greenColor];
//            tableColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.3f];//test:green
            break;
        }
        case TableTypeArts:{
            self.cellColor = [UIColor blueColor];
//            tableColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.3f];//test:blue
            break;
        }
        case TableTypeBusiness:{
            self.cellColor = [UIColor purpleColor];
//            tableColor = [UIColor colorWithRed:1 green:0 blue:1 alpha:0.3f];//test:purple
            break;
        }
        case TableTypeFinance:{
            self.cellColor = [UIColor yellowColor];
            break;
        }
        case TableTypeBlog:{
            self.cellColor = [UIColor brownColor];
            break;
        }
        case TableTypeEntertainment:{
            self.cellColor = [UIColor cyanColor];
            break;
        }
        case TableTypeMatome:{
            self.cellColor = [UIColor magentaColor];
            break;
        }
        case TableTypePolitics:{
            self.cellColor = [UIColor darkGrayColor];
            break;
        }
        default:
            break;
    }
    
    //test:color
//    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.3f];
    self.backgroundColor = [UIColor clearColor];
    
    
    self.arrCells = [NSMutableArray array];
    
    self.scrollView =
    [[UIScrollView alloc]
     initWithFrame:self.bounds];
    self.scrollView.delegate = self;//下方向スクロール時に記事読み込みを実行
    //scrollView内のコンテンツの大きさ
    self.scrollView.contentSize =
    CGSizeMake(self.bounds.size.width,
               self.bounds.size.height);//内容物を縦長にしたければ第二引数を２倍にする
    self.scrollView.backgroundColor = [UIColor clearColor];
    //scrollViewをテーブルに貼付ける
    [self addSubview:self.scrollView];
    
    
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.alwaysBounceVertical = YES;
    self.scrollView.directionalLockEnabled = YES;
    
    
    
    
//    ArticleCell *articleCell = [[ArticleCell alloc]initWithFrame:
//                                CGRectMake(10, 10, 250, 100)];
//    articleCell.translucentTintColor = cellColor;
//    articleCell.center = CGPointMake(self.bounds.size.width/2,
//                                     150);
//    [self addSubview:articleCell];
}

-(void)addCell:(ArticleCell *)articleCell{
    articleCell.translucentTintColor = self.cellColor;
    [self.arrCells addObject:articleCell];
    heightCell = articleCell.bounds.size.height;
    widthCell = articleCell.bounds.size.width;
    intervalCell = 10;
    
    
    //もしセル数に対して表示範囲のscrollViewの縦長さが不足していれば長さを二倍にする
    if([self.arrCells count] * (intervalCell + heightCell) >
       self.scrollView.contentSize.height){
        
        
        self.scrollView.contentSize =
        CGSizeMake(self.scrollView.contentSize.width,
                   self.scrollView.contentSize.height+
                   [UIScreen mainScreen].bounds.size.height);
    }
    
    articleCell.frame =
    CGRectMake(10, ([self.arrCells count]-1) * (intervalCell + heightCell),
               widthCell, heightCell);
    //[self addSubview:[self.arrCells lastObject]];
    [self.scrollView addSubview:[self.arrCells lastObject]];
    
    
    /*あとやるべきこと
     *セルにリスナーを付けて別画面を起動し、要約文を表示
     *tableを縦にスクロールできるようにする
     */
}

-(void)removeAllCells{
    
    for(int i = 0 ;i < [self.arrCells count];i++){
        [self.arrCells[i] removeFromSuperview];
    }
    
    [self.arrCells removeAllObjects];
}



//下に引っ張るとデータ取得して、取得したデータをセルに格納し、テーブル(上のscrollView)にセルを配置
-(void)scrollViewDidScroll:(UIScrollView *)sender{
    NSLog(@"articletable scroll");
    
    CGPoint currentPoint = [self.scrollView contentOffset];
    
    if (CGPointEqualToPoint(_scrollPrevPoint, currentPoint)){
        return;
    }
    else {
        //横スクロール方向の判定：横方向のスクロールを検出した際には2
        _scrolling_direction = (_scrollPrevPoint.x != currentPoint.x) ? 2 : 1;
        
        
        //最上位である時は、これ以上の上には行かないという判定も必要(未作成)
        
        
//        if(_scrolling_direction != 2){//横方向の移動ではないとき
//            //左フリックは無効化(_scrolling_directionは偶数の時に元座標にリセット)
//            _scrolling_direction = (_scrollPrevPoint.x < currentPoint.x) ? 4 : 3;
//        }
        
        //        NSLog(@"cy=%f, _sy=%f _scrolling_direction = %d : %@",
        //              currentPoint.y,
        //              _scrollPrevPoint.y,
        //              _scrolling_direction,
        //              _scrolling_direction==2?@"キャンセル":@"スクロール中");
    }
    
    //常にスクロール横位置は同じ
    currentPoint.x = _scrollPrevPoint.x;
    //上下及び右スクロールのキャンセル
//    if (_scrolling_direction == 1)
//    {
//        
//        currentPoint.x = _scrollPrevPoint.x;
//        [self.scrollView setContentOffset:currentPoint];
//        _cancelDecelerating = true; //慣性スクロールを止めるためのフラグをセット
//    }
    
    
    //一度のスライドで何度も呼ばれないように指を触れたらON,指を話したらOFFというフラグを入れる(未作成)
    //下方向に閾値(downThreasholdToUpdate)以上引っ張れば
    if(self.scrollView.contentOffset.y < downThreasholdToUpdate){
        [self.scrollView setContentOffset:self.scrollView.contentOffset animated:NO];
        
        NSLog(@"touch limit-down side");
        
        //        [self dismissViewController];
        //１秒後に戻る
        [self performSelector:@selector(readMoreArticle)
                   withObject:nil
                   afterDelay:1.0f];
        
    }
}

//http://stackoverflow.com/questions/9609226/detecting-user-touch-on-uiscrollview
//UIScrollViewをドラッグした後、指がスクリーンから離れた時に呼ばれる
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                 willDecelerate:(BOOL)decelerate{
    NSLog(@"detect lifting-up from screen");
    NSLog(@"scrollViewDidEndDragging:(UIScrollView *)scrollView");
}

//UIScrollViewをドラッグした後、指がスクリーンから離れた時に呼ばれる:その２
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollview did end decelerating");
}


//下方向に引っ張った時に呼ばれる記事読み込みメソッド
//引数に現在idを取得しても良いかもしれない
-(void)readMoreArticle{
    NSLog(@"readMoreArticle");
    
}

@end
