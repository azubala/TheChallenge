//
//  CHLUsersFavoritesViewController.m
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/28/12.
//
//

#import "CHLUsersFavoritesViewController.h"
#import "CHLTrackObject.h"
#import "CHLTrackCell.h"
#import "CHLImageProvider.h"

@implementation CHLUsersFavoritesViewController
{
    NSDateFormatter *dateFormatter_;
}

//---------------------------------------------------------------------------------------------
#pragma mark - object life cycle

- (id)initWithResourceURL:(NSURL *)resourceURL itemsParser:(id<CHLSoundCloudItemParserProtocol>)parser
{
    self = [super initWithResourceURL:resourceURL itemsParser:parser];
    if (self) {
        dateFormatter_ = [[NSDateFormatter alloc] init];
        [dateFormatter_ setDateFormat:@"dd/MM/yyyy (HH:mm)"];
    }
    return self;
}

//---------------------------------------------------------------------------------------------
#pragma mark - UIViewController specific

- (NSString*) title
{
    return @"Tracks you like";
}

//---------------------------------------------------------------------------------------------
#pragma mark - UITableViewDataSource

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* tableCellId = @"tableCellId";
    CHLTrackCell *cell = [tableView dequeueReusableCellWithIdentifier:tableCellId];
    if (!cell) {
        cell = [[CHLTrackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellId];
    }
    CHLTrackObject *track = [_tableItems objectAtIndex:indexPath.row];
    cell.dateLabel.text = [dateFormatter_ stringFromDate:track.creationDate];
    //cell.dateLabel.text = [track.creationDate description];
    cell.titleLabel.text = track.title;
    cell.artistLabel.text = track.author.username;
    cell.currentModelObject = track;
    
    [[CHLImageProvider defaultProvider] imageWithURL:track.waveFormURL scale:[self waveFormScaleFactor] completionBlock:^(BOOL success, UIImage *image) {
        if (success && cell.currentModelObject == track) {
            cell.waveImageView.image = image;
            cell.waveImageView.backgroundColor = [UIColor orangeColor];
        }
    }];
    
    return cell;
}

- (CGFloat) waveFormScaleFactor
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad ? 0.5f : 0.25f;
}

//---------------------------------------------------------------------------------------------
#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CHLTrackObject *track = [_tableItems objectAtIndex:indexPath.row];
    NSURL *urlToPlay = [NSURL URLWithString:[NSString  stringWithFormat:@"soundcloud:tracks:%@",track.objectId]];
    [[UIApplication sharedApplication] openURL:urlToPlay];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets insets = CHLTrackCellInsets;
    UIOffset offset = CHLTrackCellOffset;
    CGSize availableSize = CGSizeMake(tableView.bounds.size.width - insets.left - insets.right, CGFLOAT_MAX);
    CGFloat cellHeight = insets.top + insets.bottom;
    
    CHLTrackObject *track = [_tableItems objectAtIndex:indexPath.row];
    
    CGSize textSize = [[track.creationDate description] sizeWithFont:[UIFont systemFontOfSize:12.0f]
                                                   constrainedToSize:availableSize
                                                       lineBreakMode:UILineBreakModeWordWrap];
    cellHeight += textSize.height + offset.vertical;
    
    textSize = [track.title sizeWithFont:[UIFont boldSystemFontOfSize:20.0f]
                       constrainedToSize:availableSize
                           lineBreakMode:UILineBreakModeWordWrap];
    cellHeight += textSize.height + offset.vertical;
    
    textSize = [track.author.username sizeWithFont:[UIFont boldSystemFontOfSize:14.0f]
                       constrainedToSize:availableSize
                           lineBreakMode:UILineBreakModeWordWrap];
    cellHeight += textSize.height + offset.vertical;

    
    CGSize waveFormSize = CGSizeMake(0, 50);
    cellHeight += waveFormSize.height;
    
    return cellHeight;
}

@end
