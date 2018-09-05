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
        
        for (Person *person in rc.people) {
            [person addPokemon:pikachu];
            [person addPokemon:squirtle];
            [person addPokemon:charmander];
            [person addPokemon:bulbasaur];
        }
        
        rc.activePlayer = drew;
        
//        NSLog(@"Please enter your name:");
//        NSString *userInput = [rc getUserInput];
//        BOOL userInputIsNamespaced = [rc isNamespaced:userInput];
//        if (!userInputIsNamespaced) {
//            Person *newPerson = [[Person alloc] initWithName:[userInput capitalizedString]];
//            [rc.people addObject:newPerson];
//            rc.activePlayer = newPerson;
//            NSLog(@"Welcome, %@", newPerson.name);
//        }
        
        
        while (rc.isOngoing) {
            [rc printCommands];
            NSLog(@"What would you like to do, %@?", rc.activePlayer.name);
            NSString *inputString = [rc getUserInput];
            if ([inputString isEqualToString:@"d"]) {
                rc.isOngoing = NO;
                NSLog(@"Thanks for playing!");
            } else if ([inputString isEqualToString:@"s"]) {
                NSLog(@"To whom? %@", [rc getUserNames]);
                NSString *userInput = [rc getUserInput];
                BOOL userInputIsNamespaced = [rc isNamespaced:userInput];
                if (!userInputIsNamespaced) {
                    [rc changeActivePerson:userInput];
                }
            } else if ([inputString isEqualToString:@"p"]) {
                [rc.activePlayer viewPokedex];
            } else if ([inputString isEqualToString:@"e"]) {
                [rc.activePlayer viewPokedex];
                NSLog(@"Which pokemon's name would you like to change?");
                NSString *userInput = [rc getUserInput];
                BOOL userInputIsNamespaced = [rc isNamespaced:userInput];
                if (!userInputIsNamespaced) {
                    BOOL userDoesOwnPokemon = [rc.activePlayer doesOwnPokemon:userInput];
                    if (userDoesOwnPokemon) {
                        NSLog(@"What would you like to change it to?\n");
                        NSString *newName = [rc getUserInput];
                        [rc.activePlayer changePokemonName:userInput changeTo:newName];
                    } else {
                        NSLog(@"You don't own a pokemon by the name %@.", userInput);
                    }
                }
            } else if ([inputString isEqualToString:@"r"]) {
                [rc.activePlayer viewPokedex];
                NSLog(@"Which pokemon would you like to release?");
                NSString *userInput = [rc getUserInput];
                BOOL userInputIsNamespaced = [rc isNamespaced:userInput];
                if (!userInputIsNamespaced) {
                    BOOL userDoesOwnPokemon = [rc.activePlayer doesOwnPokemon:userInput];
                    if (userDoesOwnPokemon) {
                        [rc.activePlayer releasePokemon:userInput];
                        [rc.activePlayer viewPokedex];
                    } else {
                        NSLog(@"You don't own a pokemon by the name %@.", userInput);
                    }
                }
            } else if ([inputString isEqualToString:@"h"]) {
                NSLog(@"You are hunting for pokemon...");
                Pokemon *randomPokemon = [PokemonStore generateRandomPokemon];
                NSLog(@"You see a wild %@!", randomPokemon.name);
                if (rc.activePlayer.numPokeballs < 1) {
                    NSLog(@"You do not have enough pokeballs. Try trading in one of your pokemon for more.");
                } else {
                    NSLog(@"You currently have %i pokeballs. Do you want to try to catch the %@? Y/N.", rc.activePlayer.numPokeballs, randomPokemon.name);
                    NSString *userInput = [rc getUserInput];
                    BOOL userInputIsNamespaced = [rc isNamespaced:userInput];
                    if (!userInputIsNamespaced) {
                        if ([userInput isEqualToString:@"y"]) {
                            [rc.activePlayer attemptToCapture:randomPokemon];
                            [rc.activePlayer viewPokedex];
                        } else {
                            NSLog(@"You back away slowly...");
                        }
                    }
                }
            } else if ([inputString isEqualToString:@"c"]) {
                NSLog(@"Name?");
                NSString *userInput = [rc getUserInput];
                BOOL userInputIsNamespaced = [rc isNamespaced:userInput];
                if (!userInputIsNamespaced) {
                    BOOL isUniqueName = [rc isNameUnique:userInput];
                    if (!isUniqueName) {
                        NSString *newName = [rc getNewName:userInput];
                        userInput = newName;
                    }
                    Person *newPerson = [[Person alloc] initWithName:[userInput capitalizedString]];
                    [rc.people addObject:newPerson];
                    NSLog(@"%@ has been added.", newPerson.name);
                }
            } else if ([inputString isEqualToString:@"t"]) {
                [rc.activePlayer viewPokedex];
                NSLog(@"Which pokemon would you like to trade in?");
                NSString *userInput = [rc getUserInput];
                BOOL userInputIsNamespaced = [rc isNamespaced:userInput];
                if (!userInputIsNamespaced) {
                    BOOL ownsPokemon = [rc.activePlayer doesOwnPokemon:userInput];
                    if (ownsPokemon) {
                        NSLog(@"Are you sure you'd like to trade in %@? Y/N.", userInput);
                        NSString *answer = [rc getUserInput];
                        if ([answer isEqualToString:@"y"]) {
                            [rc.activePlayer tradeInPokemon:userInput];
                            [rc.activePlayer viewPokedex];
                        } else {
                            NSLog(@"No pokemon traded in.");
                        }
                    } else {
                        [rc.activePlayer viewPokedex];
                        NSLog(@"You don't own a pokemon by the name %@.", userInput);
                    }
                }
                
            } else {
                NSLog(@"Unknown command. Please try another.");
            }
        }
    }
}
