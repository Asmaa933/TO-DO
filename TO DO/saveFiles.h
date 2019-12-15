//
//  saveFiles.h
//  TO DO
//
//  Created by Asmaa Tarek on 12/14/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface saveFiles : NSObject
-(void)saveData :(NSMutableArray *)dataArray;
-(NSMutableArray *)loadData;
@end

NS_ASSUME_NONNULL_END
