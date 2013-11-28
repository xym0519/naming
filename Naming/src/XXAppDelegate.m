//
//  XXAppDelegate.m
//  HealthNaming
//
//  Created by Broche Xu on 8/26/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#import "XXAppDelegate.h"
#import "XXDataManager.h"

@interface XXAppDelegate ()
@property (weak) IBOutlet NSTableView *table;
@property (weak) IBOutlet NSTextField *abbrView;
@property (weak) IBOutlet NSTextField *fullView;
@property (weak) IBOutlet NSTextField *typeView;
@property (weak) IBOutlet NSButton *btnAdd;
@property (weak) IBOutlet NSButton *btnDelete;
@property (weak) IBOutlet NSSearchField *searchView;
@property (unsafe_unretained) IBOutlet NSTextView *resultView;


@end

@implementation XXAppDelegate {
    NSMutableArray *dataList;
    NSMutableArray *searchList;
    XXDataManager *dataManager;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    dataManager = [[XXDataManager alloc] init];
    
    dataList = [dataManager getNames];
    [self.table setDelegate:self];
    [self.table setDataSource:self];
    [self.searchView setDelegate:self];
    
    [self.table reloadData];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
    return YES;
}

#pragma mark -
#pragma mark TableView
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    NSMutableDictionary *dataItem = [dataList objectAtIndex:row];
    return [dataItem objectForKey:tableColumn.identifier];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return dataList.count;
}

#pragma mark Button
- (IBAction)add:(id)sender {
    [dataManager insertName:self.abbrView.stringValue withFull:self.fullView.stringValue withType:self.typeView.stringValue];
    dataList = [dataManager getNames];
    [self.table reloadData];
    [self.abbrView becomeFirstResponder];
}

- (IBAction)delete:(id)sender {
    if(self.table.selectedRow >= 0) {
        [dataManager deleteName:[[dataList objectAtIndex:self.table.selectedRow] objectForKey:@"id"]];
        dataList = [dataManager getNames];
        [self.table reloadData];
    }
}

- (IBAction)refresh:(id)sender {
    dataList = [dataManager getNames];
    [self.table reloadData];
}

#pragma mark TextField
- (void)controlTextDidChange:(NSNotification *)obj {
    if (searchList) {
        [searchList removeAllObjects];
    } else {
        searchList = [NSMutableArray array];
    }
    
    if (obj.object == self.searchView) {
        NSString *filter = self.searchView.stringValue;
        NSArray *arr = [self splitString:filter];
        NSMutableArray *result = [NSMutableArray array];
        for (NSString *item in arr) {
            NSMutableArray *tarr = [dataManager searchNames:item];
            [result addObject:tarr];
        }
        
        NSMutableArray *arr1 = [NSMutableArray array];
        NSMutableArray *arr2 = [NSMutableArray array];
        [arr2 addObject:@""];
        for (NSMutableArray *item in result) {
            arr1 = arr2;
            arr2 = [NSMutableArray array];
            for (NSMutableDictionary *str2 in item) {
                for (NSString *str1 in arr1) {
                    [arr2 addObject:[NSString stringWithFormat:@"%@%@",str1,[str2 objectForKey:@"full"]]];
                }
            }
        }
        
        NSMutableString *str = [NSMutableString string];
        for (NSString *tstr in arr2) {
            [str appendFormat:@"%@\n",tstr];
        }
        
        [self.resultView setString:str];
    }
}

#pragma mark Function
- (NSMutableArray *)splitString:(NSString *)str {
    NSMutableArray *arr = [NSMutableArray array];
    NSString *tstr = [str copy];
    while (tstr.length > 0) {
        if (tstr.length > 1) {
            [arr addObject:[tstr substringToIndex:2]];
            tstr = [tstr substringFromIndex:2];
        } else {
            [arr addObject:tstr];
            tstr = @"";
        }
    }
    return arr;
}
@end
