//
//  libexport.h
//  DynamicCast
//
//  Created by penghubingzhou on 2021/4/27.
//  Copyright © 2021 penghubingzhou. All rights reserved.
//

#ifndef libexport_h
#define libexport_h

#import <Foundation/Foundation.h>
#import "../Dependencies/DynamicCast/DynamicCast/Basedefs.h"


@interface DynamicCast : NSObject
+ (int)exec: (int)argc withargv: (char**)argv;
+ (int)DynamicCast_init: (const char*)dbpath;
+ (void)DynamicCast_deinit;

// FreshFlower func export from DynamicCast
+ (fdata*)getbasedata: (const char*)name kvalue: (double)k bvalue: (double)b tvalue: (double)t;

// DriedFlower func export from DynamicCast
+ (sqlfscore*)getscoredata: (const char*)name withflowerdata: (fdata*)flower_data sqlite_number: (int)sqlnum;
+ (void)release_score_data: (sqlfscore*)data;

// SQLFriend func export from DynamicCast
+ (int)readdata: (int)num withscoredata: (sqlfscore*)data;
+ (int)writedata: (sqlfscore*)data;
+ (int)deletedata: (int)num;
+ (int)getsize;
@end

#endif /* libexport_h */
