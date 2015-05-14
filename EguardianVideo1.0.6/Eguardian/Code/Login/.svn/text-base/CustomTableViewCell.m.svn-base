//
//  CustomTableViewCell.m
//  CampusManager
//
//  Created by Deathman on 13-5-1.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "CustomTableViewCell.h"


@implementation CustomTableViewCell

@synthesize contentLabel = contentLabel_;

- (void)dealloc {
    [contentLabel_ release];
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGRect frame = CGRectMake(0, 0, 320, CustomCellHeight);
        self.frame = frame;
        
        self.backgroundColor = CustomCellBgColor;
        
        self.accessoryType = UITableViewCellAccessoryNone;
        UIImageView *accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Arrow.png"]];
        accessoryView.center = CGPointMake(270, frame.size.height/2);
        [self addSubview:accessoryView];
        [accessoryView release];

        UIImageView *selectedBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logined_cell_selected.png"]];
        self.selectedBackgroundView = selectedBg;
        [selectedBg release];
//        static float separatorSpace = 30;
//        static float separatorHeight = 1;
        
//        UIView *separator = [[UIView alloc] initWithFrame:
//                        CGRectMake(separatorSpace, 
//                                   frame.size.height - separatorHeight,
//                                   frame.size.width - separatorSpace*2, separatorHeight)];
//        separator.backgroundColor = [UIColor colorWithRed:220/255.0
//                                                    green:220/255.0
//                                                     blue:220/255.0
//                                                    alpha:1];
//        [self addSubview:separator];
//        [separator release];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 260, frame.size.height)];
        label.font = [UIFont systemFontOfSize:19];
        label.textColor = [UIColor colorWithRed:70/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
        label.backgroundColor = [UIColor clearColor];
        
        self.contentLabel = label;
        [label release];
        [self addSubview:contentLabel_];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
