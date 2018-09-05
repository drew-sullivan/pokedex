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
#import "PokemonStore.h"

@implementation Person

- (id)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        self.name = name;
        self.numPokeballs = 3;
        self.pokedex = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)printName {
    NSLog(@"%@", self.name);
}

- (void)viewPokedex {
    NSLog(@"\n");
    if ([self.pokedex count] < 1) {
        NSLog(@"%@'s pokedex is empty!", self.name);
        return;
    }
    NSLog(@"%@'s pokedex:\n", self.name);
    for (int i = 0; i < [self.pokedex count]; i++) {
        int index = i + 1;
        Pokemon *pokemon = self.pokedex[i];
        NSString *name = pokemon.name;
        int tradeValue = pokemon.value;
        int captureDifficulty = pokemon.captureDifficulty;
        NSLog(@"[%i] %@ (trade value: %i, capture likelihood: %i%%)\n", index, name, tradeValue, captureDifficulty);
    }
}

- (void)addPokemon:(Pokemon *)pokemon {
    [self.pokedex addObject:pokemon];
    NSLog(@"%@ added to %@'s pokedex", pokemon.name, self.name);
}

- (void)releasePokemon:(NSString *)pokemonName {
    for (int i = 0; i < [self.pokedex count]; i++) {
        Pokemon *pokemon = self.pokedex[i];
        if ([[pokemonName lowercaseString] isEqualToString:[pokemon.name lowercaseString]]) {
            [self.pokedex removeObjectAtIndex:i];
            NSLog(@"%@ has been released", pokemonName);
            return;
        }
    }
}

- (void)changePokemonName:(NSString *)oldName changeTo:(NSString *)newName {
    for (Pokemon *pokemon in self.pokedex) {
        if ([[pokemon.name lowercaseString] isEqualToString:oldName]) {
            NSString *capitalizedNameString = [newName capitalizedString];
            pokemon.name = capitalizedNameString;
            NSLog(@"%@ has been changed to %@", oldName, capitalizedNameString);
            return;
        }
    }
}

- (void)attemptToCapture:(Pokemon *)pokemon {
    if (pokemon.captureDifficulty >= 80) {
        NSLog(@"%@ wanted to join you without you having to try! No pokeballs used!", pokemon.name);
        [self.pokedex addObject:pokemon];
    } else {
        self.numPokeballs -= 1;
        NSLog(@"You tossed a pokeball! (%i remaining)", self.numPokeballs);
        int difficulty = pokemon.captureDifficulty;
        int rand = arc4random_uniform(50);
        if (rand <= difficulty) {
            NSLog(@"You caught %@!", pokemon.name);
            [self.pokedex addObject:pokemon];
        } else {
            NSLog(@"%@ got away!", pokemon.name);
        }
    }
}

- (BOOL)doesOwnPokemon:(NSString *)name {
    for (Pokemon *pokemon in self.pokedex) {
        if ([[name lowercaseString] isEqualToString:[pokemon.name lowercaseString]]) {
            return TRUE;
        }
    }
    return false;
}

- (void)tradeInPokemon:(NSString *)pokemonName; {
    for (int i = 0; i < [self.pokedex count]; i++) {
        Pokemon *pokemon = self.pokedex[i];
        if ([[pokemonName lowercaseString] isEqualToString:[pokemon.name lowercaseString]]) {
            [self.pokedex removeObjectAtIndex:i];
            self.numPokeballs += pokemon.value;
            NSLog(@"%@ has been traded for %i pokeballs (%i pokeballs now).", pokemonName, pokemon.value, self.numPokeballs);
            return;
        }
    }
}

@end
