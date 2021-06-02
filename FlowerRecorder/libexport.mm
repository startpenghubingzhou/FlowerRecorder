//
//  libexport.mm
//  DynamicCast
//
//  Created by penghubingzhou on 2021/4/27.
//  Copyright © 2021 penghubingzhou. All rights reserved.
//

/* BSD 3-Clause License
 
   Copyright (c) 2021, penghubingzhou
   All rights reserved.
 
   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are met:
 
   1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
 
   2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.
 
   3. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived from
   this software without specific prior written permission.
 
   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
   DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
   FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
   DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
   SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
   CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
   OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

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
