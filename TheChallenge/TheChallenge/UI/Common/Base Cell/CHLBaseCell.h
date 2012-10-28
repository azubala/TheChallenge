//
//  CHLBaseCell.h
//  TheChallenge
//
//  Created by Aleksander Zubala on 10/28/12.
//
//

#import <UIKit/UIKit.h>
#import "CHLBaseModelObject.h"

@interface CHLBaseCell : UITableViewCell

@property (nonatomic, weak) CHLBaseModelObject *currentModelObject;

@end
