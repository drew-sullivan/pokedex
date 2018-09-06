//
//  Person.h
//  pokedex
//
//  Created by Drew Sullivan on 8/28/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pokemon.h"

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;
@property (assign) BOOL isActive;
@property (nonatomic, strong) NSMutableArray<Pokemon*> *pokedex;
@property (assign) int numPokeballs;
@property (strong, nonatomic) NSTimer *timer;

- (void)printName;
- (id) initWithName:(NSString *)name;
- (void)viewPokedex;
- (void)addPokemon:(Pokemon *)pokemon;
- (void)releasePokemon:(NSString *)pokemonName;
- (void)changePokemonName:(NSString *)oldName changeTo:(NSString *)newName;
- (void)attemptToCapture:(Pokemon *)pokemon;
- (BOOL)doesOwnPokemon:(NSString *)pokemonName;
- (void)tradeInPokemon:(NSString *)pokemonName;
- (BOOL)pokedexIsEmpty;

@end
