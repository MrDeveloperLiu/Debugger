//
//  EDJListHeaderFooterView.m
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJListHeaderFooterView.h"

@implementation EDJListHeaderFooterView

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    return self;
}

- (void)setModel:(EDJListHeaderFooterObject *)model{
    if (_model != model) {
        _model = model;
        [self refreshContent:model.content];
    }
}

- (void)refreshContent:(id)content{
    
    if ([content isKindOfClass:[NSDictionary class]]) {
        self.textLabel.text = content[@"title"];
    }    
}
@end
