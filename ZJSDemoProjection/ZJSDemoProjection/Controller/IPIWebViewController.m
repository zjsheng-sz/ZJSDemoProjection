//
//  IPIWebViewController.m
//  ZJSDemoProjection
//
//  Created by ipi on 16/3/22.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import "IPIWebViewController.h"
#import <Masonry.h>
#import "NSString+IPI.h"
#import <Reachability/Reachability.h>

@interface IPIWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation IPIWebViewController

#pragma mark getter/setter

- (UIWebView *)webView{

    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        [self.view addSubview:_webView];
        UIEdgeInsets padding = UIEdgeInsetsMake(64, 0, 50, 0);
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.equalTo(self.view).insets(padding);
        }];
        
    }
    return _webView;
}

#pragma mark life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSString *testURL = @"http://www.programering.com/a/MzNzgTMwATg.html";
    self.view.backgroundColor = [UIColor whiteColor];
//
//  [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:testURL] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:10.0]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 0, 0)];
    
    NSString *string = @"546499464645465479794646";
    
    label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:14];
    CGSize size = [string getTextWidthWithMaxHeight:30 font:14];
    
    label.frame = CGRectMake(0, 60, size.width, size.height);
    label.text = string;
    
    
    [self.view addSubview:label];
    
    [self textNetStatue];
    
}

- (void)textNetStatue{

    // Allocate a reachability object
    Reachability* reach = [Reachability reachabilityWithAddress:@"112.80.248.73"];
    NSLog(@"www.baidu.com");
    
    // Set the blocks
    reach.reachableBlock = ^(Reachability*reach)
    {
        // keep in mind this is called on a background thread
        // and if you are updating the UI it needs to happen
        // on the main thread, like this:
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"REACHABLE!");
        });
    };
    
    reach.unreachableBlock = ^(Reachability*reach)
    {
        NSLog(@"UNREACHABLE!");
    };
    
    [reach startNotifier];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma other

#pragma mark UIWebViewDelegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

}

- (void)webViewDidFinishLoad:(UIWebView *)webView{

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
