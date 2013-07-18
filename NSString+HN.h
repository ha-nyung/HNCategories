//
//  NSString+HN.h
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

BOOL NSStringIsEmpty(NSString *string);
BOOL NSStringIsNotEmpty(NSString *string);

@interface NSString (HN)

- (BOOL)isValidEmail;
- (NSString *)stringByTrimmingWhiteSpaces;
- (NSString *)escapeURL;
- (NSString *)escapeHTMLEntities;
- (NSDictionary *)parseQueryString;
- (id)JSONObjectWithOptions:(NSJSONReadingOptions)opt error:(NSError **)error;

/**
 * hashing methods are origianlly implemented by Justin Swanson
 * https://github.com/geeksunny/NSStringNSData-Hashes
 */
- (NSString *)md5;
- (NSString *)sha1;
- (NSString *)sha256;
- (NSString *)sha512;

@end
