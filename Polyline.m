//
//  Polyline.m
//  Demo1
//
//  Created by speedx on 16/4/8.
//  Copyright © 2016年 shandandan. All rights reserved.
//

#import "Polyline.h"
#import <MapKit/MapKit.h>

@implementation Polyline

-(double)decodeSingleCoordinate:( const char *)byteArray length:(int)length position:(int)position precision:(double)precision {

    precision = 100*1000.0;
    if (self.position < length) {
        
    } else{
        // 错误异常
        return 0;
    }
    
    int bitMask = 0x1F;
    int coordinate = 0;
    int currentChar;
    int componentCounter = 0;
    int component = 0;
    do {
        currentChar = byteArray[self.position] - 63;
        component = (currentChar & bitMask);
        coordinate |= (component << (5*componentCounter));
        self.position++;
        componentCounter++;
    } while (((currentChar & 0x20) == 0x20) && (self.position < length) && (componentCounter < 6)) ;
    
    if((componentCounter == 6) && ((currentChar & 0x20) == 0x20)){
        // 报错
        return 0.0f;
    }

    if ((coordinate & 0x01) == 0x01) {
        coordinate = ~(coordinate >> 1);
    }
    else {
        coordinate = coordinate >> 1;
    }
    return (double)coordinate / precision;
}

/**
 *  根据谷歌的decoded Polyline 获取 解压后的 经纬度
 *
 *  @param encodedPolyline 谷歌的压缩的 polyline 字符串 （@"_p~iF~ps|U_ulLnnqC_mqNvxq`@"）
 *
 *  @return 经纬度数组
 */
-(NSArray *)decodePolyline:(NSString *)encodedPolyline{
    NSData *data = [encodedPolyline dataUsingEncoding:NSUTF8StringEncoding];
    char* byteArray = (char*)data.bytes;
    int length = (int)data.length;
    self.position = 0;
    NSMutableArray *result = [NSMutableArray array];
    double lat = 0.0;
    double lon = 0.0;
    double precision = 100*1000.0;
   
    while (self.position < length){
        @try {
            double resultingLat = [self decodeSingleCoordinate:byteArray length:length position:self.position precision:precision];
            lat += resultingLat;
            
            double resultingLon = [self decodeSingleCoordinate:byteArray length:length position:self.position precision:precision];
            lon += resultingLon;
        } @catch (NSException *exception) {

        } @finally {
            
        }
        
        CLLocationCoordinate2D cl = CLLocationCoordinate2DMake(lat, lon);
        [result addObject:[NSValue valueWithMKCoordinate:cl]];
    };
    return result;
}

@end
