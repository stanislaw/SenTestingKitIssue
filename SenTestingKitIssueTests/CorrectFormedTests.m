// https://github.com/AFNetworking/AFNetworking/issues/466#issuecomment-7926896
// The issue is that dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER); blocks the thread and waits for the signal to continue execution, however and now i have to guess .. since AFNetworking does its inner workings also in threads it the success block is executed in a dispatch_group_t which might not get thru with the semaphore blocking.

// The difference is that i don't have the DISPATCH_TIME_FOREVER on the semaphore but rather DISPATCH_TIME_NOW in a while which keeps the semaphore waiting but not blocking, in addition the runloop continues to be executed causing AFNetworking to continue as intended and when the signal finally is sent to the semaphore the loop will break.

// I might be totally wrong on this, but thats what i have observed so far and well it does work ;)

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
