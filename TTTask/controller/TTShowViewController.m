//
//  TTShowViewController.m
//  TTTask
//
//  Created by 黄家鑫 on 2018/4/2.
//  Copyright © 2018年 黄家鑫. All rights reserved.
//

#import "TTShowViewController.h"
#import "TTFeedbackViewController.h"

@interface TTShowViewController ()<UITextViewDelegate>

@property (nonatomic, strong)UITextView *showTextView;

@property (nonatomic, strong)NSDictionary *subViews;

@end

@implementation TTShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    [self.view addSubview:self.showTextView];
    
    self.subViews = NSDictionaryOfVariableBindings(_showTextView);
    
    [self setLayout];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods

- (void)setLayout {
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_showTextView]-10-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:self.subViews]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_showTextView(50)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:self.subViews]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.showTextView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:0]];
}

#pragma mark - lazy load

- (UITextView *)showTextView {
    if (!_showTextView) {
        _showTextView = [[UITextView alloc]init];
        [_showTextView setBackgroundColor:[UIColor whiteColor]];
        _showTextView.delegate = self;
        _showTextView.editable = NO;
        _showTextView.textAlignment = NSTextAlignmentJustified;
        _showTextView.scrollEnabled = NO;
        _showTextView.translatesAutoresizingMaskIntoConstraints = NO;
        
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"欢迎使用探探,在使用过程中有疑问请反馈"];
        
        NSInteger lineHeight = 1;
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(17, 2)];
        [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:lineHeight] range:NSMakeRange(17, 2)];
        [str addAttribute:NSLinkAttributeName value:@"jump://up" range:NSMakeRange(17, 2)];
        
        _showTextView.attributedText = str;
    }
    return _showTextView;
}

#pragma mark - textViewDelegate

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    if ([[URL scheme] containsString:@"jump"]) {
        TTFeedbackViewController *vc = [[TTFeedbackViewController alloc]init];
        vc.title = @"TTFeedbackViewController";
        [self.navigationController pushViewController:vc animated:YES];
    }
    return NO;
}

@end
