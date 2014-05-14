//
//  YRJSONAdapt.h
//  YRSnippets
//
//  Created by 王晓宇 on 14-5-13.
//  Copyright (c) 2014年 王晓宇. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *	@class	JSON的简单适配器,5.0以上使用系统的
 */
@interface YRJSONAdapter : NSObject

+(id)objectFromJSONString:(NSString*)string;
+(id)mutableObjectFromJSONString:(NSString*)string;
+(id)objectFromJSONData:(NSData*)data;
+(id)mutableObjectFromJSONData:(NSData*)data;

+(NSString*)stringWithObject:(id)object;
+(NSData*)dataWithObject:(id)object;
@end


//category，like JSONKit
@interface NSString (YRJSONDeserializing)
- (id)objectFromJSONString;
- (id)mutableObjectFromJSONString;
@end

@interface NSData (YRJSONDeserializing)
// The NSData MUST be UTF8 encoded JSON.
- (id)objectFromJSONData;
- (id)mutableObjectFromJSONData;
@end


@interface NSString (YRJSONSerializing)
- (NSData *)JSONData;
- (NSString *)JSONString;
@end

@interface NSArray (YRJSONSerializing)
- (NSData *)JSONData;
- (NSString *)JSONString;
@end

@interface NSDictionary (YRJSONSerializing)
- (NSData *)JSONData;
- (NSString *)JSONString;
@end