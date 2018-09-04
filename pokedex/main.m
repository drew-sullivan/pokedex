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
        
        
        NSArray *commands = [NSArray arrayWithObjects:@"SWITCH_USER", @"DONE", @"VIEW_POKEDEX", @"EDIT_POKEDEX", nil];
        
        while (rc.isOngoing) {
            NSLog(@"\n(%@) $ Please enter a command:\n%@", rc.activePlayer.name, commands);
            NSString *inputString = [rc getUserInput];
            if ([inputString isEqualToString:@"DONE"]) {
                rc.isOngoing = NO;
                NSLog(@"All done!");
            } else if ([inputString isEqualToString:@"SWITCH_USER"]) {
                NSMutableArray *names = [[NSMutableArray alloc] init];
                for (int i = 0; i < [rc.people count]; i++) {
                    [names addObject:rc.people[i].name];
                }
                
                NSLog(@"\nTo whom?\n%@", names);
                NSString *inputString = [rc getUserInput];
                
                if ([names containsObject:inputString]) {
                    Person *activePlayer = [rc changeActivePerson:inputString];
                    rc.activePlayer = activePlayer;
                    NSLog(@"Active User changed to: %@", rc.activePlayer.name);
                } else {
                    NSLog(@"No such user.");
                }
            } else if ([inputString isEqualToString:@"VIEW_POKEDEX"]) {
                [rc.activePlayer viewPokedex];
            } else if ([inputString isEqualToString:@"EDIT_POKEDEX"]) {
                
            } else {
                continue;
            }
        }
    }
}
