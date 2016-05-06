//
//  IPIShareIktViewController.m
//  ZJSDemoProjection
//
//  Created by ipi on 16/5/3.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import "IPIShareIktViewController.h"
#import <Masonry.h>
#import <QuickLook/QuickLook.h>

@interface IPIShareIktViewController ()<UIDocumentInteractionControllerDelegate>
@property(nonatomic,retain)UIDocumentInteractionController *docController;

@end

@implementation IPIShareIktViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self configView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configView{

    UIButton *button = [[UIButton alloc] init];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
}

- (void)buttonAction{

    NSString *path = [[NSBundle mainBundle] pathForResource:@"file" ofType:@"txt"];
    [self showMenuWithPath:path];
    
}

- (void)showMenuWithPath:(NSString *)path{
    
    _docController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL  fileURLWithPath:path]];//为该对象初始化一个加载路径
                  
    _docController.delegate =self;//设置代理

    //直接显示预览
    // [_docController presentPreviewAnimated:YES];

    CGRect navRect =self.navigationController.navigationBar.frame;
    navRect.size =CGSizeMake(1500.0f,40.0f);

    //显示包含预览的菜单项
    
    [_docController presentOptionsMenuFromRect:navRect inView:self.view animated:YES];

    //显示不包含预览菜单项
    //[docController presentOpenInMenuFromRect:navRect inView:self.view animated:YES];
}

//4、代理方法
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}
                      
- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller
{
    return self.view;
}
                      
- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller
{
    return  self.view.frame;
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
