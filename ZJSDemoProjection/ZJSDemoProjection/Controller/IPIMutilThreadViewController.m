//
//  MutilThreadViewController.m
//  ZJSDemoProjection
//
//  Created by ipi on 16/6/6.
//  Copyright © 2016年 zjs. All rights reserved.
//

/**
 *  http://www.knowsky.com/884482.html //死锁
 *
 *  http://blog.jobbole.com/69019/ //荣芳志的Blog
 *
 *  http://www.cnblogs.com/kenshincui/p/3983982.html //KenshinCui
 
 关键是如何控制好各个线程的执行顺序、处理好资源竞争问题
 
 1.NSThread
 
 2.NSOperation
 
 3.GCD
 
 + (void)detachNewThreadSelector:(SEL)selector toTarget:(id)target withObject:(id)argumen
 - (instancetype)initWithTarget:(id)target selector:(SEL)selector object:(id)argument
 
 //http://img5.imgtn.bdimg.com/it/u=2033765348,1346395611&fm=21&gp=0.jpg
 
 
 */

#import "IPIMutilThreadViewController.h"

@interface IPIMutilThreadViewController ()

@end

@implementation IPIMutilThreadViewController

#pragma mark - lifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"IPIMutilThreadViewController");
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:YES];
    
    //    [self caseOne];
    //    [self caseTwo];
    //    [self caseThree];
//        [self caseThour];
//        [self caseFive];
    
    [self loadImageWithMultiThread];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSThread

- (void)threadMethod{

    //1
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(doSomethingA) object:nil];
    [thread start];
    
    //2
    [NSThread detachNewThreadSelector:@selector(doSomethingA) toTarget:self withObject:nil];
    
    //3
    
}

#pragma mark -NSOperation

//NSInvocationOperation NSBlockOperation

- (void)operationMethod{

    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(doSomethingA) object:nil];
    
    NSOperationQueue * operationQueue = [[NSOperationQueue alloc] init];
    
    [operationQueue addOperation:operation];
    
    [operationQueue addOperationWithBlock:^{
        [self doSomethingA];
    }];

    
    
}


- (void)doSomethingA{
    
    NSLog(@"%@",[NSThread currentThread]);
    [NSThread sleepForTimeInterval:3.0];
    NSLog(@"A");
}




#pragma mark -GCD

-(void)loadImageWithMultiThread{

//    dispatch_queue_t queue = dispatch_queue_create("myThreadQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue = dispatch_queue_create("myThreadQueue", DISPATCH_QUEUE_CONCURRENT);

    
    for (int i = 0; i < 100; i ++) {
        
        dispatch_async(queue, ^{
            //
            
            [self doSomethingWithIndex:i];

        });
    }
    
}

- (void)doSomethingWithIndex:(int)index{

    NSLog(@"subThread index = %d", index);
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        //
        NSLog(@"main index = %d",index);
        
    });
}


#pragma mark 死锁

- (void)caseOne{
    
    NSLog(@"1"); // 任务1
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"2"); // 任务2
    });
    NSLog(@"3"); // 任务3
   
}


- (void)caseTwo{
    
    NSLog(@"1"); // 任务1
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSLog(@"2"); // 任务2
    });
    NSLog(@"3"); // 任务3
}


- (void)caseThree{
    
    dispatch_queue_t queue = dispatch_queue_create("com.demo.serialQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"1"); // 任务1
    dispatch_async(queue, ^{
        NSLog(@"2"); // 任务2
        dispatch_sync(queue, ^{
            NSLog(@"3"); // 任务3
        });
        NSLog(@"4"); // 任务4
    });
    NSLog(@"5"); // 任务5
    
}


- (void)caseThour{
    
    NSLog(@"1"); // 任务1
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"2"); // 任务2
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"3"); // 任务3
        });
        NSLog(@"4"); // 任务4
    });
    NSLog(@"5"); // 任务5
    
}


- (void)caseFive{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1"); // 任务1
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"2"); // 任务2
        });
        NSLog(@"3"); // 任务3
    });
    NSLog(@"4"); // 任务4
    while (1) {
    }
    
    NSLog(@"5"); // 任务5
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
