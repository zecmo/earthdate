//
//  TransientContainer.h
//
//  Created by zecmo on earth.
//

#import <Foundation/Foundation.h>

//////////////////////////////////////////
// A simple transient container that can retain
//  data in memory while the app is open
@interface TransientContainer : NSObject

+ (instancetype)sharedInstance;

- (id)getContentForKey:(NSString *)key;
- (void)setContentForKey:(NSString *)key data:(id)data;
- (void)saveToDisk;

@end