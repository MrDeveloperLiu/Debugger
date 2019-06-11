//
//  DemoTests.m
//  DemoTests
//
//  Created by 刘杨 on 2019/1/5.
//  Copyright © 2019年 liu. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SimpleXMLParaser.h"

@interface DemoTests : XCTestCase

@end

@implementation DemoTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"xml"];
    NSURL *url = [NSURL fileURLWithPath:path];
    SimpleXMLParaser *p = [[SimpleXMLParaser alloc] initWithUrl:url];
    [p setCompletionBlock:^(SimpleXMLParaser *praser, NSError *error) {
        NSLog(@"%@", praser.root.rootObject);
    }];
    [p begin];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
