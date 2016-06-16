//
//  BSSystemConfigure.h
//  BSMedical
//
//  系统配置
//  Created by 王通 on 16/4/7.
//  Copyright © 2016年 BSoft. All rights reserved.
//

#ifndef BSSystemConfigure_h
#define BSSystemConfigure_h

/* ********************系统配置********************* */
#define kBSAPP_Name @"掌上居民" //应用名称
#define kBSUser_Safe_Protocol_Name @"XXXX协议" //用户注册协议
#define kBSUtype    @"1" //版本类型(1: 居民; 2:医生)

//定义 API 主地址
//#define kAPIURL_Platform   @"http://192.168.0.131:8081" //钟凯磊

#define kAPIURL_Platform   @"http://115.236.19.147:13888/pop" //平台(外网)
#define kAPIURL_Proxy      @"http://115.236.19.147:13888/pop" //业务(外网)
#define kAPIURL_Ckb        @"http://115.236.19.147:14188/ckbserver/view/index" //健康百科(ckb)(外网)

//配置项目是单机构还是多机构
//影响 预约挂号流程
#define BSREG_SINGLE_AGENCY_FLAG      YES


//百度地图 App key
//#define kBSBaiduMap_AppKey  @"a3rn1I0bd1PfeWT5k7CP3lpo2WvrYGRL"//商店版
#define kBSBaiduMap_AppKey  @"a3rn1I0bd1PfeWT5k7CP3lpo2WvrYGRL"//企业版

//极光推送 App key
//#define kJPush_AppKey       @"4a1e9733d478ab1a27065fcd" //商店版
#define kBSJPush_AppKey       @"4a1e9733d478ab1a27065fcd" //企业版
static BOOL isJPushProduction = NO;  //极光推送: 是否生产环境. 开发环境: NO; 生产环境: YES.


/* ********************一些颜色配置********************* */

//APP 主题颜色
#define kBSAppThemeColor UIColorFromRGB(0x36bf84)
//导航栏颜色
#define kBSNavBarColor UIColorFromRGB(0x36bf84)
#define kBSNavBarTitleColor UIColorFromRGB(0xffffff)
//View 默认背景色
#define kBSViewDefaultBackgroundColor UIColorFromRGB(0xeeeeee)
//分割线颜色
#define kBSSeparatorLineColor UIColorFromRGB(0xcccccc)
//不可用时显示的颜色
#define kBSDisableColor UIColorFromRGB(0xdcdcdc)
//字体颜色
#define kBSTitleColor    UIColorFromRGB(0x323232)
#define kBSSubTitleColor UIColorFromRGB(0x999999)
//字体大小
#define kBSNavTitleFont [UIFont systemFontOfSize:19]
#define kBSTitleFont    [UIFont systemFontOfSize:14]
#define kBSSubTitleFont [UIFont systemFontOfSize:12]

#endif /* BSSystemConfigure_h */
