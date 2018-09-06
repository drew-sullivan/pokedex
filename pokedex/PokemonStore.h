//
//  PokemonStore.h
//  pokedex
//
//  Created by Drew Sullivan on 9/4/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pokemon.h"

@interface PokemonStore : NSObject { }

+ (Pokemon *)generateRandomPokemon;

@end
