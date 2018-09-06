//
//  main.m
//  pokedex
//
//  Created by Drew Sullivan on 8/28/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <stdlib.h>
#import "Pokemon.h"
#import "PokemonStore.h"
#import "PokeUtility.h"
#import "RealityController.h"
#import "User.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        RealityController *rc = [[RealityController alloc] initWithStatus:YES];
        
        // Uncomment to test
//        User *drew = [[User alloc] initWithName:@"Drew"];
//        User *rebecca = [[User alloc] initWithName:@"Rebecca"];
//        User *cooper = [[User alloc] initWithName:@"Cooper"];
//        User *abbott = [[User alloc] initWithName:@"Abbott"];
//
//        [rc.users addObject:drew];
//        [rc.users addObject:rebecca];
//        [rc.users addObject:cooper];
//        [rc.users addObject:abbott];
//
//        Pokemon *pikachu = [[Pokemon alloc] initWithNameAndCaptureDifficulty:@"Pikachu" and:50];
//        Pokemon *squirtle = [[Pokemon alloc] initWithNameAndCaptureDifficulty:@"Squirtle" and:80];
//        Pokemon *charmander = [[Pokemon alloc] initWithNameAndCaptureDifficulty:@"Charmander" and:80];
//        Pokemon *bulbasaur = [[Pokemon alloc] initWithNameAndCaptureDifficulty:@"Bulbasaur" and:80];
//
//        for (User *user in rc.users) {
//            [user addPokemon:pikachu];
//            [user addPokemon:squirtle];
//            [user addPokemon:charmander];
//            [user addPokemon:bulbasaur];
//        }
//
//        rc.activeUser = drew;
        
        [rc performRegisterUserSequence];
        
        while (rc.isOngoing) {
            [rc performIntroSequence];
            NSString *inputString = [PokeUtility getUserInput];
            if ([inputString isEqualToString:@"d"]) {
                [rc performDoneSequence];
            } else if ([inputString isEqualToString:@"s"]) {
                [rc performSwitchUserSequence];
            } else if ([inputString isEqualToString:@"p"]) {
                [rc performViewPokedexSequence];
            } else if ([inputString isEqualToString:@"e"]) {
                [rc performEditPokemonNameSequence];
            } else if ([inputString isEqualToString:@"r"]) {
                [rc performReleasePokemonSequence];
            } else if ([inputString isEqualToString:@"h"]) {
                [rc performHuntPokemonSequence];
            } else if ([inputString isEqualToString:@"c"]) {
                [rc performCreateUserSequence];
            } else if ([inputString isEqualToString:@"t"]) {
                [rc performTradeSequence];
            } else if ([inputString isEqualToString:@"g"]) {
                [rc printGameStatus];
            } else {
                NSLog(@"Unknown command. Please try another.");
            }
        }
    }
}
