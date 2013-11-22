//
//  EKViewController.m
//  StreamView
//
//  Created by Eli Wang on 1/16/12.
//  Copyright (c) 2012 ekohe.com. All rights reserved.
//

#import "EKViewController.h"
#import "EKStreamView.h"
#import "MyCell.h"
#import "EKStreamCell.h"
#import "EKStreamTopCell.h"
#import "EGORefreshTableHeaderView.h"
//const NSInteger kNumberOfCells = 1000;
const  int kNumberOfColumns =2;//有几列

static int MaxPage = 1;

@interface EKViewController ()<EKStreamViewDelegate,EGORefreshTableHeaderDelegate>
{
    NSMutableArray *randomHeights;
    int page;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}

@property ( nonatomic) IBOutlet EKStreamView *stream;
@property (nonatomic, retain) NSArray *images;

@end
@implementation EKViewController
@synthesize stream;



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor =[UIColor colorWithRed:231.0f/255.0f green:236.0f/255.0f blue:240.0f/255.0f alpha:1.0f];
    randomHeights = [[NSMutableArray alloc] initWithCapacity:100];
    for (int i = 0; i < 1000; i++) {
//        CGFloat h = arc4random() % 200 + 50.f;
//        [randomHeights addObject:@(h)];
         [randomHeights addObject:[NSString stringWithFormat:@"%d.jpg", i % 10 + 1]];
        
        
    }
    stream.scrollsToTop = YES;
    //填充距离
    stream.cellPadding = 5.0f;
    stream.columnPadding = 5.0f;
    
    //下拉刷新
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - stream.bounds.size.height, self.view.frame.size.width, stream.bounds.size.height)];
		view.delegate = self;
		[stream addSubview:view];
		_refreshHeaderView = view;
        ;
		
	}
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
    
}

- (void)viewDidUnload
{
    [self setStream:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    // set backcolor
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)numberOfCellsInStreamView:(EKStreamView *)streamView
{
    return [randomHeights count];
}

- (NSInteger)numberOfColumnsInStreamView:(EKStreamView *)streamView
{
    return kNumberOfColumns;
}

- (UIView *)streamView:(EKStreamView *)streamView cellAtIndex:(NSInteger)index
{
    static NSString *CellID1 = @"MyCell1";
    static NSString *CellID2 = @"MyCell2";
    
    BOOL redCell = index % kNumberOfColumns == 0;
    NSString *CellID =  redCell ? CellID2 : CellID1;
    
    EKStreamCell *cell;
    
    cell = (EKStreamCell *)[streamView dequeueReusableCellWithIdentifier:CellID];
     CGFloat destWidth = (streamView.bounds.size.width - (kNumberOfColumns + 1) * streamView.columnPadding) / kNumberOfColumns;
    if (cell == nil) {
        
        cell = [[EKStreamCell alloc] initWithFrame:CGRectMake(0, 0, 100, 100) infoViewHeight:kViewInfoHeight] ;
        cell.reuseIdentifier = CellID;
//        if (redCell) cell.label.textColor = [UIColor redColor];
    }
    
//    cell.label.text = [NSString stringWithFormat:@"%d",index];
    UIImage* image =[self imageAtIndexPath:index];
    cell.mainImageView.image = image;
    
    cell.mainLabel.text =[NSString stringWithFormat:@"%d瀑布流例子",index];
//    cell.mainLabel.center = CGPointMake(streamView.bounds.size.width*0.5,streamView.bounds.size.height*0.5);

//    cell.topImageView.frame =CGRectMake(0, 0,  cell.topImageView.frame.size.width, image.size.height);
    
    return cell;
}

- (CGFloat)streamView:(EKStreamView *)streamView heightForCellAtIndex:(NSInteger)index
{
    
    CGFloat destWidth = (streamView.bounds.size.width - (kNumberOfColumns + 1) * streamView.columnPadding) / kNumberOfColumns;
    float height =[self imageAtIndexPath:index].size.height*destWidth/[self imageAtIndexPath:index].size.width+kViewInfoHeight;
//    NSLog(@"打印高度===%f",height);
    return height;
}
////顶部栏
- (UIView *)headerForStreamView:(EKStreamView *)streamView
{
    UIImage* topImage =[UIImage imageNamed:@"banler.jpg"];
//     CGFloat destWidth = self.view.frame.size.width - stream.columnPadding * 2;
    CGFloat destWidth = streamView.frame.size.width;
    float height =topImage.size.height*destWidth/topImage.size.width;
//    float height =190.0f;
    EKStreamTopCell *header = [[EKStreamTopCell alloc] initWithFrame:CGRectMake(0, 0,  destWidth , height)];
    
//    header.label.text = @"This is the header";
    header.mainImageView.image =topImage;
    NSLog(@"headerForColumnPadding===%f",self.view.frame.size.width);
    return header;
}

//底部栏
//- (UIView *)footerForStreamView:(EKStreamView *)streamView
//{
//    if (page <= MaxPage) {
//        MyCell *footer = [[MyCell alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - stream.columnPadding * 2, 60)];
//        footer.label.text = @"This is the footer";
//        
//         NSLog(@"footerForStreamView===%f",self.view.frame.size.width);
//        
//        return footer;
//    } else {
//        return nil;
//    }
//}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    if (ABS(scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y) < 3
//        && page <= MaxPage) {
//        for (int i = 0; i < 100; i++) {
//            CGFloat h = arc4random() % 200 + 50.f;
//            [randomHeights addObject:[NSNumber numberWithFloat:h]];
//        }
//        
//        page++;
//        
//        [stream reloadData];
//    }
//}
//


#pragma mark- images


- (UIImage *)imageAtIndexPath:(NSUInteger)index {
    return [UIImage imageNamed:[randomHeights objectAtIndex:index]];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    //    if (ABS(scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y) < 3
    //        && page <= MaxPage) {
    //        for (int i = 0; i < 100; i++) {
    //            CGFloat h = arc4random() % 200 + 50.f;
    //            [randomHeights addObject:[NSNumber numberWithFloat:h]];
    //        }
    //
    //        page++;
    //
    //        [stream reloadData];
    //    }
}





- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
    
}
#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:stream];
	
}
@end
