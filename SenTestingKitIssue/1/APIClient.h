#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface APIClient : AFHTTPClient

+ (APIClient *)sharedClient;

@end
