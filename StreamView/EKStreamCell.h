//
//  EKStreamCell.h
//  StreamView
//
//  Created by miku on 13-11-15.
//  Copyright (c) 2013年 ekohe.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKStreamView.h"
////图片底部信息栏高度
#define  kViewInfoHeight  25.0f
@interface EKStreamCell : UIView<EKResusableCell>
{
    NSString *reuseIdentifier;
}


@property(nonatomic,strong) UIImageView* mainImageView;//顶部图片
@property(nonatomic,strong) UILabel* mainLabel;//标题
@property(nonatomic,strong) UILabel* textLabel_one;
@property(nonatomic,strong) UILabel* textLabel_two;
@property(nonatomic,strong) UIImageView* imageView_one;
@property(nonatomic,strong) UIImageView* imageView_two;
@property(nonatomic,strong) UIView* bottomView;//底部View
#pragma mark-
- (id)initWithFrame:(CGRect)frame  infoViewHeight:(float)infoViewHeight;
@end
