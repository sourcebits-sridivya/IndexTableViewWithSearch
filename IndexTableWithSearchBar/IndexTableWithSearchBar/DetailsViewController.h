//
//  DetailsViewController.h
//  IndexTableWithSearchBar
//
//  Created by sri Divya on 12/10/16.
//  Copyright © 2016 MyCompanyName. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleFood.h"

@interface DetailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;

@property (strong, nonatomic) NSString* foodTitle;
@end
