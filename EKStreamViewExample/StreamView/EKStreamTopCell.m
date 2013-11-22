//
//  EKStreamTopCell.m
//  StreamView
//
//  Created by miku on 13-11-15.
//  Copyright (c) 2013年 ekohe.com. All rights reserved.
//

#import "EKStreamTopCell.h"

@implementation EKStreamTopCell
@synthesize mainImageView;
@synthesize reuseIdentifier;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
          [self  setBackgroundColor:[UIColor orangeColor]];
        //topImage
        CGRect  imageRect =CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
        CGRect  topImageFrame = CGRectInset(imageRect, 0.0f, 0.0f);
        self.mainImageView =[[UIImageView alloc] initWithFrame:topImageFrame];
        //       self.mainImageView .center = CGPointMake(self.frame.size.width/ 2, 0);
        self.mainImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.mainImageView setContentMode:UIViewContentModeScaleAspectFit];
//        [self.mainImageView setImage:[UIImage imageNamed:@"1.jpeg"]];
        
//        [self.mainImageView setBackgroundColor:[UIColor redColor]];
        [self addSubview: self.mainImageView];
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
