//
//  NavbarViewHelper.m
//  LTNavigationBar
//
//  Created by yangshuo on 17/3/2.
//  Copyright © 2017年 ltebean. All rights reserved.
//

#import "NavbarViewHelper.h"
#import "NSObject+SSAddForKVO.h"
#import "CommonMacro.h"
#import "UINavigationBar+Awesome.h"

#define NAVBAR_CHANGE_POINT 50

typedef NS_ENUM(NSInteger, NavigationViewType) {
    NavigationTypeNav, //系统的
    NavigationTypeCustom //自定义的
};

@interface NavbarViewHelper()

@property (assign,nonatomic) NavigationViewType mNavigationViewType;
@property (strong,nonatomic) UIScrollView *mScrollView;
@property (strong,nonatomic) UIView *overlay;
@end

@implementation NavbarViewHelper


- (UIView *)overlay {
    if (_overlay) {
        return _overlay;
    }
    UIViewController *controller = self.mScrollView.superview.nextResponder;
    if (![controller isKindOfClass:[UIViewController class]]) {
        return nil;
    }
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth(controller.view.bounds),20);
    self.overlay = [[UIView alloc] initWithFrame:frame];
    [self.overlay setBackgroundColor:_navColor];
    [self.overlay setUserInteractionEnabled:NO];
    [controller.view addSubview:self.overlay];
    [self.overlay setAlpha:0];
    return _overlay;
}

- (id)initWithScrollView:(UIScrollView *)scrollView {
    self = [super init];
    if (self) {
        @weakify(self);
        _mScrollView = scrollView;
        _navColor = [UINavigationBar appearance].barTintColor;
        [_mScrollView addObserverBlockForKeyPath:@"contentOffset" block:^(id  _Nonnull obj, id  _Nonnull oldVal, id  _Nonnull newVal) {
            @strongify(self);
            [self handlResultWithNewValue:newVal];
        }];
    }
    return self;
}

- (void)setNavigationView:(UIView *)navigationView {
    _navigationView = navigationView;
    if ([_navigationView isKindOfClass:[UINavigationBar class]]) {
        _mNavigationViewType = NavigationTypeNav;
    } else {
        _mNavigationViewType = NavigationTypeCustom;
    }
}

- (void)handlResultWithNewValue:(NSValue *)newVale {
    if (_mNavigationViewType == NavigationTypeCustom) {
        if (_navigationType == NavigationTypeFade) {
            [self scrollViewDidScrollCustomViewFade];
        } else {
             [self scrollViewDidScrollCustomViewHiden];
        }
    } else {
        if (_navigationType == NavigationTypeFade) {
            [self scrollViewDidScrollNavFade];
        } else {
            [self scrollViewDidScrollNavHiden];
        }
    }
}

#pragma mark - NavHiden
- (void)scrollViewDidScrollCustomViewHiden {
    CGFloat offsetY = _mScrollView.contentOffset.y;
    if (offsetY > 0) {
        if (offsetY >= 44) {
            [self setCustomNavigationBarTransformProgress:1];
        } else {
            [self setCustomNavigationBarTransformProgress:(offsetY / 44)];
        }
    } else {
        [self setCustomNavigationBarTransformProgress:0];
//        UINavigationBar *navigationBar = nil;
//        navigationBar.backIndicatorImage = [UIImage new];
    }
}

- (void)setCustomNavigationBarTransformProgress:(CGFloat)progress {
   _navigationView.transform = CGAffineTransformMakeTranslation(0, (-44 * progress));
   _navigationView.alpha = (1-progress);
    self.overlay.alpha = progress;
}

- (void)lt_setTranslationY:(CGFloat)translationY {
    _navigationView.transform = CGAffineTransformMakeTranslation(0, translationY);
}


- (void)scrollViewDidScrollNavHiden {
    CGFloat offsetY = _mScrollView.contentOffset.y;
    if (offsetY > 0) {
        if (offsetY >= 44) {
            [self setNavigationBarTransformProgress:1];
        } else {
            [self setNavigationBarTransformProgress:(offsetY / 44)];
        }
    } else {
        [self setNavigationBarTransformProgress:0];
        UINavigationBar *navigationBar = nil;
        if ([_navigationView isKindOfClass:[UINavigationBar class]]) {
            navigationBar = (UINavigationBar *)_navigationView;
        } else {
            return;
        }
        navigationBar.backIndicatorImage = [UIImage new];
    }
}


- (void)setNavigationBarTransformProgress:(CGFloat)progress {
    UINavigationBar *navigationBar = nil;
    if ([_navigationView isKindOfClass:[UINavigationBar class]]) {
        navigationBar = (UINavigationBar *)_navigationView;
    } else {
        return;
    }
    [navigationBar lt_setTranslationY:(-44 * progress)];
    [navigationBar lt_setElementsAlpha:(1-progress)];
}


#pragma mark - NavFade
- (void)scrollViewDidScrollNavFade {
    UIColor * color = _navColor;
    CGFloat offsetY = _mScrollView.contentOffset.y;
    UINavigationBar *navigationBar = nil;
    if ([_navigationView isKindOfClass:[UINavigationBar class]]) {
        navigationBar = (UINavigationBar *)_navigationView;
    } else {
        return;
    }
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

- (void)scrollViewDidScrollCustomViewFade {
    CGFloat minAlphaOffset = - 64;
    CGFloat maxAlphaOffset = 200;
    CGFloat offset = _mScrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    UIEdgeInsets offsetInset = UIEdgeInsetsZero;
    //    if (offset < 0) {
    //        alpha = 0;
    //    }
    _navigationView.alpha = (offset > -10);
    if (offset < 5) {
        alpha = 0;
    }
    //head section 位置调整
    if (alpha >= 1) {
        offsetInset = UIEdgeInsetsMake(_navigationView.frame.size.height, 0, 0, 0);
        _mScrollView.contentInset = offsetInset;
    }
    if (offset > 5 && offset < 80) {
        offsetInset = UIEdgeInsetsZero;
        _mScrollView.contentInset = offsetInset;
    }
    _navigationView.alpha = alpha;
}
@end
