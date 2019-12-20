//
//  LocalStore.m
//  TO DO
//
//  Created by Asmaa Tarek on 12/14/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import "LocalStore.h"
#import "TasksData.h"


@implementation LocalStore
{
    NSArray* savedArr;
    NSMutableArray* defArray;
    NSUserDefaults* def;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        def = [NSUserDefaults standardUserDefaults];
    }
    
    return self;
}

-(void) saveToDefault : (NSMutableArray*) arr
{
    
    savedArr = [[NSArray alloc] initWithArray:arr];
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:savedArr];
    [def setObject:data forKey:@"MyData"];
    [def synchronize];
    
}
-(NSArray*) getFromDefault
{
    NSData *data = [def objectForKey:@"MyData"];
    NSMutableArray *retrievedArray = [[NSKeyedUnarchiver unarchiveObjectWithData:data] mutableCopy];
    return retrievedArray;
}

@end
