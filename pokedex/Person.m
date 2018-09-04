//
//  Person.m
//  pokedex
//
//  Created by Drew Sullivan on 8/28/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Pokemon.h"

@implementation Person

- (id)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.name = name;
        self.pokedex = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)printName {
    NSLog(@"%@", self.name);
}

- (void)viewPokedex {
    NSLog(@"%@'s pokedex:\n", self.name);
    for (int i = 0; i < [self.pokedex count]; i++) {
        NSLog(@"[%i] %@", i + 1, self.pokedex[i].name);
    }
}

- (void)addPokemon:(Pokemon *)pokemon {
    [self.pokedex addObject:pokemon];
    NSLog(@"%@ added to %@'s pokedex", pokemon.name, self.name);
}

- (void)releasePokemon:(NSString *)pokemonName {
    for (int i = 0; i < [self.pokedex count]; i++) {
        Pokemon *pokemon = self.pokedex[i];
        if ([pokemonName isEqualToString:pokemon.name]) {
            [self.pokedex removeObjectAtIndex:i];
            NSLog(@"%@ has been released", pokemonName);
            return;
        }
    }
}

- (void)changePokemonName:(NSString *)oldName changeTo:(NSString *)newName {
    for (Pokemon *pokemon in self.pokedex) {
        if ([pokemon.name isEqualToString:oldName]) {
            pokemon.name = newName;
            NSLog(@"%@ has been changed to %@", oldName, newName);
            return;
        }
    }
}

@end
