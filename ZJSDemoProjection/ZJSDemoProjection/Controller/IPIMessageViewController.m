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
{
    UIActionSheet *datePickerSheeet;
}
@end

@implementation IPIMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self sendSMS:@"hello world" recipientList:@[@"18602075917"]];

    [self showDatePicker];
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

- (void)showDatePicker
{
    if (datePickerSheeet == nil) {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n" delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];

        UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0f, 44.0f, 0.0f, 0.0f)];
        datePicker.datePickerMode = UIDatePickerModeDate;
        datePicker.tag = 10;
        datePicker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];

        [datePicker setDate:[NSDate date]];    //显示当前时间
        [datePicker setUserInteractionEnabled:YES];  //
        
        UIToolbar *pickerDateToolBar = [[UIToolbar alloc]  initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, 44)]; //创建工具条，用来设置或者退出actionsheet.
        pickerDateToolBar.barStyle = UIBarStyleBlackTranslucent;
        [pickerDateToolBar sizeToFit];
        
        NSMutableArray *barItems = [[NSMutableArray alloc] init];
        UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        [barItems addObject:flexSpace];
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(datePickerCancelClick:)];
        [barItems addObject:cancelButton];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(datePickerDoneClick:)];
        [barItems addObject:doneButton];
        
        [pickerDateToolBar setItems:barItems animated:YES]; //将按键加入toolbar
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 11.0f, 100.0f, 22.0f)];
        label.text = @"选择出生日期";
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        [label sizeToFit];
        [pickerDateToolBar addSubview:label];
        
        [actionSheet addSubview:pickerDateToolBar];

        [actionSheet addSubview:datePicker];
        datePicker.backgroundColor = [UIColor redColor];
        datePickerSheeet = actionSheet;
    }
    
//    [datePickerSheeet showInView: [UIApplication sharedApplication].keyWindow];
    [datePickerSheeet showInView:self.view];
    //这里使用全局的键盘的view，可以避免在有tabBar或者toolBar的页面，把actionSheet下方挡住。
    
}

- (void)datePickerCancelClick:(UIButton *)button{

}

- (void)datePickerDoneClick:(UIButton *)button{

}



- (void)sendSMS:(NSString *)bodyOfMessage recipientList:(NSArray *)recipientslist
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {

        
        controller.body = bodyOfMessage;
        controller.recipients = recipientslist;
        controller.messageComposeDelegate = self;
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
