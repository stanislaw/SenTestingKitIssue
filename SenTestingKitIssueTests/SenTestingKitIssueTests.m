#import <SenTestingKit/SenTestingKit.h>
#import <APIClient.h>

@interface SenTestingKitIssueTests : SenTestCase

@end

@implementation SenTestingKitIssueTests

- (void)testTestRequest
{
    NSLog(@"Beginning");
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    [[APIClient sharedClient] getPath:@"timezoneJSON" parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSLog(@"Success");
        
        STAssertTrue(TRUE, @"Authenticate result should be YES");
        
        dispatch_semaphore_signal(sema);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error");
    }];
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    dispatch_release(sema);

}

@end
