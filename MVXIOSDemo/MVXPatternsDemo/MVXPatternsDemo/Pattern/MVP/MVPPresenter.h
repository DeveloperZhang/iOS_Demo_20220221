//
//  MVPPresenter.h
//  MVXPatternsDemo
//
//  Created by Vicent on 2022/4/4.
//  Presenter,持有

#import <Foundation/Foundation.h>
#import "MVPPresenterDelegate.h"
#import "Student.h"

NS_ASSUME_NONNULL_BEGIN

@interface MVPPresenter : NSObject<MVPPresenterDelegate>

@property (nonatomic, weak) id<MVPUIViewDelegate> viewDelegate;

@end

NS_ASSUME_NONNULL_END
