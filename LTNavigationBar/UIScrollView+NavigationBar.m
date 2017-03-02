//
//  UIScrollView+NavigationBar.m
//  LTNavigationBar
//
//  Created by yangshuo on 17/3/2.
//  Copyright © 2017年 ltebean. All rights reserved.
//

#import "UIScrollView+NavigationBar.h"

#import <objc/objc.h>
#import <objc/runtime.h>
#import "NavbarViewHelper.h"

@implementation UIScrollView (NavigationBar)

- (void)setNavigationView:(UIView *)navigationView {
    [self getHelper].navigationView = navigationView;
}

- (NavbarViewHelper *)getHelper {
    NavbarViewHelper *helper = objc_getAssociatedObject(self, @selector(getHelper));
    if(helper == nil) {
        helper = [[NavbarViewHelper alloc] initWithScrollView:self];
        objc_setAssociatedObject(self, @selector(getHelper), helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return helper;
}

- (UIView *)navigationView {
    return  [self getHelper].navigationView;
}

- (NavigationType)navigationType {
   return  [self getHelper].navigationType;
}

- (void)setNavigationType:(NavigationType)navigationType {
    [self getHelper].navigationType = navigationType;
}


@end
