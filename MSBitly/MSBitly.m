//
//  MSBitly.m
//  SPhotoNews
//
//  Created by Sieg on 5/30/11.
//  Copyright 2011 Seth Corp. All rights reserved.
// 

#import "MSBitly.h"
#import "JSONKit.h"

#define bitly_shorten @"http://api.bitly.com/v3/shorten?login=%@&apiKey=%@&"
#define bitly_expand @"http://api.bitly.com/v3/expand?%@&login=%@&apiKey=%@&format=txt"

//For more features -- http://code.google.com/p/bitly-api/wiki/ApiDocumentation

@implementation MSBitly

- (MSBitly *) initWithUsername:(NSString*)loginName andAPIKey:(NSString*)userAPI {
    username = [loginName copy];
    apiKey = [userAPI copy];
	return self;
}

- (NSString *) shortenURL:(NSString*)longURL {
    
    NSString *urlWithoutParams = [NSString stringWithFormat:bitly_shorten , username, apiKey];	
    NSString* encoded = (NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                            (CFStringRef) longURL, NULL, CFSTR("&+"), kCFStringEncodingUTF8);
	NSString *parameters = [NSString stringWithFormat:@"longUrl=%@%@", [encoded stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], @"&format=json"];
	NSString *finalURL = [urlWithoutParams stringByAppendingString:parameters];

	NSURL *url = [NSURL URLWithString:finalURL];
	NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:url];
		
	NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];	
    
    if (data != nil) {
    
    JSONDecoder *decoder = [JSONDecoder decoder];
    NSData *jsonData = [NSData dataWithData:data];

    NSDictionary *items = [decoder objectWithData:jsonData];        
    NSString *statusTxt = [items objectForKey:@"status_txt"];
        
        if([statusTxt isEqualToString:@"OK"])
        {
            NSString *shortURL = [[items objectForKey:@"data"] objectForKey:@"url"];
            return shortURL;
        }
    } 
    
    return nil;
}

- (NSString *) expandURL:(NSString*)shortURL 
{
    NSString* encoded = (NSString*) CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                            (CFStringRef) shortURL, NULL, CFSTR("&+"), kCFStringEncodingUTF8);
    NSString *parameters = [NSString stringWithFormat:@"shortUrl=%@", [encoded stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *finalURL = [NSString stringWithFormat:bitly_expand, parameters, username, apiKey];

    NSURL *url = [NSURL URLWithString:finalURL];  
	NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:url];
    	
	NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];	
	
    NSString *longURL = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    return longURL;
}

- (void) dealloc {
    [super dealloc];
    [username release];
    [apiKey release];
}

@end
