//
//  DCTAuth.m
//  DCTAuth
//
//  Created by Daniel Tull on 27/08/2012.
//  Copyright (c) 2012 Daniel Tull. All rights reserved.
//

#import "DCTAuth.h"
#import "_DCTAuthURLOpener.h"
#import "_DCTAuthURLRequestPerformer.h"

NSString *const DCTAuthBundleName = @"DCTAuth.bundle";

@implementation DCTAuth

+ (BOOL)handleURL:(NSURL *)URL {
	return [[_DCTAuthURLOpener sharedURLOpener] handleURL:URL];
}

+ (void)setURLOpener:(BOOL(^)(NSURL *URL))opener {
	[[_DCTAuthURLOpener sharedURLOpener] setURLOpener:opener];
}

+ (id)openURL:(NSURL *)URL withCallbackURL:(NSURL *)callbackPrefixURL handler:(void (^)(DCTAuthResponse *response))handler {
	return [[_DCTAuthURLOpener sharedURLOpener] openURL:URL withCallbackURL:callbackPrefixURL handler:handler];
}

+ (void)cancelOpenURL:(id)object {
	[[_DCTAuthURLOpener sharedURLOpener] close:object];
}

+ (void)setURLRequestPerformer:(void(^)(NSURLRequest *request, DCTAuthRequestHandler handler))requestPerformer {
	[[_DCTAuthURLRequestPerformer sharedURLRequestPerformer] setURLRequestPerformer:requestPerformer];
}

+ (NSString *)localizedStringForDomain:(NSString *)domain key:(NSString *)key {
	
	NSString *fullKey = [NSString stringWithFormat:@"DCTAuth.%@.%@", domain, key];	
	
	NSString *uniqueString = [[NSProcessInfo processInfo] globallyUniqueString];
	NSString *value = [[NSBundle mainBundle] localizedStringForKey:fullKey value:uniqueString table:nil];
	if (![value isEqualToString:uniqueString]) return value;
	
	NSBundle *bundle = [self _bundle];
	value = [bundle localizedStringForKey:fullKey value:uniqueString table:nil];
	if (![value isEqualToString:uniqueString]) return value;
	
	return nil;
}

+ (NSBundle *)_bundle {
	static NSBundle *bundle;
	static dispatch_once_t bundleToken;
	dispatch_once(&bundleToken, ^{
		NSDirectoryEnumerator *enumerator = [[NSFileManager new] enumeratorAtURL:[[NSBundle mainBundle] bundleURL]
													  includingPropertiesForKeys:nil
																		 options:NSDirectoryEnumerationSkipsHiddenFiles
																	errorHandler:NULL];
		
		for (NSURL *URL in enumerator)
			if ([[URL lastPathComponent] isEqualToString:DCTAuthBundleName])
				bundle = [NSBundle bundleWithURL:URL];
	});
	
	return bundle;
}

@end
