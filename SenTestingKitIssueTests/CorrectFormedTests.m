#import <SenTestingKit/SenTestingKit.h>
#import <APIClient.h>

@interface CorrectFormedTests : SenTestCase
    @property (nonatomic, assign) dispatch_semaphore_t semaphore;
@end

@implementation CorrectFormedTests

- (void)runTestWithBlock:(void (^)(void))block {
    self.semaphore = dispatch_semaphore_create(0);

    block();

    while (dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_NOW))
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate dateWithTimeIntervalSinceNow:2]];

    dispatch_release(self.semaphore);
}

- (void)blockTestCompletedWithBlock:(void (^)(void))block {
    dispatch_semaphore_signal(self.semaphore);

    if (block) {
        block();
    }
}

- (void)testTestRequestUsingDispatchSemaphore
{
    [self runTestWithBlock:^{
        [[APIClient sharedClient] getPath:@"timezoneJSON" parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
            [self blockTestCompletedWithBlock:^{
                NSLog(@"\nSuccess");
            }];


        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self blockTestCompletedWithBlock:^{
                NSLog(@"\nSuccess");
            }];
        }];
    }];
}

@end