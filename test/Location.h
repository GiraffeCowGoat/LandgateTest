//
//  Location.h
//  test
//
//  Created by Jeremy Siao Him Fa on 10/11/2014.
//  Copyright (c) 2014 Ziomoxis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject

@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *photoFileName;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;

@end
