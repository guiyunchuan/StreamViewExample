//
//  EKStreamCell.m
//  StreamView
//
//  Created by miku on 13-11-15.
//  Copyright (c) 2013年 ekohe.com. All rights reserved.
//

#import "EKStreamCell.h"
#import <QuartzCore/QuartzCore.h>



//设置边框的宽度，当然可以不要
const CGFloat kViewBorderMargin = 2.0f;
//设置圆角的有多圆
const CGFloat kViewCornerRadius = 5.0f;

//设置边据
//const CGFloat kViewPadingWidth =0.0f;

@implementation EKStreamCell
@synthesize reuseIdentifier;
//@synthesize bgView;
@synthesize mainImageView;


- (id)initWithFrame:(CGRect)frame  infoViewHeight:(float)infoViewHeight
{
    self = [super initWithFrame:frame];
    if (self) {

        NSLog(@"打印底部信息栏高度===%f",infoViewHeight);
        // Initialization code
        [self  setBackgroundColor:[UIColor whiteColor]];
        //设置圆角
        self.layer.cornerRadius = kViewCornerRadius;//设置圆角的有多圆
        self.layer.masksToBounds = YES;//设为NO去试试
        
        //背景
        CGRect bgFrame = CGRectInset(self.bounds, 0.0f, 0.0f);
        UIView *bgView = [[UIView alloc] initWithFrame:bgFrame];
        bgView.backgroundColor  =[UIColor clearColor];
        bgView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        
        //UIView设置边框
         [[bgView layer] setCornerRadius:kViewCornerRadius];
         [[bgView layer] setMasksToBounds:YES];
//        [[bgView layer] setBorderWidth:kViewBorderMargin];
//        [[bgView layer] setBorderColor:[UIColor whiteColor].CGColor];
   

        
        [self addSubview:bgView];
        

        //主图片
        CGRect  imageRect =CGRectMake(0, 0, bgFrame.size.width, bgFrame.size.height-infoViewHeight);
          self.mainImageView =[[UIImageView alloc] initWithFrame:imageRect];
       self.mainImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.mainImageView setContentMode:UIViewContentModeScaleAspectFit];
       [self.mainImageView setBackgroundColor:[UIColor whiteColor]];
        [bgView addSubview: self.mainImageView];
        
        //图片上的View
        UIImage*  imageTopBg =[UIImage imageNamed:@"list_bg.png"];
        CGRect imageTopBgFrame = CGRectMake(0, imageRect.size.height-imageTopBg.size.height, bgFrame.size.width, imageTopBg.size.height);
        UIView *imageTopBgView = [[UIView alloc] initWithFrame:imageTopBgFrame];
        imageTopBgView.backgroundColor  =[UIColor colorWithPatternImage:imageTopBg];
//        imageTopBgView.backgroundColor  =[UIColor clearColor];
        imageTopBgView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        [self.mainImageView addSubview:imageTopBgView];
        
        //title_icon
        UIImage *title_icon =[UIImage imageNamed:@"title_icon.png"];
         CGRect  titleIconFrame =CGRectMake(0,0,title_icon.size.width, title_icon.size.height);
        UIImageView* title_icon_view =[[UIImageView alloc] initWithFrame:titleIconFrame];
        [title_icon_view setImage:title_icon];
          [title_icon_view setContentMode:UIViewContentModeScaleToFill];
        [imageTopBgView addSubview:title_icon_view];
//        UIImageView* imageToBGImageView =[[UIImageView alloc] initWithImage:imageTopBg];
//        [imageTopBgView addSubview:imageToBGImageView];
        
        //title_play_icon
        UIImage *play_icon =[UIImage imageNamed:@"play_icon.png"];
        CGRect  playIconFrame =CGRectMake(imageTopBgFrame.size.width+play_icon.size.width*0.5,-imageTopBg.size.height*0.5,play_icon.size.width, play_icon.size.height);
        UIImageView* play_icon_view =[[UIImageView alloc] initWithFrame:playIconFrame];
//        [play_icon_view setCenter:CGPointMake(200, 0)];
        [play_icon_view setImage:play_icon];
        [play_icon_view setBackgroundColor:[UIColor clearColor]];
        [play_icon_view setContentMode:UIViewContentModeScaleToFill];
        [imageTopBgView  addSubview:play_icon_view];
        
        
        
        //底补UIView
        CGRect bottomBgFrame = CGRectMake(0, bgFrame.size.height-infoViewHeight, bgFrame.size.width, infoViewHeight);
        UIView *bottomBgView = [[UIView alloc] initWithFrame:bottomBgFrame];
         bottomBgView.backgroundColor  =[UIColor clearColor];
        bottomBgView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
         [bgView addSubview:bottomBgView];

        
//        //main Label
     
        CGRect  mainLabelFrame =CGRectMake(title_icon.size.width,0,imageTopBgFrame.size.width-title_icon.size.width, imageTopBgFrame.size.height);
        self.mainLabel = [[UILabel alloc] initWithFrame:mainLabelFrame];
         self.mainLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
         self.mainLabel.backgroundColor = [UIColor clearColor];
         self.mainLabel.textAlignment = UITextAlignmentLeft;
        [self.mainLabel  setTextColor: [UIColor colorWithRed:255/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1]];
        [self.mainLabel setFont:[UIFont systemFontOfSize:12]];
        [imageTopBgView addSubview: self.mainLabel];
//
//       //first icon
        UIImage* one_image =[UIImage imageNamed:@"peper.png"];
        CGRect  firstImageFrame =CGRectMake(0, 0, one_image.size.width, one_image.size.height);
              
        self.imageView_one = [[UIImageView alloc] initWithFrame:firstImageFrame];
      
        self.imageView_one.image =one_image;
//           self.imageView_one.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
//        self.imageView_one.backgroundColor = [UIColor purpleColor];
        [self.imageView_one setContentMode:UIViewContentModeScaleToFill];
        [bottomBgView addSubview: self.imageView_one];

        //first label
        CGRect  textLabelOneFrame =CGRectMake(one_image.size.width,0,40, bottomBgFrame.size.height);
        self.textLabel_one = [[UILabel alloc] initWithFrame:textLabelOneFrame];
//        self.textLabel_one.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        self.textLabel_one.backgroundColor = [UIColor clearColor];
        self.textLabel_one.textAlignment = UITextAlignmentLeft;
        [self.textLabel_one  setTextColor: [UIColor colorWithRed:177.0f/255.0f green:177.0f/255.0f blue:177.0f/255.0f alpha:1]];
        [self.textLabel_one setFont:[UIFont systemFontOfSize:11]];
        [self.textLabel_one setText:@"0"];
        [bottomBgView addSubview: self.textLabel_one];
        
        
        
        //second label
        CGRect  textLabelTwoFrame =CGRectMake(one_image.size.width+50,0,bottomBgFrame.size.width-one_image.size.width, bottomBgFrame.size.height);
        self.textLabel_two = [[UILabel alloc] initWithFrame:textLabelTwoFrame];
        //        self.textLabel_one.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        self.textLabel_two.backgroundColor = [UIColor clearColor];
        self.textLabel_two.textAlignment = UITextAlignmentRight;
        [self.textLabel_two  setTextColor: [UIColor colorWithRed:177.0f/255.0f green:177.0f/255.0f blue:177.0f/255.0f alpha:1]];
        [self.textLabel_two setFont:[UIFont systemFontOfSize:11]];
        [self.textLabel_two setText:@"(600210)房间"];
        [bottomBgView addSubview: self.textLabel_two];
        
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
