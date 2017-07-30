//
//  BaseAssembly.swift
//  iBlades
//
//  Created by Bartleby on 23.01.17.
//  Copyright © 2017 i-Blades. All rights reserved.
//

import Foundation

protocol Assembly: class {
    associatedtype Container
    var container: Container {get set}
    init(container: Container)
}

class ModuleAssembly: Assembly {
    typealias Container = ModuleResolver & ServiceResolver
    
    var container: Container
    
    required init(container: Container) {
        self.container = container
    }
}

class ServiceAssembly: Assembly {
    typealias Container = ServiceResolver
    
    var container: Container
    
    required init(container: Container) {
        self.container = container
    }
}

// Box
extension ModuleAssembly {
    //typealias Container = WeakBox & StrongBox
    func weakBox<T>(_ configure: () -> T) -> T {
        return self.container.weakBox(configure)
    }
    
    func strongBox<T>(_ configure: () -> T) -> T {
        return self.container.strongBox(configure)
    }
}

extension ServiceAssembly {
    //typealias Container = WeakBox & StrongBox
    func weakBox<T>(_ configure: () -> T) -> T {
        return self.container.weakBox(configure)
    }
    
    func strongBox<T>(_ configure: () -> T) -> T {
        return self.container.strongBox(configure)
    }
}
