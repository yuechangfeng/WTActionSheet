//
//  BSActionSheet.h
//  kjfsdj
//
//  Created by BSoft on 16/6/15.
//  Copyright © 2016年 BSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlockClickCancel)();
typedef void(^BlockClickContent)(NSInteger index);

#define BSActionSheetContentTitleKey @"BSActionSheetContentTitleKey"//标题
#define BSActionSheetContentColorKey @"BSActionSheetContentColorKey"//颜色

@interface BSActionSheet : UIView

@property (nonatomic, strong) UIColor *txtColorTitle;
@property (nonatomic, strong) UIFont *fontTitle;
@property (nonatomic, strong) UIColor *txtColorCancel;
@property (nonatomic, strong) UIFont *fontCancel;

/**
 *  初始化 actionsheet
 *
 *  @param title             标题
 *  @param contents          内容(字符串数组或者字典数组)
                                (字典格式如下:
                                {BSActionSheetContentTitleKey: "aa", 
                                 BSActionSheetContentColorKey: [UIColor greenColor]}
                                )
 *  @param blockClickContent 内容点击
 *  @param blockClickCancel  取消点击
 *
 *  @return 实例
 */
- (instancetype)initWithTitle:(NSString *)title contents:(NSArray *)contents blockClickContent:(BlockClickContent)blockClickContent blockClickCancel:(BlockClickCancel)blockClickCancel;

- (void)show;

@end


