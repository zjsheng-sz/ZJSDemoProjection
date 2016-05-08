//
//  README.h
//  ZJSDemoProjection
//
//  Created by ipi on 16/5/6.
//  Copyright © 2016年 zjs. All rights reserved.
//

#ifndef README_h
#define README_h
#endif /* README_h */


/*
 文件传输使用到的知识点：
 1、socket
 2、C语言
 3、CoreData / FMDB /归档
 4、文件读写
 5、分层 和 MVC
 */
#pragma mark FMDB SQLITE4

SQLite 命令，表名，字段都不区分大小写

//基本语法

sqlite3 ZJSDatabase.db//打开或创建数据库
sqlite> .databases;
sqlite> .tables;
sqlite> .q
sqlite> .head on;
sqlite> .mode column;

//创建表格
sqlite> create table if not exists FileInfo
        (sourceID integer primary key autoincrement,fileName text, sendTime text);
sqlite> drop table user;

//增删改查
sqlite> insert into fileInfo (sourceID, fileName, sendTime)
        values(123456780,'IMG_002','2016-05-07 17:27:55.123');

sqlite> delete from FileInfo where sourceID = 123456780;

sqlite> update FileInfo set SourceID = 123, FileName = 'IMG_002' where sourceID = 123456789;

sqlite> select * from fileinfo;

//数据库升级


#pragma mark CoreData
















