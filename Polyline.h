//
//  Polyline.h
//  Demo1
//
//  Created by speedx on 16/4/8.
//  Copyright © 2016年 shandandan. All rights reserved.
//

/*
 
 // 预期结果
 //    lon= -120.2 lat===38.5
 //    lon= -120.95 lat===40.7
 //    lon= -126.453 lat===43.252
 // 测试谷歌的polyLine
 NSString *encodedPolyline = @"_p~iF~ps|U_ulLnnqC_mqNvxq`@";
 // 测试---------------------------------------
 Polyline *p = [[Polyline alloc]init];
 NSArray *arry =  [p decodePolyline:encodedPolyline];
 for (int i = 0; i <arry.count; i++) {
 CLLocationCoordinate2D last = [(NSValue *)arry[i] MKCoordinateValue];
 NSLog(@"lat = %f lon = %f",last.latitude,last.longitude);
 }
 
 */
#import <Foundation/Foundation.h>

@interface Polyline : NSObject

@property (assign, atomic) int position;

/**
 *  根据谷歌的decoded Polyline 获取 解压后的 经纬度
 *
 *  @param encodedPolyline 谷歌的压缩的 polyline 字符串 （@"_p~iF~ps|U_ulLnnqC_mqNvxq`@"）
 *
 *  @return 经纬度数组
 */
-(NSArray *)decodePolyline:(NSString *)encodedPolyline;

@end
