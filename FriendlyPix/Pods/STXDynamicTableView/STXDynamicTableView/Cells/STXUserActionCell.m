//
//  STXUserActionCell.m
//  STXDynamicTableViewExample
//
//  Created by Jesse Armand on 10/4/14.
//  Copyright (c) 2014 2359 Media Pte Ltd. All rights reserved.
//

#import "STXUserActionCell.h"

@interface STXUserActionCell ()

@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIView *buttonDividerLeft;
@property (weak, nonatomic) IBOutlet UIView *buttonDividerRight;

@end

@implementation STXUserActionCell

- (void)awakeFromNib
{
    self.buttonDividerLeft.backgroundColor = [UIColor grayColor];
    self.buttonDividerRight.backgroundColor = [UIColor grayColor];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if ([self.postItem liked]) {
        [self setButton:self.likeButton toLoved:YES];
    } else {
        [self setButton:self.likeButton toLoved:NO];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setPostItem:(id<STXPostItem>)postItem
{
    _postItem = postItem;
    
    [self.likeButton setImage:[UIImage imageNamed:(postItem.liked ? @"ic_favorite" : @"ic_favorite_border")]
                     forState:UIControlStateNormal];
}

#pragma mark - Action

- (void)setButton:(UIButton *)button toLoved:(BOOL)loved
{
    [self.likeButton setImage:[UIImage imageNamed:(loved ? @"ic_favorite" : @"ic_favorite_border")]
                     forState:UIControlStateNormal];
}

- (IBAction)like:(id)sender
{
    // Need to return here if it's disabled, or the buttons may do a delayed
    // update.
    if (![sender isUserInteractionEnabled]) {
        return;
    }
    
    if (![self.postItem liked]) {
        [self setButton:sender toLoved:YES];
        
        if ([self.delegate respondsToSelector:@selector(userDidLike:)]) {
            [self.delegate userDidLike:self];
        }
    } else {
        [self setButton:sender toLoved:NO];
        
        if ([self.delegate respondsToSelector:@selector(userDidUnlike:)]) {
            [self.delegate userDidUnlike:self];
        }
    }
}

- (IBAction)comment:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(userWillComment:)]) {
        [self.delegate userWillComment:self];
    }
}

- (IBAction)share:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(userWillShare:)]) {
        [self.delegate userWillShare:self];
    }
}

@end
