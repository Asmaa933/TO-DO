//
//  LocalStore.h
//  TO DO
//
//  Created by Asmaa Tarek on 12/14/19.
//  Copyright © 2019 Asmaa Tarek. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocalStore : NSObject
-(void) saveToDefault :(NSMutableArray*) arr;
-(NSMutableArray*) getFromDefault;
@end

NS_ASSUME_NONNULL_END
