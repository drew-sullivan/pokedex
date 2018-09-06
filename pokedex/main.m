//
//  main.m
//  pokedex
//
//  Created by Drew Sullivan on 8/28/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Pokemon.h"
#import "RealityController.h"
#import "PokemonStore.h"
#import <stdlib.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        RealityController *rc = [[RealityController alloc] initWithStatus:true];
        
        // Uncomment to test
        User *drew = [[User alloc] initWithName:@"Drew"];
        User *rebecca = [[User alloc] initWithName:@"Rebecca"];
        User *cooper = [[User alloc] initWithName:@"Cooper"];
        User *abbott = [[User alloc] initWithName:@"Abbott"];

        [rc.users addObject:drew];
        [rc.users addObject:rebecca];
        [rc.users addObject:cooper];
        [rc.users addObject:abbott];

        Pokemon *pikachu = [[Pokemon alloc] initWithNameAndCaptureDifficulty:@"Pikachu" and:50];
        Pokemon *squirtle = [[Pokemon alloc] initWithNameAndCaptureDifficulty:@"Squirtle" and:80];
        Pokemon *charmander = [[Pokemon alloc] initWithNameAndCaptureDifficulty:@"Charmander" and:80];
        Pokemon *bulbasaur = [[Pokemon alloc] initWithNameAndCaptureDifficulty:@"Bulbasaur" and:80];
        
        for (User *user in rc.users) {
            [user addPokemon:pikachu];
            [user addPokemon:squirtle];
            [user addPokemon:charmander];
            [user addPokemon:bulbasaur];
        }
        
        rc.activeUser = drew;
        
        #pragma mark - registration
//        NSLog(@"Please enter your name:");
//        NSString *userInput = [rc getUserInput];
//        BOOL userInputIsNamespaced = [rc isNamespaced:userInput];
//        if (!userInputIsNamespaced) {
//            User *newUser = [[User alloc] initWithName:[userInput capitalizedString]];
//            [rc.users addObject:newUser];
//            rc.activeUser = newUser;
//            NSLog(@"Welcome, %@", newUser);
//        }
        
        #pragma mark - gameplay
        while (rc.isOngoing) {
            [rc printCommands];
            NSLog(@"What would you like to do, %@?", rc.activeUser.name);
            NSString *inputString = [rc getUserInput];
            #pragma mark - d = [done]
            if ([inputString isEqualToString:@"d"]) {
                rc.isOngoing = NO;
                NSLog(@"Thanks for playing!");
            }
            #pragma mark - s = [s]witch user
            else if ([inputString isEqualToString:@"s"]) {
                NSLog(@"To whom? %@", [rc getUserNames]);
                NSString *userInput = [rc getUserInput];
                BOOL userInputIsNamespaced = [rc isNamespaced:userInput];
                if (!userInputIsNamespaced) {
                    [rc changeActiveUser:userInput];
                }
            }
            #pragma mark - p = view [p]okedex
            else if ([inputString isEqualToString:@"p"]) {
                if ([rc.activeUser pokedexIsEmpty]) {
                    NSLog(@"Your pokedex is empty!");
                    continue;
                }
                [rc.activeUser viewPokedex];
            }
            #pragma mark - e = [e]dit pokemon name
            else if ([inputString isEqualToString:@"e"]) {
                if ([rc.activeUser pokedexIsEmpty]) {
                    NSLog(@"Your pokedex is empty!");
                    continue;
                }
                [rc.activeUser viewPokedex];
                NSLog(@"Which pokemon's name would you like to change?");
                NSString *userInput = [rc getUserInput];
                BOOL userInputIsNamespaced = [rc isNamespaced:userInput];
                if (!userInputIsNamespaced) {
                    BOOL userDoesOwnPokemon = [rc.activeUser doesOwnPokemon:userInput];
                    if (userDoesOwnPokemon) {
                        NSLog(@"What would you like to change it to?\n");
                        NSString *newName = [rc getUserInput];
                        [rc.activeUser changePokemonName:userInput changeTo:newName];
                    } else {
                        NSLog(@"That is not a pokemon you own.");
                        [rc.activeUser viewPokedex];
                    }
                }
            }
            #pragma mark - r = [r]elease pokemon
            else if ([inputString isEqualToString:@"r"]) {
                if ([rc.activeUser pokedexIsEmpty]) {
                    NSLog(@"Your pokedex is empty!");
                    continue;
                }
                [rc.activeUser viewPokedex];
                NSLog(@"Which pokemon would you like to release? You'll receive 1 pokeball back.");
                NSString *userInput = [rc getUserInput];
                BOOL userInputIsNamespaced = [rc isNamespaced:userInput];
                if (!userInputIsNamespaced) {
                    BOOL userDoesOwnPokemon = [rc.activeUser doesOwnPokemon:userInput];
                    if (userDoesOwnPokemon) {
                        [rc.activeUser releasePokemon:userInput];
                        [rc.activeUser viewPokedex];
                    } else {
                        NSLog(@"That is not a pokemon you own.");
                        [rc.activeUser viewPokedex];
                    }
                }
            }
            #pragma mark - h = [h] pokemon
            else if ([inputString isEqualToString:@"h"]) {
                NSLog(@"You are hunting for pokemon...");
                Pokemon *randomPokemon = [PokemonStore generateRandomPokemon];
                NSLog(@"You see a wild %@!", randomPokemon.name);
                if (rc.activeUser.numPokeballs < 1) {
                    NSLog(@"You do not have enough pokeballs. Try trading in or releasing one of your pokemon.");
                } else {
                    NSLog(@"You currently have %i pokeballs. Do you want to try to catch the %@? Y/N.", rc.activeUser.numPokeballs, randomPokemon.name);
                    NSString *userInput = [rc getUserInput];
                    BOOL userInputIsNamespaced = [rc isNamespaced:userInput];
                    if (!userInputIsNamespaced) {
                        if ([userInput isEqualToString:@"y"]) {
                            [rc.activeUser attemptToCapture:randomPokemon];
                            [rc.activeUser viewPokedex];
                        } else {
                            NSLog(@"You back away slowly...");
                        }
                    }
                }
            }
            #pragma mark - c = [c]reate user
            else if ([inputString isEqualToString:@"c"]) {
                NSLog(@"Name?");
                NSString *userInput = [rc getUserInput];
                BOOL userInputIsNamespaced = [rc isNamespaced:userInput];
                if (!userInputIsNamespaced) {
                    BOOL isUniqueName = [rc isNameUnique:userInput];
                    if (!isUniqueName) {
                        NSString *newName = [rc getNewName:userInput];
                        userInput = newName;
                    }
                    User *newUser = [[User alloc] initWithName:[userInput capitalizedString]];
                    [rc.users addObject:newUser];
                    NSLog(@"%@ has been added.", newUser.name);
                }
            }
            #pragma mark - t = [t]rade pokemon in
            else if ([inputString isEqualToString:@"t"]) {
                if ([rc.activeUser pokedexIsEmpty]) {
                    NSLog(@"Your pokedex is empty!");
                    continue;
                }
                [rc.activeUser viewPokedex];
                NSLog(@"Which pokemon would you like to trade in?");
                NSString *userInput = [rc getUserInput];
                BOOL userInputIsNamespaced = [rc isNamespaced:userInput];
                if (!userInputIsNamespaced) {
                    BOOL ownsPokemon = [rc.activeUser doesOwnPokemon:userInput];
                    if (ownsPokemon) {
                        NSLog(@"Are you sure you'd like to trade in this pokemon? Y/N.");
                        NSString *answer = [rc getUserInput];
                        if ([answer isEqualToString:@"y"]) {
                            [rc.activeUser tradeInPokemon:userInput];
                            [rc.activeUser viewPokedex];
                        } else {
                            NSLog(@"No pokemon traded in.");
                        }
                    } else {
                        [rc.activeUser viewPokedex];
                        NSLog(@"You don't own a pokemon by that name.");
                    }
                }
            }
            #pragma mark - g = print [g]ame status
            else if ([inputString isEqualToString:@"g"]) {
                [rc printGameStatus];
            } else {
                NSLog(@"Unknown command. Please try another.");
            }
        }
    }
}
