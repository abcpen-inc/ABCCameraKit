//
//  ABCPDF.h
//  ABCPDFKit
//
//  Created by bingo on 2020/5/22.
//  Copyright © 2020 杭州笔声智能科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ABCPDF : NSObject

/**
 图片生成pdf文档
 imagePaths: 图片地址（使用path处理避免内存上传输图片的问题）
 pageSize: 生产的pdf 尺寸
 padding:边缘padding
 */

+ (NSString *)genneraPdfWithImages:(NSArray *)imagePaths
                         pageWidth:(float) pageWidth
                        pageHeight:(float) pageHeight
                           padding:(float) padding;

@end

NS_ASSUME_NONNULL_END
