//
//  XXAppDelegate.h
//  HealthNaming
//
//  Created by Broche Xu on 8/26/13.
//  Copyright (c) 2013 xxworkshop. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface XXAppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource, NSTableViewDelegate, NSTextFieldDelegate>

@property (assign) IBOutlet NSWindow *window;

@end
