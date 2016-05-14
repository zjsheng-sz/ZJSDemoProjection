//
//  IPICollectionViewController.m
//  ZJSDemoProjection
//
//  Created by ipi on 16/5/14.
//  Copyright © 2016年 zjs. All rights reserved.
//

#import "IPICollectionViewController.h"

@interface IPICollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic)UICollectionView * IPIcollectionView;/**< collectionView */
@end

@implementation IPICollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)creatCollectionView
{
//    selectedIdx = [[NSMutableDictionary alloc] init];
    
    CGFloat IPHONE_WIDTH = [UIScreen mainScreen].bounds.size.width;
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//滚动方向
    flowLayout.minimumLineSpacing = 8;//行间距(最小值)
    flowLayout.minimumInteritemSpacing = 8;//item间距(最小值)
    flowLayout.itemSize = CGSizeMake((IPHONE_WIDTH - 40)/4, (IPHONE_WIDTH - 40)/4);//item的大小
    flowLayout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);//设置section的边距
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    _IPIcollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20+44+44, self.view.bounds.size.width, height-20-44-44-46) collectionViewLayout:flowLayout];
    _IPIcollectionView.delegate =self;
    _IPIcollectionView.dataSource =self;
    _IPIcollectionView.allowsMultipleSelection = YES;//允许多选
    _IPIcollectionView.backgroundColor = [UIColor whiteColor];
    //1 注册复用cell(cell的类型和标识符)(可以注册多个复用cell, 一定要保证重用标示符是不一样的)注册到了collectionView的复用池里
//    [_IPIcollectionView registerClass:[fileTransferCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    
    [self.view addSubview:_IPIcollectionView];
    self.IPIcollectionView.allowsMultipleSelection = YES;
    _IPIcollectionView.hidden = YES;
    
    
}

/*
#pragma mark ================UICollectionView代理===================


//默认section个数为1
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//设置cell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoUrlStrArr.count;
}
//每个cell显示什么
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CollectionViewCell";
    
    fileTransferCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    fileTransferTableViewCellModel * model = self.photoUrlStrArr[indexPath.item];
    [cell refrashData:model];
    
    if (![cell viewWithTag:100])
    {
        //标记的自定义View
        fileTransferCustomSelectedView * selected = [[fileTransferCustomSelectedView alloc]initWithFrame:cell.bounds];
        selected.tag = selectedTag;
        selected.alpha = cellNormal;
        
        [cell.contentView addSubview:selected];
    }
    
    [[cell viewWithTag:selectedTag] setAlpha:cellHidden];
    
    BOOL cellSelected = [selectedIdx objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.item]];
    [self setCellSelection:cell selected:cellSelected];
    
    return cell;
}

//选择了某个cell
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //    [collectionView deselectItemAtIndexPath:indexPath animated:YES]
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    
    if (_indexPath_photo.count >= 5) {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        [self showWeakHint:@"图片"];
    }
    else
    {
        [self setCellSelection:cell selected:YES];
        [selectedIdx setValue:@"1" forKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
        
        [_indexPath_photo addObject:indexPath];
        //        NSLog(@"选择------%@",_indexPath_photo);
        
        [self setButtonEnabledToYESAndUpdataButtonTitle:[NSString stringWithFormat:@"%lu",(unsigned long)_indexPath_photo.count]];
    }
    
    
}
//取消选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    [self setCellSelection:cell selected:NO];
    [selectedIdx removeObjectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.row]];
    
    [_indexPath_photo removeObject:indexPath];
    cell.selected = NO;
    //    NSLog(@"取消------%@",_indexPath_photo);
    
    [self setButtonEnabledToYESAndUpdataButtonTitle:[NSString stringWithFormat:@"%lu",(unsigned long)_indexPath_photo.count]];
}

- (void) setCellSelection:(UICollectionViewCell *)cell selected:(BOOL)selected
{
    [cell viewWithTag:selectedTag].alpha = selected ? cellNormal : cellHidden;
}


//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
*/


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
