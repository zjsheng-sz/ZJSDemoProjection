//
//  IPIMessageViewController.m
//  ZJSDemoProjection
//
//  Created by ipi on 16/3/24.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import "IPIMessageViewController.h"
#import <MessageUI/MFMessageComposeViewController.h>


@interface IPIMessageViewController ()<MFMessageComposeViewControllerDelegate>

@end

@implementation IPIMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self sendSMS:@"hello world" recipientList:@[@"18602075917"]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipientslist
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {

        
        controller.body = bodyOfMessage;
        controller.recipients = recipientslist;
        controller.messageComposeDelegate = self;
        
        //        controller.navigationBar.tintColor = [UIColor whiteColor];
        //        controller.navigationBar.barStyle = UIBarStyleDefault;
        
        //        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        //        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
        
        [self presentViewController:controller animated:NO completion:nil];
        controller.view.backgroundColor = [UIColor whiteColor];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{

    switch (result) {
        case MessageComposeResultCancelled:
            [controller dismissViewControllerAnimated:YES completion:nil];
            
            break;
            
        case MessageComposeResultSent:
            [controller dismissViewControllerAnimated:YES completion:nil];
            
            break;
            
        case MessageComposeResultFailed:
            [controller dismissViewControllerAnimated:YES completion:nil];
            
            break;
            
        default:
            break;
    }

}

@end
