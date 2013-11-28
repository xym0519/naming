//
//  XXDataManager.m
//  HealthNaming
//
//  Created by Broche Xu on 8/26/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#import "XXDataManager.h"

@implementation XXDataManager
- (NSMutableArray *)getNames {
    return [self query:@"select * from names order by type,abbr"];
}

- (NSMutableArray *)searchNames:(NSString *)abbr {
    return [self query:[NSString stringWithFormat:@"select * from names where abbr='%@'",abbr]];
}

- (void)insertName:(NSString *)abbr withFull:(NSString *)full withType:(NSString *)type {
    XXLog(@"insert into names(abbr,full) values('%@','%@')",abbr,full);
    [self execute:[NSString stringWithFormat:@"insert into names(abbr,full,type) values('%@','%@','%@')",abbr,full,type]];
}

- (void)deleteName:(NSNumber *)nid {
    XXLog(@"delete from names where id=%@",nid);
    [self execute:[NSString stringWithFormat:@"delete from names where id=%@",nid]];
}
@end
