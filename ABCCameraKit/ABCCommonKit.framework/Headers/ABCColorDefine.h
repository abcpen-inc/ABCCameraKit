//
//  ABCColorDefine.h
//  ABCCommonKit
//
//  Created by bingo on 2019/7/16.
//  Copyright © 2019 杭州笔声智能科技有限公司. All rights reserved.
//

#ifndef ABCColorDefine_h
#define ABCColorDefine_h

#pragma mark - Color
#define kResourceColorWithRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define kResourceColorWithRGBA(R, G, B, A)    [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]


#if __has_include("BFKit.h")
//主色
#define COLOR_C1 [UIColor hex:@"FF6464"] // 76ADEF
#define COLOR_C2 [UIColor hex:@"5A70A7"]
#define COLOR_C3 [UIColor hex:@"5A8BFF"]
#define COLOR_C4 [UIColor hex:@"FF7376"]
#define COLOR_C5 [UIColor hex:@"FF7400"]
#define COLOR_C6 [UIColor hex:@"FF5500"]
#define COLOR_C7 [UIColor hex:@"4DD7BF"]//表格薄荷绿
#define COLOR_C8 [UIColor hex:@"66C9E1"]//表格薄荷绿

//黑到白
#define COLOR_000000 [UIColor hex:@"000000"]
#define COLOR_B1 [UIColor hex:@"333333"]
#define COLOR_B2 [UIColor hex:@"666666"]
#define COLOR_B3 [UIColor hex:@"999999"]
#define COLOR_B4 [UIColor hex:@"AFB0B0"]
#define COLOR_B5 [UIColor hex:@"DEDEDE"]
#define COLOR_B6 [UIColor hex:@"F0F0F0"]
#define COLOR_B7 [UIColor hex:@"FFFFFF"]
#define COLOR_B8 [UIColor hex:@"F8F8F8"]
#define COLOR_B9 [UIColor hex:@"F9F9F9"]

#define COLOR_E2E2E2 [UIColor hex:@"E2E2E2"]
#define COLOR_FF586D [UIColor hex:@"FF586D"]
#define COLOR_D6D6D6 [UIColor hex:@"D6D6D6"]
#define COLOR_D9DADA [UIColor hex:@"D9DADA"]
#define COLOR_F3F3F3 [UIColor hex:@"F3F3F3"]
#define COLOR_F5F5F5 [UIColor hex:@"F5F5F5"]
#define COLOR_F6F6F6 [UIColor hex:@"F6F6F6"]
#define COLOR_D9D9D9 [UIColor hex:@"D9D9D9"]
#define COLOR_E5E5E5 [UIColor hex:@"E5E5E5"]
#define COLOR_E6E6E6 [UIColor hex:@"E6E6E6"]
#define COLOR_E9E9E9 [UIColor hex:@"E9E9E9"]
#define COLOR_E13F56 [UIColor hex:@"E13F56"]
#define COLOR_FF0000 [UIColor hex:@"FF0000"]//红色
#define COLOR_F68686 [UIColor hex:@"F68686"]
#define COLOR_4C4C4C [UIColor hex:@"4C4C4C"]
#define COLOR_55CE63 [UIColor hex:@"55CE63"]
#define COLOR_CCCCCC [UIColor hex:@"CCCCCC"]

#define COLOR_E35844 [UIColor hex:@"E35844"]
#define COLOR_F39179 [UIColor hex:@"F39179"]
#define COLOR_CA3B36 [UIColor hex:@"CA3B36"]
#define COLOR_EEEEEE [UIColor hex:@"EEEEEE"]
#define COLOR_FFC1C1 [UIColor hex:@"FFC1C1"]
#define COLOR_F1F1F1 [UIColor hex:@"F1F1F1"]
#define COLOR_222222 [UIColor hex:@"222222"]
#define COLOR_FEFEFE [UIColor hex:@"FEFEFE"]
#define COLOR_F95050 [UIColor hex:@"F95050"]
#define COLOR_ABABAB [UIColor hex:@"ABABAB"]
#define COLOR_1A1A1A [UIColor hex:@"1A1A1A"]
#define COLOR_E50033 [UIColor hex:@"E50033"]

#define COLOR_LINE [UIColor hex:@"EEEEEE"]
#define COLOR_BACKGROUND COLOR_F5F5F5
#define COLOR_MASK [UIColor colorWithWhite:0 alpha:0.4]

#else
#endif

#endif /* ABCColorDefine_h */
