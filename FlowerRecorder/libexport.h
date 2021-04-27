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

@interface DynamicCast : NSObject
+ (int)exec: (int)argc withargv: (char**)argv;
+ (void)test;
@end

#endif /* libexport_h */
