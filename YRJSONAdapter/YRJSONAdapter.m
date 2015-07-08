//
//  YRJSONAdapt.m
//  YRSnippets
//
//  Created by 王晓宇 on 14-5-13.
//  Copyright (c) 2014年 王晓宇. All rights reserved.
//

#import "YRJSONAdapter.h"

@implementation YRJSONAdapter

+(id)objectFromJSONString:(NSString*)string{
    NSData *data=[string dataUsingEncoding:NSUTF8StringEncoding];
    return [self objectFromJSONData:data];
}
+(id)mutableObjectFromJSONString:(NSString*)string{
    NSData *data=[string dataUsingEncoding:NSUTF8StringEncoding];
    return [self mutableObjectFromJSONData:data];
}
+(id)objectFromJSONData:(NSData*)data{
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
}
+(id)mutableObjectFromJSONData:(NSData*)data{
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}

+(NSString*)stringWithObject:(id)object{
    NSString *string=nil;
    NSData *data=[self dataWithObject:object];
    if (data) {
        string=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }
    return string;
}
+(NSData*)dataWithObject:(id)object{
    NSData *data=nil;
    if ([NSJSONSerialization isValidJSONObject:object]) {
        data=[NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
    }else{
        NSLog(@"--->>object %@ not a json object",object);
    }
    return data;
}
@end



@implementation NSString (YRJSONDeserializing)
- (id)objectFromJSONString{
    return [YRJSONAdapter objectFromJSONString:self];
}
- (id)mutableObjectFromJSONString{
    return [YRJSONAdapter mutableObjectFromJSONString:self];
}
@end

@implementation NSData (YRJSONDeserializing)
// The NSData MUST be UTF8 encoded JSON.
- (id)objectFromJSONData{
    return [YRJSONAdapter objectFromJSONData:self];
}
- (id)mutableObjectFromJSONData{
    return [YRJSONAdapter mutableObjectFromJSONData:self];
}
@end


@implementation NSString (YRJSONSerializing)
- (NSData *)JSONData{
    return [YRJSONAdapter dataWithObject:self];
}
- (NSString *)JSONString{
    return [YRJSONAdapter stringWithObject:self];
}
@end

@implementation NSArray (YRJSONSerializing)
- (NSData *)JSONData{
    return [YRJSONAdapter dataWithObject:self];
}
- (NSString *)JSONString{
    return [YRJSONAdapter stringWithObject:self];
}
@end

@implementation NSDictionary (YRJSONSerializing)
- (NSData *)JSONData{
    return [YRJSONAdapter dataWithObject:self];
}
- (NSString *)JSONString{
    return [YRJSONAdapter stringWithObject:self];
}
@end
