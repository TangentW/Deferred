//
//  DemoView.m
//  Deferred
//
//  Created by Tan on 15/12/2017.
//  Copyright © 2017 Tangent. All rights reserved.
//

#import "DemoView.h"
#import "UIControl+Deferred.h"
#import "DemoViewModel.h"
#import "UILabel+Deferred.h"

@interface DemoView () {
    DemoViewModel *_viewModel;
}
@property(nonatomic, strong) UIButton *button;
@property(nonatomic, strong) UILabel *label;
@end

@implementation DemoView
- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button setTitle:@"Action" forState:UIControlStateNormal];
        _button.backgroundColor = [UIColor redColor];
        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:17];
        _button.translatesAutoresizingMaskIntoConstraints = false;
    }
    return _button;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont systemFontOfSize:17];
        _label.translatesAutoresizingMaskIntoConstraints = false;
        _label.numberOfLines = 2;
    }
    return _label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.button];
    [self.view addSubview:self.label];
    NSArray *constraints = @[
                             [self.button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                             [self.button.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
                             [self.button.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:20],
                             [self.button.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-20],
                             [self.button.heightAnchor constraintEqualToConstant:60],
                             [self.label.leftAnchor constraintEqualToAnchor:self.button.leftAnchor],
                             [self.label.rightAnchor constraintEqualToAnchor:self.button.rightAnchor],
                             [self.label.bottomAnchor constraintEqualToAnchor:self.button.topAnchor constant:-20]
                             ];
    [NSLayoutConstraint activateConstraints:constraints];
    
    // Button的Deferred作为输入，创建ViewModel, 用ViewModel的输出进行UI渲染
    _viewModel = [[DemoViewModel alloc]initWithActionDeferred:[self.button deferredWithEvents:UIControlEventTouchUpInside]];
    [self.label displayBy:_viewModel.output];
}

@end
