//
//  NSDate+DateExt.m
//  TO DO
//
//  Created by Asmaa Tarek on 12/13/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import "NSDate+DateExt.h"



@implementation NSDate (DateExt)
-(NSString*) changeToString
{
    NSDateFormatter* dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:self];
    return dateString;
}
@end
