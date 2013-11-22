//
//  EKStreamTopCell.h
//  StreamView
//
//  Created by miku on 13-11-15.
//  Copyright (c) 2013年 ekohe.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EKStreamView.h"
@interface EKStreamTopCell : UIView<EKResusableCell>
{
    NSString *reuseIdentifier;
}

@property(nonatomic,strong) UIImageView* mainImageView;//顶部图片
@end
