//
//  SMSplitViewController.m
//  SMSplitViewController
//
//  Created by Sergey Marchukov on 15.02.14.
//  Copyright (c) 2014 Sergey Marchukov. All rights reserved.
//
//  This content is released under the ( http://opensource.org/licenses/MIT ) MIT License.
//  Repository: https://github.com/sergik-ru/SMTabbedSplitViewController
//  Version 1.0.3
//

#import "SMTabbedSplitViewController.h"
#import "SMMasterViewController.h"
#import "SMTabBar.h"

@interface SMTabbedSplitViewController () <SMTabBarDelegate>
{
    SMMasterViewController *_masterVC;
    BOOL _masterIsHidden;
}
@end

@implementation SMTabbedSplitViewController
#pragma mark -
#pragma mark - Inititalization
- (id)init {
    return [self initTabbedSplit];
}
- (id)initTabbedSplit {
    self = [super init];
    if (self) {
        _tabBar = [[SMTabBar alloc] init];
        _tabBar.delegate = self;
        _masterVC = [[SMMasterViewController alloc] init];
    }
    return self;
}
- (id)initSplit {
    self = [super init];
    if (self) {
        _splitType = SMDefaultSplit;
        _masterVC = [[SMMasterViewController alloc] init];
    }
    return self;
}
#pragma mark -
#pragma mark - ViewController Lifecycle
- (void)loadView {
    [super loadView];
    self.view.backgroundColor = [UIColor clearColor];
    if (_splitType == SMTabbedSplt) {
        
        [self.view addSubview:_tabBar.view];
    }
    [self.view addSubview:_masterVC.view];
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:_masterVC.view.frame];
    _masterVC.view.layer.masksToBounds = NO;
    _masterVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
    _masterVC.view.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    _masterVC.view.layer.shadowOpacity = 1.5f;
    _masterVC.view.layer.shadowRadius = 2.5f;
    _masterVC.view.layer.shadowPath = shadowPath.CGPath;
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    if (_masterIsHidden)
        return;
    CGRect masterFrame = [self masterVCFrame];
    _masterVC.view.frame = masterFrame;
}
#pragma mark -
#pragma mark - Frames
- (CGRect)masterVCFrame {
    return (_splitType == SMTabbedSplt) ? CGRectMake(70, 0, self.view.bounds.size.width, self.view.bounds.size.height) : CGRectMake(0, 0, self.view.bounds.size.width - 70, self.view.bounds.size.height);
}
#pragma mark -
#pragma mark - Properties
- (UIViewController *)masterViewController {
    return _masterVC.viewController;
}
- (void)setViewControllers:(NSArray *)viewControllers {
    _viewControllers = viewControllers;
    _masterVC.viewController = _viewControllers[0];
}
- (void)setBackground:(UIColor *)background {
    _tabBar.view.backgroundColor = background;
    _masterVC.view.backgroundColor = background;
}
- (void)setTabsViewControllers:(NSArray *)tabsViewControllers {
    _tabsViewControllers = tabsViewControllers;
    _tabBar.tabsButtons = _tabsViewControllers;
}
- (void)setActionsButtons:(NSArray *)actionsTabs {
    _actionsButtons = actionsTabs;
    _tabBar.actionsButtons = _actionsButtons;
}
#pragma mark -
#pragma mark - Actions

- (void)hideMaster {
    CATransition *transitionMaster = [CATransition animation];
    transitionMaster.type = kCATransitionPush;
    transitionMaster.subtype = kCATransitionFromRight;
    [_masterVC.view.layer addAnimation:transitionMaster forKey:@"hideOrAppear"];
    [UIView animateWithDuration:0.2 animations:^{
        _masterIsHidden = YES;
        [self.view setNeedsLayout];
    }];
}
- (void)showMaster {
    _masterIsHidden = NO;
    [self.view setNeedsLayout];
    
    CATransition *transitionMaster = [CATransition animation];
    transitionMaster.type = kCATransitionPush;
    transitionMaster.subtype = kCATransitionFromLeft;
    transitionMaster.duration = 0.2;
    [_masterVC.view.layer addAnimation:transitionMaster forKey:@"hideOrAppear"];
}
#pragma mark -
#pragma mark - Autorotation
- (BOOL)shouldAutorotate {
    return YES;
}
- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}
#pragma mark -
#pragma mark - TabBarDelegate
- (void)tabBar:(SMTabBar *)tabBar selectedViewController:(UIViewController *)vc {
    if (_masterIsHidden) {
        _masterIsHidden = NO;
        [self.view setNeedsLayout];
    }
    _masterVC.viewController = vc;
}
@end
