//
//  NSObject+HN.m
//  HNCategories
//
// This is under The MIT License
//
// Copyright © 2013 Josh Ha-Nyung Chung <minorblend@gmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

#import "NSObject+HN.h"

#import <objc/runtime.h>

@implementation NSObject (HN)

+ (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay {
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC);
  dispatch_after(popTime, dispatch_get_main_queue(), block);
}

- (void)enumeratePropertiesUsingBlock:(void (^)(NSString *))block {
  unsigned int outCount, i;
  objc_property_t *properties = class_copyPropertyList([self class], &outCount);
  for (i = 0; i < outCount; i++) {
    objc_property_t property = properties[i];
    const char *property_name = property_getName(property);
    if (property_name) {
      NSString *propertyName = [NSString stringWithUTF8String:property_name];
      if (block)
        block(propertyName);
    }
  }
  
  free(properties);
}

- (void)setPropertiesFrom:(id)source {
  [self enumeratePropertiesUsingBlock:^(NSString *propertyName) {
    if ([source respondsToSelector:NSSelectorFromString(propertyName)])
      [self setValue:[source valueForKey:propertyName] forKey:propertyName];
  }];
}
@end
