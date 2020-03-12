//
//  Assembly.swift
//  Swilby
//
//  Created by Aleksei Artemev on 13/02/2019
//  Copyright © 2019 iDevs.io All rights reserved.
//

import Foundation

public protocol AssemblyType: class {
    associatedtype Container
    var container: Container {get set}
    init(container: Container)
}

open class Assembly: AssemblyType {
    //typealias Container = Resolver
    
    public var container: Container
    
    required public init(container: Container) {
        self.container = container
    }
}

// Box
public extension Assembly {
    func weakBox<T>(_ configure: () -> T) -> T {
        return self.container.weakBox(configure)
    }
    
    func strongBox<T>(_ configure: () -> T) -> T {
        return self.container.strongBox(configure)
    }
}
