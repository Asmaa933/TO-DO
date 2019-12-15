//
//  saveFiles.m
//  TO DO
//
//  Created by Asmaa Tarek on 12/14/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import "saveFiles.h"

@implementation saveFiles
-(void)saveData :(NSMutableArray *)dataArray
{
    NSFileManager *filemgr;
    NSString *docsDir;
    NSArray *dirPaths;
    
    filemgr = [NSFileManager defaultManager];
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the data file
    NSString *dataFilePath = [[NSString alloc] initWithString: [docsDir
                                                                stringByAppendingPathComponent: @"data.archive"]];
    
    [NSKeyedArchiver
     archiveRootObject:dataArray toFile:dataFilePath];
}


-(NSMutableArray *)loadData
{
    NSFileManager *filemgr;
    NSString *docsDir;
    NSArray *dirPaths;
    
    filemgr = [NSFileManager defaultManager];
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the data file
    NSString *dataFilePath = [[NSString alloc] initWithString: [docsDir
                                                                stringByAppendingPathComponent: @"data.archive"]];
    
    // Check if the file already exists
    if ([filemgr fileExistsAtPath: dataFilePath])
    {
        NSMutableArray *dataArray;
        
        dataArray = [NSKeyedUnarchiver unarchiveObjectWithFile: dataFilePath];
        
        return dataArray;
    }
    return NULL;
}
@end
