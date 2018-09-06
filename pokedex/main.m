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
        
        BOOL testDataIsPresent = [rc addTestData:NO];
        
        [rc performRegisterUserSequence:testDataIsPresent];
        
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
