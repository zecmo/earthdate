//
//  TransientContainer.m
//
//  Created by zecmo on earth
//

#import "TransientContainer.h"

@implementation TransientContainer {
    NSMutableDictionary *content;
    NSUserDefaults *userDefaults;
}

+ (instancetype)sharedInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)getContentForKey:(NSString *)key
{
    if (!userDefaults) {
        userDefaults = [NSUserDefaults standardUserDefaults];
    }
    
    NSParameterAssert(key);
    
    // Has is been pulled from the userDefaults?
    id data = [content objectForKey:key];
    if (!data) {
        // Nope, get it from the userDefaults
        data = [userDefaults objectForKey:key];
        
        // Was the data in the userDefaults?
        if (data) {
            // Yep, then add it to the transientContainer
            [self setContentForKey:key data:data];
        }
    }
    
    // Return whatever we gots
    return data;
}

- (void)setContentForKey:(NSString *)key data:(id)data
{
    if (!userDefaults) {
        userDefaults = [NSUserDefaults standardUserDefaults];
    }
    
    NSParameterAssert(key);
    NSParameterAssert(data);
    
    if (!content) {
        content = [NSMutableDictionary.alloc init];
    }
    
    [userDefaults setObject:data forKey:key];
    [content setObject:data forKey:key];
}

- (void)saveToDisk {
    if (userDefaults) {
        [userDefaults synchronize];
    }
}

@end
