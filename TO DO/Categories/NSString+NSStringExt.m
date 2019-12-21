//
//  NSString+NSStringExt.m
//  TO DO
//
//  Created by Asmaa Tarek on 12/13/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import "NSString+NSStringExt.h"




@implementation NSString (NSStringExt)
-(NSDate*) convertToDate
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:self];
    return date;
}
@end
