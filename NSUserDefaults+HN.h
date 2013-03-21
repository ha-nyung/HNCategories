//
//  NSUserDefaults+HN.h
//  Godiva
//
//  Created by Josh Chung on 3/21/13.
//  Copyright (c) 2013 Kakao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (HN)

- (void)asyncSaveValue:(id)value forKey:(NSString *)key;
- (void)asyncSaveDictionary:(NSDictionary *)dict;

@end
