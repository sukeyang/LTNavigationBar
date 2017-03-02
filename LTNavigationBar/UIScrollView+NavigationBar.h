//
//  UIScrollView+NavigationBar.h
//  LTNavigationBar
//
//  Created by yangshuo on 17/3/2.
//  Copyright © 2017年 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavbarViewHelper.h"

@interface UIScrollView (NavigationBar)

@property (weak, nonatomic) UIView *navigationView;

@property (assign, nonatomic) NavigationType navigationType;

//- (void)topButtonReleaseObjectBlock;

@end
