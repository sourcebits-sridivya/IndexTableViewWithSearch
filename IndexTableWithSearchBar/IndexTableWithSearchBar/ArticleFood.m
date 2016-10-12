//
//  ArticleFood.m
//  IndexTableWithSearchBar
//
//  Created by sri Divya on 12/10/16.
//  Copyright © 2016 MyCompanyName. All rights reserved.
//

#import "ArticleFood.h"

@implementation ArticleFood

@synthesize name;

@synthesize description;


-(id) initWithName:(NSString *)theName andDescription:(NSString *)theDescription
{
    self = [super init];
    if(self)
    {
        self.name = theName;
        self.description = theDescription;
    }
    return self;
}


@end
