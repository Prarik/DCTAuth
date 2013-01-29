//
//  DCTAuthResponse.h
//  DCTAuth
//
//  Created by Daniel Tull on 22.01.2013.
//  Copyright (c) 2013 Daniel Tull. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCTAuthResponse : NSObject

- (id)initWithData:(NSData *)data URLResponse:(NSHTTPURLResponse *)response;
- (id)initWithURL:(NSURL *)URL;

@property (nonatomic, readonly) NSInteger statusCode;
@property (nonatomic, readonly) NSDictionary *HTTPHeaders;
@property (nonatomic, readonly) NSURL *URL;
@property (nonatomic, readonly) NSData *data;

@property (nonatomic, readonly) id contentObject;

@end