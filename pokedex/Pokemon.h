//
//  Pokemon.h
//  pokedex
//
//  Created by Drew Sullivan on 8/30/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

@interface Pokemon : NSObject

@property (nonatomic, strong) NSString *name;
@property (assign) int captureDifficulty;

- (id)initWithNameAndCaptureDifficulty:(NSString *)name and:(int)captureDifficulty;

@end
