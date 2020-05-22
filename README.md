# 笔声SDK集成文档
[![Version](https://img.shields.io/cocoapods/v/ABCCamereKit.svg?style=flat)](http://cocoapods.org/pods/ABCCamereKit)
[![License](https://img.shields.io/cocoapods/l/ABCCamereKit.svg?style=flat)](http://cocoapods.org/pods/ABCCamereKit)
[![Platform](https://img.shields.io/cocoapods/p/ABCCamereKit.svg?style=flat)](http://cocoapods.org/pods/ABCCamereKit)

[TOC]

### REVISION HISTORY
Version | Date |Changed By |Changes
------|------|------|------
0.0.1 | 2020-05-22|Bing|init

### 准备环境
请确保满足以下开发环境要求：
- Apple XCode 11.0或以上版本
- iOS 11.0或以上版本
- ABCAuthKit
- ABCCameraKit
- ABCDetector
- ABCDetector
- ABCOpenCVImageKit
- ABCPDFKit

### pod导入
~~~
pod 'ABCCameraKit', '~>0.0.1'
~~~

### ABCCameraKit快速集成
#### 授权(生成ABCCameraKit 授权用的secret)

~~~
/**
 secret建议放在服务端生成
 */
-(NSString *) genneraSecret
{
    NSString *packageName = [[NSBundle mainBundle] bundleIdentifier];
    NSString *expireTime = [self getExpireTime];//生成过期时间
    NSString *secret = [NSString stringWithFormat:@"appId=%@&expireTime=%@&packageName=%@",appId,expireTime,packageName];//生产密钥
    secret = [self stringToMD5:secret]; //md5转换
    secret = [NSString stringWithFormat:@"%@&appSecret=%@",secret,appSecret];//生成带有secret的密钥
    secret = [[self stringToMD5:secret] uppercaseString];
    secret = [NSString stringWithFormat:@"%@.%@",expireTime,secret];//拼接expireTime 和secert 逗号隔开
    return secret;
}
~~~
