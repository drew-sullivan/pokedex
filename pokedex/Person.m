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
    NSLog(@"%@'s pokedex:\n", self.name);
    for (int i = 0; i < [self.pokedex count]; i++) {
        int index = i;
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

- (void)releasePokemon:(NSString *)pokemonIdentifier {
    int pokemonIndex = [self getPokemonIndexInPokedex:pokemonIdentifier];
    [self.pokedex removeObjectAtIndex:pokemonIndex];
    self.numPokeballs += 1;
    NSLog(@"Pokemon released (%i pokeballs now).", self.numPokeballs);
}

- (void)changePokemonName:(NSString *)pokemonIdentifier changeTo:(NSString *)newName {
    int pokemonIndex = [self getPokemonIndexInPokedex:pokemonIdentifier];
    Pokemon *pokemon = self.pokedex[pokemonIndex];
    NSString *capitalizedNameString = [newName capitalizedString];
    pokemon.name = capitalizedNameString;
    NSLog(@"Name changed to %@", capitalizedNameString);
    [self viewPokedex];
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

- (BOOL)doesOwnPokemon:(NSString *)pokemonIdentifier {
    for (int i = 0; i < [self.pokedex count]; i++) {
        Pokemon *pokemon = self.pokedex[i];
        if ([[pokemonIdentifier lowercaseString] isEqualToString:[pokemon.name lowercaseString]] ||
            [pokemonIdentifier isEqualToString:[NSString stringWithFormat:@"%i", i]]) {
            return TRUE;
        }
    }
    return false;
}

- (void)tradeInPokemon:(NSString *)pokemonIdentifier; {
    int pokemonIndex = [self getPokemonIndexInPokedex:pokemonIdentifier];
    Pokemon *pokemon = self.pokedex[pokemonIndex];
    [self.pokedex removeObjectAtIndex:pokemonIndex];
    self.numPokeballs += pokemon.value;
    NSLog(@"You traded your pokemon for %i pokeballs (%i pokeballs now)... heartless.", pokemon.value, self.numPokeballs);
}

- (BOOL)pokedexIsEmpty {
    return [self.pokedex count] < 1;
}

- (int)getPokemonIndexInPokedex:(NSString *)pokemonIdentifier {
    for (int i = 0; i < [self.pokedex count]; i++) {
        Pokemon *pokemon = self.pokedex[i];
        if ([[pokemonIdentifier lowercaseString] isEqualToString:[pokemon.name lowercaseString]] ||
            [pokemonIdentifier isEqualToString:[NSString stringWithFormat:@"%i", i]]) {
            return i;
        }
    }
    return -1;
}

@end
