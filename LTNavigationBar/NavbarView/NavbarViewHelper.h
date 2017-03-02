//
//  NavbarViewHelper.h
//  LTNavigationBar
//
//  Created by yangshuo on 17/3/2.
//  Copyright © 2017年 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NavigationType) {
    NavigationTypeFade,
    NavigationTypeHiden
};

@interface NavbarViewHelper : NSObject

@property (strong, nonatomic) UIView *navigationView;
@property (assign, nonatomic) NavigationType navigationType;
@property (strong, nonatomic) UIColor *navColor;

- (id)initWithScrollView:(UIScrollView *)scrollView;

@end
