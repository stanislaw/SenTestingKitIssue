#import <SenTestingKit/SenTestingKit.h>
#import <APIClient.h>

@interface FailingTests : SenTestCase

@end

@implementation FailingTests

// Both below will begin to hang

//- (void)testTestRequestUsingDispatchSemaphore
//{
//    NSLog(@"Beginning");
//    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
//    
//    [[APIClient sharedClient] getPath:@"timezoneJSON" parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
//        NSLog(@"Success");
//        
//        STAssertTrue(TRUE, @"Authenticate result should be YES");
//        
//        dispatch_semaphore_signal(sema);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error");
//    }];
//    
//    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//    dispatch_release(sema);
//}
//
//- (void)testTestRequestUsingDispatchSync
//{
//    NSLog(@"Beginning");
//
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        [[APIClient sharedClient] getPath:@"timezoneJSON" parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
//            NSLog(@"\nSuccess");
//
//
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"\nError");
//        }];
//    });
//    
//    STAssertTrue(TRUE, @"Authenticate result should be YES");
//}

@end
