//
//  RealityController.m
//  pokedex
//
//  Created by Drew Sullivan on 8/28/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PokemonStore.h"
#import "PokeUtility.h"
#import "RealityController.h"

static NSArray *COMMANDS = nil;

@implementation RealityController

- (instancetype)initWithStatus:(BOOL)isOngoing {
    COMMANDS = [NSArray arrayWithObjects:@"h = [h]unt pokemon",
                                         @"p = view [p]okedex",
                                         @"e = [e]dit pokemon name",
                                         @"r = [r]elease pokemon",
                                         @"t = [t]rade pokemon in for pokeballs",
                                         @"g = print [g]ame status",
                                         @"c = [c]reate user",
                                         @"s = [s]witch user",
                                         @"d = [d]one",
                                         nil];
    self = [super init];
    if (self) {
        self.isOngoing = isOngoing;
        self.users = [[NSMutableArray alloc] initWithCapacity:4];
    }
    return self;
}

- (void)changeActiveUser:(NSString *)name {
    for (User *user in self.users) {
        if ([[user.name lowercaseString]isEqualToString:[name lowercaseString]]) {
            self.activeUser = user;
            NSLog(@"Active User changed to: %@", self.activeUser.name);
            return;
        }
    }
    NSLog(@"No such user.");
}

- (void)printUsers {
    for (User *user in self.users) {
        NSLog(@"%@", user.name);
    }
}

- (void)printActiveUser {
    NSLog(@"%@", self.activeUser.name);
}

- (NSMutableArray *)getUserNames {
    NSMutableArray *names = [[NSMutableArray alloc] init];
    for (User *user in self.users) {
        [names addObject:[user.name capitalizedString]];
    }
    return names;
}

- (void)printCommands {
    NSLog(@"\n");
    NSLog(@"COMMANDS:\n");
    for (NSString *command in COMMANDS) {
        NSLog(@"%@", command);
    }
    NSLog(@"\n");
}

- (NSMutableArray *)getShorthandCommands {
    NSMutableArray *shorthandCommands = [[NSMutableArray alloc] init];
    for (NSString *command in COMMANDS) {
        NSString *shorthandCommand = [command substringToIndex:1];
        [shorthandCommands addObject:shorthandCommand];
    }
    return shorthandCommands;
}

- (BOOL)isNamespaced:(NSString *)letter {
    for (NSString *shorthandCommand in [self getShorthandCommands]) {
        if ([letter isEqualToString:shorthandCommand]) {
            NSLog(@"Sorry! That's a namespaced command!");
            return YES;
        }
    }
    return NO;
}

- (BOOL)isNameUnique:(NSString *)name {
    for (NSString *existingName in [self getUserNames]) {
        if ([name isEqualToString:[existingName lowercaseString]]) {
            return NO;
        }
    }
    return YES;
}

- (NSString *)getNewName:(NSString *)oldName {
    NSString *numberString;
    NSScanner *scanner = [NSScanner scannerWithString:oldName];
    NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
    [scanner scanCharactersFromSet:numbers intoString:&numberString];
    int number = (int)[numberString integerValue];
    NSString *newName = [NSString stringWithFormat:@"%@-%i", oldName, number + 1];
    return newName;
}

- (void)printGameStatus {
    NSLog(@"\n");
    NSLog(@"GAME STATUS:\n");
    for (User *user in self.users) {
        NSLog(@"\n");
        NSLog(@"%@", [user.name uppercaseString]);
        NSLog(@"NUM POKEBALLS: %i", user.numPokeballs);
        [user viewPokedex];
    }
}

- (void)performReleasePokemonSequence {
    if (![self.activeUser pokedexIsEmpty]) {
        [self.activeUser viewPokedex];
        NSLog(@"Which pokemon would you like to release? You'll receive 1 pokeball back.");
        NSString *userInput = [PokeUtility getUserInput];
        BOOL userInputIsNamespaced = [self isNamespaced:userInput];
        if (!userInputIsNamespaced) {
            BOOL userDoesOwnPokemon = [self.activeUser doesOwnPokemon:userInput];
            if (userDoesOwnPokemon) {
                [self.activeUser releasePokemon:userInput];
                [self.activeUser viewPokedex];
            } else {
                NSLog(@"That is not a pokemon you own.");
                [self.activeUser viewPokedex];
            }
        }
    } else {
        NSLog(@"Your pokedex is empty!");
    }
}

- (void)performEditPokemonNameSequence {
    if (![self.activeUser pokedexIsEmpty]) {
        [self.activeUser viewPokedex];
        NSLog(@"Which pokemon's name would you like to change?");
        NSString *userInput = [PokeUtility getUserInput];
        BOOL userInputIsNamespaced = [self isNamespaced:userInput];
        if (!userInputIsNamespaced) {
            BOOL userDoesOwnPokemon = [self.activeUser doesOwnPokemon:userInput];
            if (userDoesOwnPokemon) {
                NSLog(@"What would you like to change it to?\n");
                NSString *newName = [PokeUtility getUserInput];
                [self.activeUser changePokemonName:userInput changeTo:newName];
            } else {
                NSLog(@"That is not a pokemon you own.");
                [self.activeUser viewPokedex];
            }
        }
    } else {
        NSLog(@"Your pokedex is empty!");
    }
}

- (void)performViewPokedexSequence {
    if (![self.activeUser pokedexIsEmpty]) {
        [self.activeUser viewPokedex];
    } else {
        NSLog(@"Your pokedex is empty!");
    }
}

- (void)performSwitchUserSequence {
    NSLog(@"To whom? %@", [self getUserNames]);
    NSString *userInput = [PokeUtility getUserInput];
    BOOL userInputIsNamespaced = [self isNamespaced:userInput];
    if (!userInputIsNamespaced) {
        [self changeActiveUser:userInput];
    }
}

- (void)performHuntPokemonSequence {
    NSLog(@"You are hunting for pokemon...");
    Pokemon *randomPokemon = [PokemonStore generateRandomPokemon];
    NSLog(@"You see a wild %@!", randomPokemon.name);
    if (self.activeUser.numPokeballs < 1) {
        NSLog(@"You do not have enough pokeballs. Try trading in or releasing one of your pokemon.");
    } else {
        NSLog(@"You currently have %i pokeballs. Do you want to try to catch the %@? Y/N.", self.activeUser.numPokeballs, randomPokemon.name);
        NSString *userInput = [PokeUtility getUserInput];
        BOOL userInputIsNamespaced = [self isNamespaced:userInput];
        if (!userInputIsNamespaced) {
            if ([userInput isEqualToString:@"y"]) {
                [self.activeUser attemptToCapture:randomPokemon];
                [self.activeUser viewPokedex];
            } else {
                NSLog(@"You back away slowly...");
            }
        }
    }
}

- (void)performCreateUserSequence {
    NSLog(@"Name?");
    NSString *userInput = [PokeUtility getUserInput];
    BOOL userInputIsNamespaced = [self isNamespaced:userInput];
    if (!userInputIsNamespaced) {
        BOOL isUniqueName = [self isNameUnique:userInput];
        if (!isUniqueName) {
            NSString *newName = [self getNewName:userInput];
            userInput = newName;
        }
        User *newUser = [[User alloc] initWithName:[userInput capitalizedString]];
        [self.users addObject:newUser];
        NSLog(@"%@ has been added.", newUser.name);
    }
}

- (void)performDoneSequence {
    self.isOngoing = NO;
    NSLog(@"Thanks for playing!");
}

- (void)performTradeSequence {
    if (![self.activeUser pokedexIsEmpty]) {
        [self.activeUser viewPokedex];
        NSLog(@"Which pokemon would you like to trade in?");
        NSString *userInput = [PokeUtility getUserInput];
        BOOL userInputIsNamespaced = [self isNamespaced:userInput];
        if (!userInputIsNamespaced) {
            BOOL ownsPokemon = [self.activeUser doesOwnPokemon:userInput];
            if (ownsPokemon) {
                NSLog(@"Are you sure you'd like to trade in this pokemon? Y/N.");
                NSString *answer = [PokeUtility getUserInput];
                if ([answer isEqualToString:@"y"]) {
                    [self.activeUser tradeInPokemon:userInput];
                    [self.activeUser viewPokedex];
                } else {
                    NSLog(@"No pokemon traded in.");
                }
            } else {
                [self.activeUser viewPokedex];
                NSLog(@"You don't own a pokemon by that name.");
            }
        }
    } else {
        NSLog(@"Your pokedex is empty!");
    }
}

- (void)performRegisterUserSequence:(BOOL)testDataIsPresent {
    if (!testDataIsPresent) {
        NSLog(@"Please enter your name:");
        NSString *userInput = [PokeUtility getUserInput];
        BOOL userInputIsNamespaced = [self isNamespaced:userInput];
        if (!userInputIsNamespaced) {
            User *newUser = [[User alloc] initWithName:[userInput capitalizedString]];
            [self.users addObject:newUser];
            self.activeUser = newUser;
            NSLog(@"Welcome, %@!", newUser.name);
        }
    }
}

- (void)performIntroSequence {
    [self printCommands];
    NSLog(@"What would you like to do now, %@?", self.activeUser.name);
}

- (BOOL)addTestData:(BOOL)shouldAddTestData {
    if (shouldAddTestData) {
        User *drew = [[User alloc] initWithName:@"Drew"];
        User *rebecca = [[User alloc] initWithName:@"Rebecca"];
        User *cooper = [[User alloc] initWithName:@"Cooper"];
        User *abbott = [[User alloc] initWithName:@"Abbott"];
        
        [self.users addObject:drew];
        [self.users addObject:rebecca];
        [self.users addObject:cooper];
        [self.users addObject:abbott];
        
        Pokemon *pikachu = [[Pokemon alloc] initWithNameAndCaptureDifficulty:@"Pikachu" and:50];
        Pokemon *squirtle = [[Pokemon alloc] initWithNameAndCaptureDifficulty:@"Squirtle" and:80];
        Pokemon *charmander = [[Pokemon alloc] initWithNameAndCaptureDifficulty:@"Charmander" and:80];
        Pokemon *bulbasaur = [[Pokemon alloc] initWithNameAndCaptureDifficulty:@"Bulbasaur" and:80];
        
        for (User *user in self.users) {
            [user addPokemon:pikachu];
            [user addPokemon:squirtle];
            [user addPokemon:charmander];
            [user addPokemon:bulbasaur];
        }
        self.activeUser = drew;
        return YES;
    }
    return NO;
}


@end
