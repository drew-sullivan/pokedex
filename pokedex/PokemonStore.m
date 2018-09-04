//
//  PokemonStore.m
//  pokedex
//
//  Created by Drew Sullivan on 9/4/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pokemon.h"
#import "PokemonStore.h"

static NSArray *ORIGINAL_150 = nil;

@implementation PokemonStore

+ (void)initialize {
    ORIGINAL_150 = [NSArray arrayWithObjects: @"Bulbasaur", @"Ivysaur", @"Venusaur", @"Charmander", @"Charmeleon", @"Charizard", @"Squirtle", @"Wartortle", @"Blastoise", @"Caterpie", @"Metapod", @"Butterfree", @"Weedle", @"Kakuna", @"Beedrill", @"Pidgey", @"Pidgeotto", @"Pidgeot", @"Rattata", @"Raticate", @"Spearow", @"Fearow", @"Ekans", @"Arbok", @"Pikachu", @"Raichu", @"Sandshrew", @"Sandslash", @"Nidoran", @"Nidorina", @"Nidoqueen", @"Nidoran", @"Nidorino", @"Nidoking", @"Clefairy", @"Clefable", @"Vulpix", @"Ninetales", @"Jigglypuff", @"Wigglytuff", @"Zubat", @"Golbat", @"Oddish", @"Gloom", @"Vileplume", @"Paras", @"Parasect", @"Venonat", @"Venomoth", @"Diglett", @"Dugtrio", @"Meowth", @"Persian", @"Psyduck", @"Golduck", @"Mankey", @"Primeape", @"Growlithe", @"Arcanine", @"Poliwag", @"Poliwhirl", @"Poliwrath", @"Abra", @"Kadabra", @"Alakazam", @"Machop", @"Machoke", @"Machamp", @"Bellsprout", @"Weepinbell", @"Victreebel", @"Tentacool", @"Tentacruel", @"Geodude", @"Graveler", @"Golem", @"Ponyta", @"Rapidash", @"Slowpoke", @"Slowbro", @"Magnemite", @"Magneton", @"Farfetch'd", @"Doduo", @"Dodrio", @"Seel", @"Dewgong", @"Grimer", @"Muk", @"Shellder", @"Cloyster", @"Gastly", @"Haunter", @"Gengar", @"Onix", @"Drowzee", @"Hypno", @"Krabby", @"Kingler", @"Voltorb", @"Electrode", @"Exeggcute", @"Exeggutor", @"Cubone", @"Marowak", @"Hitmonlee", @"Hitmonchan", @"Lickitung", @"Koffing", @"Weezing", @"Rhyhorn", @"Rhydon", @"Chansey", @"Tangela", @"Kangaskhan", @"Horsea", @"Seadra", @"Goldeen", @"Seaking", @"Staryu", @"Starmie", @"Mr. Mime", @"Scyther", @"Jynx", @"Electabuzz", @"Magmar", @"Pinsir", @"Tauros", @"Magikarp", @"Gyarados", @"Lapras", @"Ditto", @"Eevee", @"Vaporeon", @"Jolteon", @"Flareon", @"Porygon", @"Omanyte", @"Omastar", @"Kabuto", @"Kabutops", @"Aerodactyl", @"Snorlax", @"Articuno", @"Zapdos", @"Moltres", @"Dratini", @"Dragonair", @"Dragonite", @"Mewtwo", @"Mew", nil];
}

+ (Pokemon *)generateRandomPokemon { 
    NSString *randName = ORIGINAL_150[arc4random_uniform((u_int32_t)[ORIGINAL_150 count])];
    int randDifficulty = arc4random_uniform(100);
    Pokemon *randomPokemon = [[Pokemon alloc] initWithNameAndCaptureDifficulty:randName and:randDifficulty];
    return randomPokemon;
}

@end
