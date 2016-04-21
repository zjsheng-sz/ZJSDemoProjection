//
//  IPIFileViewController.m
//  ZJSDemoProjection
//
//  Created by ipi on 16/4/21.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import "IPIFileViewController.h"
#import <Masonry.h>

@interface IPIFileViewController ()

@property(nonatomic, strong)NSFileManager *fileManager;

@end

@implementation IPIFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _fileManager = [NSFileManager defaultManager];
 
    //获取路径
    NSString *documentpath = [self dirDoc];
    NSString *directionPath = [documentpath stringByAppendingPathComponent:@"directionPath"];
    NSString *filePath = [directionPath stringByAppendingPathComponent:@"file.txt"];
    
    //创建文件夹
    BOOL result = [self createDirWithPath:directionPath];
    if (result) {
        NSLog(@"文件夹创建成功");
    }else{
        NSLog(@"文件夹创建失败");
    }
    
    //创建文件
    result = [self createFileWithFilePath:filePath];
    
    if (result) {
        NSLog(@"文件创建成功");
    }else{
        NSLog(@"文件创建失败");
    }
    
    //写入文件
    NSString *content = @"测试写入内容！";
    [self writeFileWithFilePath:filePath Content:content];
    
    //读取文件
    NSString *readContent = [self readWithFilePath:filePath];
    NSLog(@"读取到文件内容:%@",readContent);
    
    //文件属性
    NSDictionary *fileAttributes = [_fileManager attributesOfItemAtPath:filePath error:nil];
    NSLog(@"fileAttributes = %@",fileAttributes);
    
    //document目录下的所有项目
    NSArray *array = [_fileManager subpathsAtPath:[self dirDoc]];
    NSLog(@"items in document: %@",array);
    
    //删除文件
    result = [self deleteFileWithFilePath:filePath];
    
    if (result) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
    
    [self configViews];
    
}

- (void)configView{

    //3列4行的item,item大小相等,item之间的间隔为10,与边缘的间距为20;
    
    CGFloat gap = 10.0;
    CGFloat margin = 20.0;
    NSInteger xNum = 3;
    NSInteger yNum = 4;
    
    const CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    const CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    // 105*3+60 = 375;
    // 199*3+70 = 667
    CGFloat width = (self.view.bounds.size.width - 2 * margin - (xNum-1)*gap)/3.0;
    CGFloat height = (self.view.bounds.size.height -64 - 2 * margin - (yNum-1)*gap)/4.0;
    
    for (int i = 0; i < yNum; i ++) {//4行
        for (int j = 0; j < xNum; j ++) {//3列
            //
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor redColor];
            [self.view addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
               
                CGFloat left = margin + j * width + j * gap;
                CGFloat top = margin + i * height + i * gap;
                
                make.width.equalTo([NSNumber numberWithFloat:width]);
                make.height.equalTo([NSNumber numberWithFloat:height]);
                make.left.equalTo([NSNumber numberWithFloat:left]);
                make.top.equalTo([NSNumber numberWithFloat:top]);
                
            }];
            
        }
    }
    
}


- (void)configViews{
    
    //添加按钮
    UIButton *addFileButton = [[UIButton alloc] init];
    [self.view addSubview:addFileButton];
    addFileButton.backgroundColor = [UIColor redColor];
    [addFileButton addTarget:self action:@selector(addFileWithPath:) forControlEvents:UIControlEventTouchUpInside];
    [addFileButton setTitle:@"add" forState:UIControlStateNormal];
    
    //读取按钮
    UIButton *readFileButton = [[UIButton alloc] init];
    [self.view addSubview:readFileButton];
    readFileButton.backgroundColor = [UIColor redColor];
    [readFileButton addTarget:self action:@selector(addFileWithPath:) forControlEvents:UIControlEventTouchUpInside];
    [readFileButton setTitle:@"read" forState:UIControlStateNormal];

    //删除按钮
    UIButton *deleteFileButton = [[UIButton alloc] init];
    [self.view addSubview:deleteFileButton];
    deleteFileButton.backgroundColor = [UIColor redColor];
    [deleteFileButton addTarget:self action:@selector(addFileWithPath:) forControlEvents:UIControlEventTouchUpInside];
    [deleteFileButton setTitle:@"delete" forState:UIControlStateNormal];

    
    [readFileButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.view);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
        
    }];
    
    [deleteFileButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(readFileButton).offset(100);
        make.centerX.equalTo(@[readFileButton,addFileButton]);
        make.size.equalTo(@[readFileButton,addFileButton]);
        
    }];
    
    [addFileButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(readFileButton).offset(-100);

    }];
    
    
    
}

- (void)addFileWithPath:(UIButton *)button{
    NSLog(@"addAction");

}

- (void)addDirectionWithPath:(NSString *)directionPath{

}

- (void)deleteItemWithPath:(NSString *)path{


}

- (void)readItemAttributeWithPath:(NSString *)path{


}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
  
}

//获取应用沙盒根路径：
- (NSString *)dirHome{
    
    NSString *dirHome=NSHomeDirectory();
    NSLog(@"app_home: %@",dirHome);
    return dirHome;
}
//获取Documents目录
- (NSString *)dirDoc{
    //[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"app_home_doc: %@",documentsDirectory);
    return documentsDirectory;
}
//获取Library目录
- (NSString *)dirLib{
    //[NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryDirectory = [paths objectAtIndex:0];
    NSLog(@"app_home_lib: %@",libraryDirectory);
    return libraryDirectory;
}
//获取Cache目录
- (NSString *)dirCache{
    NSArray *cacPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cacPath objectAtIndex:0];
    NSLog(@"app_home_lib_cache: %@",cachePath);
    return cachePath;
}
//获取Tmp目录
-(NSString *)dirTmp{
    //[NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
    NSString *tmpDirectory = NSTemporaryDirectory();
    NSLog(@"app_home_tmp: %@",tmpDirectory);
    return tmpDirectory;
}

//创建文件夹
-(BOOL)createDirWithPath:(NSString *)dirPath{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 创建目录
    BOOL result = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    if (result) {
        NSLog(@"文件夹创建成功");
        return YES;
    }else{
        NSLog(@"文件夹创建失败");
        return NO;
    }
}

//创建文件
-(BOOL)createFileWithFilePath:(NSString *)filePath{
    
    BOOL res=[_fileManager createFileAtPath:filePath contents:nil attributes:nil];
    if (res) {
        NSLog(@"文件创建成功: %@" ,filePath);
        
        return YES;
    }else{
        
        NSLog(@"文件创建失败");
        return NO;
    }
}

//写入文件
-(BOOL)writeFileWithFilePath:(NSString *)filePath Content:(NSString *)content{
    
    //字典，数组，字符串一样
    BOOL res=[content writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if (res) {
        NSLog(@"文件写入成功");
        return YES;
    }else{
        NSLog(@"文件写入失败");
        return NO;
    }
    
//    //字典
//    NSString *document = [self dirDoc];
//    NSString *dicPath = [document stringByAppendingPathComponent:@"text.info"];
//    NSDictionary *dic = @{@"key1": @"value1",@"key2":@"value2",@"key3":@"value3"};
//    res = [dic writeToFile:dicPath atomically:YES];
//    if (res) {
//        NSLog(@"字典写入成功");
//    }else{
//        NSLog(@"字典写入失败");
//    }
//    
//    //数组
//    NSString *arrPath = [document stringByAppendingString:@"arr.info"];
//    NSArray *arr = @[@"arr1",@"arr2",@"arr3"];
//    if ([arr writeToFile:arrPath atomically:YES]) {
//        NSLog(@"数组写入成功");
//    }else{
//        NSLog(@"数组写入失败");
//    }
}

//读文件
-(NSString *)readWithFilePath:(NSString *)filePath {
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSLog(@"文件读取成功: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    //字符串
    NSString *content=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"content = %@",content);
    return content;
    
//    //字典
//    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
//    NSLog(@"dic = %@",dic);
//    //数组
//    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
//    NSLog(@"arr = %@",arr);
    
    
    
}

//删除文件
-(BOOL)deleteFileWithFilePath:(NSString *)filePath{
    
    BOOL res=[_fileManager removeItemAtPath:filePath error:nil];
    if (res) {
        return YES;
    }else{
        return NO;
    }
    
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
