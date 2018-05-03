//
//  FontAndColorMacros.h
//  BasicFrame
//
//  Created by zkingsoft on 2018/5/2.
//

#ifndef FontAndColorMacros_h
#define FontAndColorMacros_h

#pragma mark - 间距区

//默认间距
#define kNormalSpace 12.0f

#pragma mark -  颜色区
//主题色 导航栏颜色
#define CNavBgColor  [UIColor colorWithHexString:@"00AE68"]
//#define CNavBgColor  [Ulor colorWithHexString:@"ffffff"]
#define CNavBgFontColor  [UIColor colorWithHexString:@"ffffff"]

//默认页面背景色
#define CViewBgColor [UIColor colorWithHexString:@"f2f2f2"]

//颜色
#define kClearColor [UIColor clearColor]
#define kWhiteColor [UIColor whiteColor]
#define kBlackColor [UIColor blackColor]
#define kGrayColor [UIColor grayColor]
#define kGray2Color [UIColor lightGrayColor]
#define kBlueColor [UIColor blueColor]
#define kRedColor [UIColor redColor]
#define kRandomColor    KRGBColor(arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0,arc4random_uniform(256)/255.0)        //随机色生成

//十六进制色值
#define HexRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//分割线颜色
#define CLineColor [UIColor colorWithHexString:@"ededed"]

#pragma mark -  字体区


#endif /* FontAndColorMacros_h */
