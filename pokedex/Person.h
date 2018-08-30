//
//  Person.h
//  pokedex
//
//  Created by Drew Sullivan on 8/28/18.
//  Copyright © 2018 Drew Sullivan, DMA. All rights reserved.
//

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;
@property (assign) BOOL isActive;
//@property (nonatomic, strong) Pokedex *pokedex;

- (void)printName;
- (id) initWithName:(NSString *)name;

@end
