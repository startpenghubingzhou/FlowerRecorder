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

extern void myfunc();

@implementation DynamicCast
+ (int)exec: (int)argc withargv: (char**)argv{
    return cast(argc, argv);
}
+ (void)test{
    myfunc();
}
@end
