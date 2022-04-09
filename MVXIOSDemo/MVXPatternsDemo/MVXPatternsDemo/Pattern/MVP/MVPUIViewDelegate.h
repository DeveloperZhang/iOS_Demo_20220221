//
//  MVPUIViewDelegate.h
//  MVXPatternsDemo
//
//  Created by Vicent on 2022/4/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MVPUIViewDelegate <NSObject>

- (void)configWithData:(NSString *)name age:(NSInteger)age;

@end

NS_ASSUME_NONNULL_END
