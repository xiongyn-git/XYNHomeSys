//
//  AppDelegate.h
//  XYNHomeSys
//
//  Created by 熊亚男 on 2020/12/30.
//  Copyright © 2020年 熊亚男. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

