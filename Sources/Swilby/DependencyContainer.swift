//
//  DependencyContainer.swift
//  Swilby
//
//  Created by Aleksei Artemev on 13/02/2019
//  Copyright © 2019 iDevs.io All rights reserved.
//

import Foundation

public typealias Container = Resolver
public typealias LightContainer = Applyer & Resolver

// Container
public protocol Applyer {
    func apply<T: Assembly>(_ type: T.Type, name: String?)
    func apply<T: Assembly>(_ type: T.Type)
}

extension Applyer {
    public func apply<T: Assembly>(_ type: T.Type) {
        self.apply(type, name: nil)
    }
}

// Resolver
public protocol Resolver: WeakBox, StrongBox {
    func resolve<T: Assembly>(_ type: T.Type, name: String?) -> T
    func resolve<T: Assembly>(_ type: T.Type) -> T
}

extension Resolver {
    public func resolve<T>(_ type: T.Type) -> T where T : Assembly {
        return self.resolve(type, name: nil)
    }
}

// DI Container
public class DependencyContainer {
    public var weakBoxHolder = [String : WeakContainer<AnyObject>]()
    public var strongBoxHolder = [String : AnyObject]()

    let assemblyFactory: AssemblyFactoryProtocol
    
    public init(assemblyFactory: AssemblyFactoryProtocol) {
        self.assemblyFactory = assemblyFactory
    }
}

extension DependencyContainer: Resolver {
    public func resolve<T>(_ type: T.Type, name: String?) -> T where T : Assembly {
        let module = self.assemblyFactory.resolve(type, name: name)
        return module.init(container: self)
    }
}

extension DependencyContainer: Applyer {
    public func apply<T>(_ type: T.Type, name: String?) where T : AssemblyType {
        self.assemblyFactory.apply(type, name: name)
    }
}
