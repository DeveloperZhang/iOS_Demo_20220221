//
//  MVPPresenterDelegate.h
//  MVXPatternsDemo
//
//  Created by Vicent on 2022/4/4.
//

#import <Foundation/Foundation.h>
#import "MVPUIViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SuccessCallBack)(BOOL isSuccessed);

@protocol MVPPresenterDelegate <NSObject>

- (instancetype)initWithViewDelegate:(id<MVPUIViewDelegate>)viewDelegate obj:(NSObject *)obj;
- (void)fetchObj:(SuccessCallBack)successCallBack;

@end

NS_ASSUME_NONNULL_END
