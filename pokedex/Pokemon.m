//
//  Pokemon.m
//  pokedex
//
//  Created by Drew Sullivan on 8/30/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pokemon.h"

@implementation Pokemon

- (instancetype)initWithNameAndCaptureDifficulty:(NSString *)name and:(int)captureDifficulty {
    self = [super init];
    if (self) {
        self.name = name;
        self.captureDifficulty = captureDifficulty;
        self.value = arc4random_uniform(3) + 1;
    }
    return self;
}

@end
