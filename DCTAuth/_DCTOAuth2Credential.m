//
//  _DCTOAuth2Credential.m
//  DCTAuth
//
//  Created by Daniel Tull on 23/02/2013.
//  Copyright (c) 2013 Daniel Tull. All rights reserved.
//

#import "_DCTOAuth2Credential.h"

const struct _DCTOAuth2CredentialProperties {
	__unsafe_unretained NSString *clientID;
	__unsafe_unretained NSString *clientSecret;
	__unsafe_unretained NSString *accessToken;
	__unsafe_unretained NSString *refreshToken;
} _DCTOAuth2CredentialProperties;

const struct _DCTOAuth2CredentialProperties _DCTOAuth2CredentialProperties = {
	.clientID = @"clientID",
	.clientSecret = @"clientSecret",
	.accessToken = @"accessToken",
	.refreshToken = @"refreshToken"
};

@implementation _DCTOAuth2Credential

- (id)initWithClientID:(NSString *)clientID
		  clientSecret:(NSString *)clientSecret
		   accessToken:(NSString *)accessToken
		  refreshToken:(NSString *)refreshToken {

	if (clientID.length == 0) return nil;
	if (accessToken.length == 0) return nil;

	self = [self init];
	if (!self) return nil;
	_clientID = [clientID copy];
	_clientSecret = [clientSecret copy];
	_accessToken = [accessToken copy];
	_refreshToken = [refreshToken copy];
	return self;
}

- (id)initWithCoder:(NSCoder *)coder {
	self = [self init];
	if (!self) return nil;
	_clientID = [coder decodeObjectForKey:_DCTOAuth2CredentialProperties.clientID];
	_clientSecret = [coder decodeObjectForKey:_DCTOAuth2CredentialProperties.clientSecret];
	_accessToken = [coder decodeObjectForKey:_DCTOAuth2CredentialProperties.accessToken];
	_refreshToken = [coder decodeObjectForKey:_DCTOAuth2CredentialProperties.refreshToken];
	return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
	[coder encodeObject:self.clientID forKey:_DCTOAuth2CredentialProperties.clientID];
	[coder encodeObject:self.clientSecret forKey:_DCTOAuth2CredentialProperties.clientSecret];
	[coder encodeObject:self.accessToken forKey:_DCTOAuth2CredentialProperties.accessToken];
	[coder encodeObject:self.refreshToken forKey:_DCTOAuth2CredentialProperties.refreshToken];
}

- (NSString *)description {
	return [NSString stringWithFormat:@"<%@: %p; %@ = %@; %@ = %@; %@ = %@; %@ = %@>",
			NSStringFromClass([self class]),
			self,
			_DCTOAuth2CredentialProperties.clientID, self.clientID,
			_DCTOAuth2CredentialProperties.clientSecret, self.clientSecret,
			_DCTOAuth2CredentialProperties.accessToken, self.accessToken,
			_DCTOAuth2CredentialProperties.refreshToken, self.refreshToken];
}

@end
