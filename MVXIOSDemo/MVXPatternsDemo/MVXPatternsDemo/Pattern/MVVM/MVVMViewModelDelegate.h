//
//  MVVMViewModelDelegate.h
//  MVXPatternsDemo
//
//  Created by Vicent on 2022/4/5.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

typedef void(^SuccessCallBack)(BOOL isSuccessed);

@protocol MVVMViewModelDelegate <NSObject>

- (instancetype)initWithObj:(NSObject *)obj;
- (void)fetchObj:(SuccessCallBack)successCallBack;

@end

NS_ASSUME_NONNULL_END
