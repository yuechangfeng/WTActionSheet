//
//  ViewController.m
//  WTActionSheet
//
//  Created by BSoft on 16/6/16.
//  Copyright © 2016年 BSoft. All rights reserved.
//

#import "ViewController.h"
#import "BSActionSheet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnA:(id)sender {
    //    NSArray *arrContents = @[@{BSActionSheetContentTitleKey: @"拍照",
    //                               BSActionSheetContentColorKey: [UIColor blackColor]
    //                               },
    //                             @{BSActionSheetContentTitleKey: @"相册选取",
    //                               BSActionSheetContentColorKey: [UIColor greenColor]
    //                               },
    //                             @{BSActionSheetContentTitleKey: @"其他",
    //                               BSActionSheetContentColorKey: [UIColor orangeColor]
    //                               }
    //                             ];
    
    NSArray *arrContents = @[@"拍照", @"相册选取", @"其他"];
    BSActionSheet *sheet = [[BSActionSheet alloc] initWithTitle:@"设置" contents:arrContents blockClickContent:^(NSInteger index) {
        NSLog(@"index: %ld", index);
    } blockClickCancel:^{
        NSLog(@"点击取消");
    }];
    [sheet show];
}

@end
