//
//  AppDelegate.swift
//  Sample
//
//  Created by Artemev Aleksey on 30.07.17.
//  Copyright © 2017 Artemev Aleksey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let factory: AssemblyFactoryProtocol = AssemblyFactory()
        let container: LightContainer = DependencyContainer(assemblyFactory: factory)
        
        container.apply(SomeModuleAssembly.self)
        container.apply(SomeServiceAssembly.self)
        
        let result = container.resolve(SomeModuleAssembly.self).build()
        print(result)
        
        return true
    }
}
