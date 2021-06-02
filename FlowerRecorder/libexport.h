//
//  libexport.h
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
