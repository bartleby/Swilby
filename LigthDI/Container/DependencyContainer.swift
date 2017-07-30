//
//  DependencyContainer.swift
//  LiteContainer
//
//  Created by Artemev Aleksey on 29.07.17.
//  Copyright © 2017 Artemev Aleksey. All rights reserved.
//

import Foundation

protocol DependencyContainerProtocol {
    func applay<T: Assembly>(_ type: T.Type)
}

protocol ModuleResolver: WeakBox, StrongBox {
    func resolveModule<T: ModuleAssembly>(_ type: T.Type) -> T
}

protocol ServiceResolver: WeakBox, StrongBox {
    func resolveService<T: ServiceAssembly>(_ type: T.Type) -> T
}

class DependencyContainer: DependencyContainerProtocol, ModuleResolver, ServiceResolver {
    internal var weakBoxHolder = [String : WeakContainer<AnyObject>]()
    internal var strongBoxHolder = [String : AnyObject]()

    let assemblyFactory: AssemblyFactoryProtocol
    
    init(assemblyFactory: AssemblyFactoryProtocol) {
        self.assemblyFactory = assemblyFactory
    }
    
    func applay<T: Assembly>(_ type: T.Type) {
        self.assemblyFactory.apply(type)
    }
    
    func resolveModule<T: ModuleAssembly>(_ type: T.Type) -> T {
        let module = self.assemblyFactory.resolve(type)
        return module.init(container: self)
    }
    
    func resolveService<T: ServiceAssembly>(_ type: T.Type) -> T {
        let service = self.assemblyFactory.resolve(type)
        return service.init(container: self)
    }
}
