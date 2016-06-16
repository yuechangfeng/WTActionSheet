//
//  BSActionSheet.m
//  kjfsdj
//
//  Created by BSoft on 16/6/15.
//  Copyright © 2016年 BSoft. All rights reserved.
//

#import "BSActionSheet.h"
//
#import "Headers.h"

#define kAnimationTime 0.3
#define kSeparator_Height 6
#define kSeparatorLine_Height 0.5

#define kMaskAlpha 0.3

#define kFontTitle_Default 13
#define kFontContent_Default 17

#define kPerCotnentHeight 50

#define ColorContentSelected [UIColor colorWithRed:0.8392 green:0.8392 blue:0.8392 alpha:1.0]
#define CellLineColor [UIColor colorWithRed:0.8392 green:0.8392 blue:0.8392 alpha:1.0]

@interface BSActionSheet ()

//UI
@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UIView *viewCotnent;
//数据源
@property (nonatomic, strong) NSString *strTitle;
@property (nonatomic, strong) NSArray *arrCotnents;
//action
@property (nonatomic, copy) BlockClickCancel clickCancelBlock;
@property (nonatomic, copy) BlockClickContent clickContentBlock;

@end

@implementation BSActionSheet

- (instancetype)initWithTitle:(NSString *)title contents:(NSArray *)contents blockClickContent:(BlockClickContent)blockClickContent blockClickCancel:(BlockClickCancel)blockClickCancel
{
    self = [super init];
    if (self) {
        self.strTitle = title;
        self.arrCotnents = contents;
        self.clickCancelBlock = blockClickCancel;
        self.clickContentBlock = blockClickContent;
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        //
        [self configureUI];
    }
    return self;
}

#pragma mark - Private Method
- (void)configureUI
{
    self.backgroundColor = RGBA(0, 0, 0, kMaskAlpha);
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelf)];
    [self addGestureRecognizer:tapG];
    //content
    CGRect frameCotnent = [self getBottomCotnentFrame];
    self.viewCotnent = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, frameCotnent.size.width, frameCotnent.size.height)];
    self.viewCotnent.backgroundColor = RGBCOLOR(233, 233, 238);
    [self addSubview:self.viewCotnent];
    //
    CGFloat y = 0;//记录下一个控件的 y
    if (self.strTitle) {//有标题
        self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kPerCotnentHeight)];
        self.labelTitle.backgroundColor = [UIColor whiteColor];
        self.labelTitle.text = self.strTitle;
        self.labelTitle.textAlignment = NSTextAlignmentCenter;
        self.labelTitle.font = [UIFont systemFontOfSize:kFontTitle_Default];
        self.labelTitle.textColor = RGB(111, 111, 111);
        [self.viewCotnent addSubview:self.labelTitle];
        y += kPerCotnentHeight;
    }
    //
    for (int i = 0; i < self.arrCotnents.count; i++) {
        UIButton *btnContent = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btnContent.frame = CGRectMake(0, y, SCREEN_WIDTH, kPerCotnentHeight);
        btnContent.tag = 10000 + i;
        btnContent.titleLabel.font = [UIFont systemFontOfSize:kFontContent_Default];
        [btnContent setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:(UIControlStateNormal)];
        [btnContent setBackgroundImage:[UIImage imageWithColor:ColorContentSelected] forState:(UIControlStateHighlighted)];
        [btnContent addTarget:self action:@selector(btnClickContent:) forControlEvents:(UIControlEventTouchUpInside)];
        
        if ([self.arrCotnents[i] isKindOfClass:[NSDictionary class]]) {//字典数组
            NSDictionary *dicObj = self.arrCotnents[i];
            [btnContent setTitle:dicObj[BSActionSheetContentTitleKey] forState:(UIControlStateNormal)];
            [btnContent setTitleColor:dicObj[BSActionSheetContentColorKey] forState:(UIControlStateNormal)];
        } else {//字符串数组
            [btnContent setTitle:self.arrCotnents[i] forState:(UIControlStateNormal)];
            [btnContent setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        }
        
        [self.viewCotnent addSubview:btnContent];
        //
        y += kPerCotnentHeight;
    }
    //取消按钮
    y += kSeparator_Height;
    self.btnCancel = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.btnCancel.frame = CGRectMake(0, y, SCREEN_WIDTH, kPerCotnentHeight);
    [self.btnCancel setTitle:@"取消" forState:(UIControlStateNormal)];
    self.btnCancel.titleLabel.font = [UIFont systemFontOfSize:kFontContent_Default];
    [self.btnCancel setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.btnCancel setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:(UIControlStateNormal)];
    [self.btnCancel setBackgroundImage:[UIImage imageWithColor:ColorContentSelected] forState:(UIControlStateHighlighted)];
    [self.btnCancel addTarget:self action:@selector(btnClickCancel) forControlEvents:(UIControlEventTouchUpInside)];
    [self.viewCotnent addSubview:self.btnCancel];
    //添加线条
    if (self.arrCotnents.count > 0) {
        NSInteger lineCount = 0;
        if (self.strTitle) {
            lineCount = self.arrCotnents.count;
        } else {
            lineCount = self.arrCotnents.count - 1;
        }
        //线条
        for (int i = 0; i < lineCount; i++) {
            UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, (i + 1) * kPerCotnentHeight, SCREEN_WIDTH, kSeparatorLine_Height)];
            viewLine.backgroundColor = CellLineColor;
            [self.viewCotnent addSubview:viewLine];
        }
    }
}

- (CGRect)getBottomCotnentFrame
{
    return CGRectMake(0, SCREEN_HEIGHT - [self getMainContentHeight], SCREEN_WIDTH, [self getMainContentHeight]);
}

- (CGFloat)getMainContentHeight
{
    if (self.strTitle) {
        return (self.arrCotnents.count + 1) * kPerCotnentHeight + kSeparator_Height + kPerCotnentHeight;
    } else {
        return self.arrCotnents.count * kPerCotnentHeight + kSeparator_Height + kPerCotnentHeight;
    }
}

#pragma mark - action
- (void)tapSelf
{
    [self closeSelf];
}

- (void)btnClickContent:(UIButton *)sender
{
    self.clickContentBlock(sender.tag - 10000);
    [self closeSelf];
}

- (void)btnClickCancel
{
    self.clickCancelBlock();
    [self closeSelf];
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.backgroundColor = RGBA(0, 0, 0, 0);
    //
    [UIView animateWithDuration:kAnimationTime animations:^{
        self.backgroundColor = RGBA(0, 0, 0, kMaskAlpha);
        self.viewCotnent.frame = [self getBottomCotnentFrame];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)closeSelf
{
    [UIView animateWithDuration:kAnimationTime animations:^{
        CGRect rectContent = [self getBottomCotnentFrame];
        self.viewCotnent.frame = CGRectMake(0, SCREEN_HEIGHT, rectContent.size.width, rectContent.size.height);
        self.backgroundColor = RGBA(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - getter & setter
- (void)setTxtColorTitle:(UIColor *)txtColorTitle
{
    if (_txtColorTitle != txtColorTitle) {
        _txtColorTitle = txtColorTitle;
    }
    self.labelTitle.textColor = txtColorTitle;
}

- (void)setTxtColorCancel:(UIColor *)txtColorCancel
{
    if (_txtColorCancel != txtColorCancel) {
        _txtColorCancel = txtColorCancel;
    }
    [self.btnCancel setTitleColor:txtColorCancel forState:(UIControlStateNormal)];
}

- (void)setFontTitle:(UIFont *)fontTitle
{
    if (_fontTitle != fontTitle) {
        _fontTitle = fontTitle;
    }
    self.labelTitle.font = fontTitle;
}

- (void)setFontCancel:(UIFont *)fontCancel
{
    if (_fontCancel != fontCancel) {
        _fontCancel = fontCancel;
    }
    self.btnCancel.titleLabel.font = fontCancel;
}

@end
