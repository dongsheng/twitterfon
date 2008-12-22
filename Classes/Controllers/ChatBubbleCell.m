//
//  ChatBubbleCell.m
//  TwitterFon
//
//  Created by kaz on 12/17/08.
//  Copyright 2008 naan studio. All rights reserved.
//

#import "ChatBubbleCell.h"
#import "DirectMessage.h"
#import "ChatBubbleView.h"
#import "TwitterFonAppDelegate.h"

@implementation ChatBubbleCell

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
	[super initWithFrame:frame reuseIdentifier:reuseIdentifier];
    
    cellView = [[[ChatBubbleView alloc] initWithFrame:CGRectZero] autorelease];
    [self.contentView addSubview:cellView];

    self.target = self;
    self.accessoryAction = @selector(didTouchLinkButton:);
    
	return self;
}

- (void)updateImage:(UIImage*)image
{
    // Perhaps, you need re-implement on deliver class
    cellView.image = image;
    [cellView setNeedsDisplay];
}

- (void)setMessage:(DirectMessage*)aMessage isOwn:(BOOL)isOwn
{
    message = aMessage;
    self.accessoryType = aMessage.accessoryType;
    if (self.accessoryType == UITableViewCellAccessoryDisclosureIndicator || isOwn) {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if (message.cellType == TWEET_CELL_TYPE_TIMESTAMP) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else {
//        self.selectionStyle = UITableViewCellSelectionStyleBlue;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    [cellView setMessage:aMessage type:isOwn];
    // Ignore timestamp cell
    if (aMessage.cellType == TWEET_CELL_TYPE_NORMAL) {    
        cellView.image = [self getProfileImage:aMessage.senderProfileImageUrl isLarge:false];
    }
}

- (void)didTouchLinkButton:(id)sender
{
    TwitterFonAppDelegate *appDelegate = (TwitterFonAppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate openLinksViewController:message.text];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    cellView.frame = self.bounds;
    self.backgroundColor = [UIColor clearColor];
}

- (void)dealloc {
    [super dealloc];
}

@end
