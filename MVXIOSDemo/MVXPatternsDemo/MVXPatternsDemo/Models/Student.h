//
//  Student.h
//  MVXPatternsDemo
//
//  Created by Vicent on 2022/4/4.
//  学生Model

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject

@property (nonatomic, strong) NSString *name; //姓名
@property (nonatomic, assign) NSInteger age;  //年龄


@end

NS_ASSUME_NONNULL_END
