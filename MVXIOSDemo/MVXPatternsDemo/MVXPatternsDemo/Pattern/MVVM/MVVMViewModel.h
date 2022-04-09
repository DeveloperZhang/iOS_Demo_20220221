//
//  MVVMViewModel.h
//  MVXPatternsDemo
//
//  Created by Vicent on 2022/4/5.
//

#import <Foundation/Foundation.h>
#import "MVVMViewModelDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface MVVMViewModel : NSObject<MVVMViewModelDelegate>

@property (nonatomic, strong) NSString *nameLabelStr;
@property (nonatomic, strong) NSString *ageLabelStr;


@end

NS_ASSUME_NONNULL_END
