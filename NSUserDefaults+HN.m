//
//  NSUserDefaults+HN.m
//  Godiva
//
//  Created by Josh Chung on 3/21/13.
//  Copyright (c) 2013 Kakao. All rights reserved.
//

#import "NSUserDefaults+HN.h"

@implementation NSUserDefaults (HN)

- (void)asyncSaveValue:(id)value forKey:(NSString *)key
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setValue:value forKey:key];
        [self synchronize];
    });
}

- (void)asyncSaveDictionary:(NSDictionary *)dict
{
    dispatch_async(dispatch_get_main_queue(), ^{
        for (NSString *key in dict.allKeys)
            [self setValue:[dict valueForKey:key] forKey:key];
        [self synchronize];
    });
}

@end
