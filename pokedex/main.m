//
//  main.m
//  pokedex
//
//  Created by Drew Sullivan on 8/28/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "Pokemon.h"
#import "RealityController.h"
#import "PokemonStore.h"
#import <stdlib.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        RealityController *rc = [[RealityController alloc] initWithStatus:true];
        
        Person *drew = [[Person alloc] initWithName:@"Drew"];
        Person *rebecca = [[Person alloc] initWithName:@"Rebecca"];
        Person *cooper = [[Person alloc] initWithName:@"Cooper"];
        Person *abbott = [[Person alloc] initWithName:@"Abbott"];
        
        [rc.people addObject:drew];
        [rc.people addObject:rebecca];
        [rc.people addObject:cooper];
        [rc.people addObject:abbott];
        
        Pokemon *pikachu = [[Pokemon alloc] initWithNameAndCaptureDifficulty:@"Pikachu" and:50];
        Pokemon *squirtle = [[Pokemon alloc] initWithNameAndCaptureDifficulty:@"Squirtle" and:80];
        Pokemon *charmander = [[Pokemon alloc] initWithNameAndCaptureDifficulty:@"Charmander" and:80];
        Pokemon *bulbasaur = [[Pokemon alloc] initWithNameAndCaptureDifficulty:@"Bulbasaur" and:80];
        
        rc.activePlayer = drew;
        
        for (Person *person in rc.people) {
            [person addPokemon:pikachu];
            [person addPokemon:squirtle];
            [person addPokemon:charmander];
            [person addPokemon:bulbasaur];
        }
        
        NSArray *commands = [NSArray arrayWithObjects:@"SWITCH_USER", @"DONE", @"POKEDEX", @"EDIT", @"RELEASE", @"HUNT", nil];
        
        while (rc.isOngoing) {
            NSLog(@"(%@) $ Please enter a command:\n%@", rc.activePlayer.name, commands);
            NSString *inputString = [rc getUserInput];
            if ([inputString isEqualToString:@"DONE"]) {
                rc.isOngoing = NO;
                NSLog(@"All done!");
            } else if ([inputString isEqualToString:@"SWITCH_USER"]) {
                NSLog(@"To whom?%@", [rc getUserNames]);
                NSString *inputString = [rc getUserInput];
                [rc changeActivePerson:inputString];
            } else if ([inputString isEqualToString:@"POKEDEX"]) {
                [rc.activePlayer viewPokedex];
            } else if ([inputString isEqualToString:@"EDIT"]) {
                NSLog(@"Which pokemon's name would you like to change?\n");
                NSString *nameOfPokemonToEdit = [rc getUserInput];
                NSLog(@"What would you like to change it to?\n");
                NSString *newName = [rc getUserInput];
                [rc.activePlayer changePokemonName:nameOfPokemonToEdit changeTo:newName];
            } else if ([inputString isEqualToString:@"RELEASE"]) {
                NSLog(@"Which pokemon would you like to release?");
                NSString *name = [rc getUserInput];
                [rc.activePlayer releasePokemon:name];
            } else if ([inputString isEqualToString:@"HUNT"]) {
                NSLog(@"You are hunting for pokemon...");
                Pokemon *randomPokemon = [PokemonStore generateRandomPokemon];
                NSLog(@"You see a wild %@!", randomPokemon.name);
                if (rc.activePlayer.numPokeballs < 1) {
                    NSLog(@"You do not have enough pokeballs. Try selling one of your current pokemon.");
                    continue;
                } else {
                    NSLog(@"You currently have %i pokeballs. Do you want to try to catch the %@? (YES or NO)", rc.activePlayer.numPokeballs, randomPokemon.name);
                    NSString *inputString = [rc getUserInput];
                    if ([inputString isEqualToString:@"YES"]) {
                        [rc.activePlayer attemptToCapture:randomPokemon];
                    } else {
                        continue;
                    }
                }
            } else {
                continue;
            }
        }
    }
}
