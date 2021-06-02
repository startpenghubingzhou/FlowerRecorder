//
//  libexport.mm
//  DynamicCast
//
//  Created by penghubingzhou on 2021/4/27.
//  Copyright © 2021 penghubingzhou. All rights reserved.
//

#import <opencv2/stitching/detail/exposure_compensate.hpp>
#import <opencv2/stitching/detail/seam_finders.hpp>
#import <opencv2/stitching/detail/blenders.hpp>

#import "libexport.h"
#import "../Dependencies/DynamicCast/DynamicCast/DynamicCast.h"

@implementation DynamicCast

+ (int)exec: (int)argc withargv: (char**)argv {
    return cast(argc, argv);
}

+ (int)DynamicCast_init: (const char*)dbpath {
    return DynamicCast_init(dbpath);
}

+ (void)DynamicCast_deinit {
    return DynamicCast_deinit();
}

+ (fdata*)getbasedata: (const char*)name kvalue: (double)k bvalue: (double)b tvalue: (double)t {
    return getbasedata(name, k, b, t);
}

+ (sqlfscore*)getscoredata: (const char*)name withflowerdata: (fdata*)flower_data sqlite_number: (int)sqlnum {
    return getscoredata(name, flower_data, sqlnum);
}

+ (void)release_score_data: (sqlfscore*)data {
    return release_score_data(data);
}

+ (int)readdata: (int)num withscoredata: (sqlfscore*)data {
    return readdata(num, data);
}

+ (int)writedata: (sqlfscore*)data {
    return writedata(data);
}

+ (int)deletedata: (int)num {
    return deletedata(num);
}

+ (int)getsize {
    return getsize();
}
@end
