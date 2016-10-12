//
//  ArticleFood.h
//  IndexTableWithSearchBar
//
//  Created by sri Divya on 12/10/16.
//  Copyright © 2016 MyCompanyName. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleFood : NSObject

@property (nonatomic, retain) NSString* name;

@property (nonatomic, retain) NSString* description;

-(id) initWithName:(NSString*) theName andDescription:(NSString*)theDescription;

@end
