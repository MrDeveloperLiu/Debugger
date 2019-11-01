//
//  EDJListViewCell.m
//  Demo
//
//  Created by 刘杨 on 2019/11/1.
//  Copyright © 2019 liu. All rights reserved.
//

#import "EDJListViewCell.h"

@implementation EDJListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)setModel:(EDJListObject *)model{
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
