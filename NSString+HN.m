//
//  NSString+HN.m
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

#import "NSString+HN.h"

@implementation NSString (HN)

- (BOOL)isValidEmail {
  static NSString *const emailRegex =
  @"(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"
  @"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"
  @"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"
  @"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"
  @"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"
  @"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"
  @"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
  NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
  return [emailPredicate evaluateWithObject:self];
}

- (NSString *)stringByTrimmingWhiteSpaces {
  return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)escapeURL {
  static NSString *const charactersToBeEscaped = @"!*'();:@&=+$,/?%#[]";

  return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                               (__bridge CFStringRef)self,
                                                                               NULL,
                                                                               (__bridge CFStringRef)charactersToBeEscaped,
                                                                               kCFStringEncodingUTF8);
}

- (NSString *)escapeHTMLEntities {
  NSMutableString *tmp = [self mutableCopy];
  [tmp replaceOccurrencesOfString:@"&" withString:@"&amp;" options:0 range:NSMakeRange(0, tmp.length)];
  [tmp replaceOccurrencesOfString:@"<" withString:@"&lt;" options:0 range:NSMakeRange(0, tmp.length)];
  [tmp replaceOccurrencesOfString:@">" withString:@"&gt;" options:0 range:NSMakeRange(0, tmp.length)];
  [tmp replaceOccurrencesOfString:@"""" withString:@"&quot;" options:0 range:NSMakeRange(0, tmp.length)];
  [tmp replaceOccurrencesOfString:@"'" withString:@"&#039;" options:0 range:NSMakeRange(0, tmp.length)];
  [tmp replaceOccurrencesOfString:@" " withString:@"&nbsp;" options:0 range:NSMakeRange(0, tmp.length)];

  return tmp;
}

- (id)JSONObjectWithOptions:(NSJSONReadingOptions)opt error:(NSError **)error {
  NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
  return [NSJSONSerialization JSONObjectWithData:data options:opt error:error];
}

- (NSDictionary *)parseQueryString {
  NSMutableDictionary *qs = [NSMutableDictionary dictionary];

  for (NSString *component in [self componentsSeparatedByString:@"&"]) {
    NSArray *pair = [component componentsSeparatedByString:@"="];
    if (pair.count != 2)
      continue;
    NSString *key = pair[0];
    NSString *value = [(NSString *)pair[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [qs setValue:value forKey:key];
  }

  return [NSDictionary dictionaryWithDictionary:qs];
}

BOOL NSStringIsEmpty(NSString *string) {
  return [[string stringByTrimmingWhiteSpaces] length] == 0;
}

BOOL NSStringIsNotEmpty(NSString *string) {
  return !NSStringIsEmpty(string);
}
@end
