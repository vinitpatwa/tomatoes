//
//  Movie.h
//  tomatoes
//
//  Created by Vinit Patwa on 1/22/14.
//  Copyright (c) 2014 Vinit Patwa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

{

    @public
    NSString *profilePoster;
//    NSString *detailedPoster;
    NSString *title;
    NSString *synopsis;
//    NSString *cast;
    
}

-(id)initWithDictionary: (NSDictionary *)dict;

-(id)initWithTitle:(NSString *)movTitle synopsis:(NSString *)movSynopsis profilePoster:(NSString *)movProfilePoster;


@end
