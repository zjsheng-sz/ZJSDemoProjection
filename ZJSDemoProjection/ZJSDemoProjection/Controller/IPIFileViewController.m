//
//  IPIFileViewController.m
//  ZJSDemoProjection
//
//  Created by ipi on 16/4/21.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import "IPIFileViewController.h"

@interface IPIFileViewController ()

@property(nonatomic, strong)NSFileManager *fileManager;

@end

@implementation IPIFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _fileManager = [NSFileManager defaultManager];
 
    //获取路径
    NSString *documentpath = [self dirDoc];
    NSString *directionPath = [documentpath stringByAppendingPathComponent:@"directionPath"];
    NSString *filePath = [directionPath stringByAppendingPathComponent:@"file.txt"];
    
    //创建文件
    BOOL result = [self createFileWithFilePath:filePath];
    
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
        NSLog(@"文件删除成功");
        return YES;
    }else{
        NSLog(@"文件删除失败");
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
