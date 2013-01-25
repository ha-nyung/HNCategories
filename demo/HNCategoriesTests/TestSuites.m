//
//  TestSuites.m
//  HNCategories
//
//  Created by Josh Chung on 1/25/13.
//  Copyright (c) 2013 Josh Ha-Nyung Chung. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>

#import "NSString+HN.h"

@interface TestSuites : GHTestCase
@end

@implementation TestSuites

- (void)testNSString {
  GHTestLog(@"NSString category begins");

  GHTestLog(@"trim...");

  NSString *stringWithSpaces = @"  test string    ";
  NSString *stringWithoutSpaces = @"test string";
  NSString *trimmed = [stringWithSpaces trimWhiteSpaces];
//  NSString *trimmed = stringWithSpaces;
  GHAssertEqualObjects(trimmed, stringWithoutSpaces, nil);

  GHTestLog(@"NSString category ends");
}
@end
