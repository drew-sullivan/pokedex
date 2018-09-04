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
        self.numPokeballs = 10;
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

- (void)attemptToCapture:(Pokemon *)pokemon {
    self.numPokeballs -= 1;
    NSLog(@"You tossed a pokeball! (%i remaining)", self.numPokeballs);
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    NSRunLoop *runner = [NSRunLoop mainRunLoop];
    [runner addTimer:timer forMode:NSDefaultRunLoopMode];
//    [timer invalidate];
    
    
    int difficulty = pokemon.captureDifficulty;
    int rand = arc4random_uniform(50);
    if (rand <= difficulty) {
        NSLog(@"You caught %@!", pokemon.name);
        [self.pokedex addObject:pokemon];
    } else {
        NSLog(@"%@ got away!", pokemon.name);
    }
}

- (void) timerFired:(NSTimer*)theTimer
{
    NSLog(@"yay");
}

@end
