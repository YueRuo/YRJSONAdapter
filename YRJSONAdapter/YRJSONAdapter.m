//
//  YRJSONAdapt.m
//  YRSnippets
//
//  Created by 王晓宇 on 14-5-13.
//  Copyright (c) 2014年 王晓宇. All rights reserved.
//

#import "YRJSONAdapter.h"
#import <objc/runtime.h>

@implementation NSString (YRJSONDeserializing)
- (id)objectFromJSONString{
    return nil;
}
- (id)mutableObjectFromJSONString{
    return nil;
}
- (id)yr_objectFromJSONString{
    return [YRJSONAdapter objectFromJSONString:self];
}
- (id)yr_mutableObjectFromJSONString{
    return [YRJSONAdapter mutableObjectFromJSONString:self];
}
@end

@implementation NSData (YRJSONDeserializing)
- (id)objectFromJSONData{
    return nil;
}
- (id)mutableObjectFromJSONData{
    return nil;
}
- (id)yr_objectFromJSONData{
    return [YRJSONAdapter objectFromJSONData:self];
}
- (id)yr_mutableObjectFromJSONData{
    return [YRJSONAdapter mutableObjectFromJSONData:self];
}
@end


@implementation NSString (YRJSONSerializing)
- (NSData *)JSONData{
    return nil;
}
- (NSString *)JSONString{
    return nil;
}
- (NSData *)yr_JSONData{
    return [YRJSONAdapter dataWithObject:self];
}
- (NSString *)yr_JSONString{
    return [YRJSONAdapter stringWithObject:self];
}
@end

@implementation NSArray (YRJSONSerializing)
- (NSData *)JSONData{
    return nil;
}
- (NSString *)JSONString{
    return nil;
}
- (NSData *)yr_JSONData{
    return [YRJSONAdapter dataWithObject:self];
}
- (NSString *)yr_JSONString{
    return [YRJSONAdapter stringWithObject:self];
}
@end

@implementation NSDictionary (YRJSONSerializing)
- (NSData *)JSONData{
    return nil;
}
- (NSString *)JSONString{
    return nil;
}
- (NSData *)yr_JSONData{
    return [YRJSONAdapter dataWithObject:self];
}
- (NSString *)yr_JSONString{
    return [YRJSONAdapter stringWithObject:self];
}
@end



@implementation YRJSONAdapter
+(void)swizzleInstanceMethodForClass:(Class)class origin:(SEL)origin replace:(SEL)replace{
    Method orignMethod = class_getInstanceMethod(class, origin);
    Method replaceMethod = class_getInstanceMethod(class, replace);
    if (class_addMethod(class, origin, method_getImplementation(replaceMethod), method_getTypeEncoding(replaceMethod))) {
        class_replaceMethod(class, replace, method_getImplementation(orignMethod), method_getTypeEncoding(orignMethod));
    }else{
        method_exchangeImplementations(orignMethod, replaceMethod);
    }
}

+(void)load{
    [self swizzleInstanceMethodForClass:[NSString class] origin:@selector(objectFromJSONString) replace:@selector(yr_objectFromJSONString)];
    [self swizzleInstanceMethodForClass:[NSString class] origin:@selector(mutableObjectFromJSONString) replace:@selector(yr_mutableObjectFromJSONString)];
    [self swizzleInstanceMethodForClass:[NSData class] origin:@selector(objectFromJSONData) replace:@selector(yr_objectFromJSONData)];
    [self swizzleInstanceMethodForClass:[NSData class] origin:@selector(mutableObjectFromJSONData) replace:@selector(yr_mutableObjectFromJSONData)];
    [self swizzleInstanceMethodForClass:[NSString class] origin:@selector(JSONData) replace:@selector(yr_JSONData)];
    [self swizzleInstanceMethodForClass:[NSString class] origin:@selector(JSONString) replace:@selector(yr_JSONString)];
    [self swizzleInstanceMethodForClass:[NSArray class] origin:@selector(JSONData) replace:@selector(yr_JSONData)];
    [self swizzleInstanceMethodForClass:[NSArray class] origin:@selector(JSONString) replace:@selector(yr_JSONString)];
    [self swizzleInstanceMethodForClass:[NSDictionary class] origin:@selector(JSONData) replace:@selector(yr_JSONData)];
    [self swizzleInstanceMethodForClass:[NSDictionary class] origin:@selector(JSONString) replace:@selector(yr_JSONString)];
}

+(id)objectFromJSONString:(NSString*)string{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self objectFromJSONData:data];
}
+(id)mutableObjectFromJSONString:(NSString*)string{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [self mutableObjectFromJSONData:data];
}
+(id)objectFromJSONData:(NSData*)data{
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
}
+(id)mutableObjectFromJSONData:(NSData*)data{
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}

+(NSString*)stringWithObject:(id)object{
    NSString *string = nil;
    NSData *data = [self dataWithObject:object];
    if (data) {
        string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }
    return string;
}
+(NSData*)dataWithObject:(id)object{
    NSData *data = nil;
    if ([NSJSONSerialization isValidJSONObject:object]) {
        data = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
    }else{
        NSLog(@"--->>object %@ not a json object",object);
    }
    return data;
}
@end