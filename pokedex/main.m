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
        
        Pokemon *pikachu = [[Pokemon alloc] initWithNameAndCaptureDifficulty:@"Pikachu" and:20];
        Pokemon *squirtle = [[Pokemon alloc] initWithNameAndCaptureDifficulty:@"Squirtle" and:5];
        Pokemon *charmander = [[Pokemon alloc] initWithNameAndCaptureDifficulty:@"Charmander" and:5];
        Pokemon *bulbasaur = [[Pokemon alloc] initWithNameAndCaptureDifficulty:@"Bulbasaur" and:5];
        
        rc.activePlayer = drew;
        
        for (Person *person in rc.people) {
            [person addPokemon:pikachu];
            [person addPokemon:squirtle];
            [person addPokemon:charmander];
            [person addPokemon:bulbasaur];
        }
        
        
        NSArray *commands = [NSArray arrayWithObjects:@"SWITCH_USER", @"DONE", @"VIEW_POKEDEX", @"EDIT_POKEMON", @"RELEASE_POKEMON", nil];
        
        while (rc.isOngoing) {
            NSLog(@"\n(%@) $ Please enter a command:\n%@", rc.activePlayer.name, commands);
            NSString *inputString = [rc getUserInput];
            if ([inputString isEqualToString:@"DONE"]) {
                rc.isOngoing = NO;
                NSLog(@"All done!");
            } else if ([inputString isEqualToString:@"SWITCH_USER"]) {
                NSLog(@"\nTo whom?\n%@", [rc getUserNames]);
                NSString *inputString = [rc getUserInput];
                [rc changeActivePerson:inputString];
            } else if ([inputString isEqualToString:@"VIEW_POKEDEX"]) {
                [rc.activePlayer viewPokedex];
            } else if ([inputString isEqualToString:@"EDIT_POKEMON"]) {
                NSLog(@"\nWhich pokemon's name would you like to change?\n");
                NSString *nameOfPokemonToEdit = [rc getUserInput];
                NSLog(@"\nWhat would you like to change it to?\n");
                NSString *newName = [rc getUserInput];
                [rc.activePlayer changePokemonName:nameOfPokemonToEdit changeTo:newName];
            } else if ([inputString isEqualToString:@"RELEASE_POKEMON"]) {
                NSLog(@"\nWhich pokemon would you like to release?\n");
                NSString *name = [rc getUserInput];
                [rc.activePlayer releasePokemon:name];
            } else {
                continue;
            }
        }
    }
}
