//
//  MSBitly.h
//  SPhotoNews
//
//  Created by Sieg on 5/30/11.
//  Copyright 2011 Seth Corp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSBitly : NSObject {
	NSString *username;
	NSString *apiKey;
}

- (MSBitly *) initWithUsername:(NSString*)loginName andAPIKey:(NSString*)userAPI;
- (NSString *) shortenURL:(NSString*)longURL;
- (NSString *) expandURL:(NSString*)shortURL;

@end
