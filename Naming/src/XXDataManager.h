//
//  XXDataManager.h
//  HealthNaming
//
//  Created by Broche Xu on 8/26/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#import "XXDataManagerBase.h"

@interface XXDataManager : XXDataManagerBase
- (NSMutableArray *)getNames;
- (NSMutableArray *)searchNames:(NSString *)abbr;

- (void)insertName:(NSString *)abbr withFull:(NSString *)full withType:(NSString *)type;
- (void)deleteName:(NSNumber *)nid;
@end
