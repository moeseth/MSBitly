//
//  MSBitlyDemoViewController.m
//  MSBitlyDemo
//
//  Created by Sieg on 6/3/11.
//  Copyright 2011 Seth Corp. All rights reserved.
//

#import "MSBitlyDemoViewController.h"
#import "MSBitly.h"

static NSString *kAPI = nil;
static NSString *kUsername = nil;

//Check out http://bit.ly/a/your_api_key

@implementation MSBitlyDemoViewController

- (void)dealloc
{
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (kAPI == nil)
        [NSException raise:NSInvalidArgumentException format:@"Put in your bit.ly info first!!!"];
    

    MSBitly *bitlyDemo = [[MSBitly alloc] initWithUsername:kUsername andAPIKey:kAPI];

    //shortening
  //NSString *str = [bitlyDemo shortenURL:@"http://itunes.com/w00tylab"];

    //To expand bit.ly link
    NSString *str = [bitlyDemo expandURL:@"http://dl.wootylab.com/mOX61R"];
        
    [bitlyDemo release];
    NSLog(@"%@", str);
}

@end
