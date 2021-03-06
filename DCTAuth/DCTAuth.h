//
//  DCTAuth.h
//  DCTAuth
//
//  Created by Daniel Tull on 25/08/2012.
//  Copyright (c) 2012 Daniel Tull. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCTAuthAccount.h"
#import "DCTAuthAccountStore.h"
#import "DCTAuthRequest.h"

/** DCTAuth is a library to handle multiple authentication types for services 
 that use OAuth, OAuth 2.0 and basic authentication.
 */
@interface DCTAuth : NSObject

#pragma mark - Handling Web Redirects


/** Applications should call this method when they get opened with a URL
 to handle OAuth and OAuth 2.0 callbacks. This would be
 application:handleOpenURL and
 application:openURL:sourceApplication:annotation: on iOS.
 @param URL The URL that was called to open the application.
 @return YES if the URL was handled; NO if it wasn't handled.
 */
+ (BOOL)handleURL:(NSURL *)URL;

/** Applications can supply their own webview UI for opening a
 web-based URL by providing a block to open the given URL and
 indictate by returning YES, that the URL has been shown to the 
 user;
 
 The application should monitor when the browser loads pages and 
 for each new request in the webview, should call handleURL: to 
 see if that call is the callback that DCTAuth is waiting for.
 
 Calling handleURL: will check to see if the URL is the callback
 so you can use the result of that to decide to show the new load
 or not.

 @param opener The block that will handle the display of the web page.
 @see handleURL:
 */
+ (void)setURLOpener:(BOOL(^)(NSURL *URL))opener;

/** Allows the application or custom DCTAuthAccount subclasses to 
 open a webpage with the default or custom URLOpener.

 @param URL URL of the webpage to load
 @param callbackPrefixURL The URL that will be checked for
 @param handler Block that is called with the full callbackURL
 @return An opaque object that can be used to cancel this call.

 @see handleURL:
 @see setURLOpener:
 */
+ (id)openURL:(NSURL *)URL withCallbackURL:(NSURL *)callbackPrefixURL handler:(void (^)(DCTAuthResponse *response))handler;

/** Used to cancel the search for a callback from an open URL call.
 
 This must be called if the authentication has been cancelled, otherwise
 future calls to openURL: will be mismatched.

 @param object The object received in openURL:withCallbackURL:handler:
 @see openURL:withCallbackURL:handler:
 */
+ (void)cancelOpenURL:(id)object;

#pragma mark - Performing requests

/** Allows the application to provide a custom way of loading
 URL requests made by DCTAuth. This could be used to allow 
 requests to be added to a networking library such as AFNetworking.
 
 The performer block must load the given URLRequest and call the 
 handler block provided. 

 @param requestPerformer Block to handle loading of a NSURLRequest
 */
+ (void)setURLRequestPerformer:(void(^)(NSURLRequest *URLRequest, DCTAuthRequestHandler handler))requestPerformer;

/** A method to look up a localized error for an authentication failure.
 
 It will look in the application bundle for a Localizable.strings file first
 and try to get a string from that. If none is found it will get one from
 it's own bundle's strings file.
 
 DCTAuth contains some localized error codes for OAuth 2 only currently.
 
 Error keys are as DCTAuth.OAuth2.access_denied and the domain passed here
 refers to the "OAuth2" part and the key is "access_denied". This method creates
 the full key.
 
 @param domain The domain for the string, this is the second part of the total key
 @param key The key for the string
 @return Localized string
 */
+ (NSString *)localizedStringForDomain:(NSString *)domain key:(NSString *)key;

@end
