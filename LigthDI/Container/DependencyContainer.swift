//
//  DependencyContainer.swift
//  LiteContainer
//
//  Created by Artemev Aleksey on 29.07.17.
//  Copyright © 2017 Artemev Aleksey. All rights reserved.
//

import Foundation

typealias LightContainer = DependencyContainerProtocol & ModuleResolver & ServiceResolver

protocol DependencyContainerProtocol {
    func applay<T: Assembly>(_ type: T.Type, name: String?)
    func applay<T: Assembly>(_ type: T.Type)
}

protocol ModuleResolver: WeakBox, StrongBox {
    func resolveModule<T: ModuleAssembly>(_ type: T.Type, name: String?) -> T
    func resolveModule<T: ModuleAssembly>(_ type: T.Type) -> T
}

protocol ServiceResolver: WeakBox, StrongBox {
    func resolveService<T: ServiceAssembly>(_ type: T.Type, name: String?) -> T
    func resolveService<T: ServiceAssembly>(_ type: T.Type) -> T
}

extension ModuleResolver {
    func resolveModule<T>(_ type: T.Type) -> T where T : ModuleAssembly {
        return self.resolveModule(type, name: nil)
    }
}

extension ServiceResolver {
    func resolveService<T>(_ type: T.Type) -> T where T : ServiceAssembly {
        return self.resolveService(type, name: nil)
    }
}

extension DependencyContainerProtocol {
    func applay<T: Assembly>(_ type: T.Type) {
        self.applay(type, name: nil)
    }
}


// DI Container
class DependencyContainer {
    internal var weakBoxHolder = [String : WeakContainer<AnyObject>]()
    internal var strongBoxHolder = [String : AnyObject]()

    let assemblyFactory: AssemblyFactoryProtocol
    
    init(assemblyFactory: AssemblyFactoryProtocol) {
        self.assemblyFactory = assemblyFactory
    }
}

extension DependencyContainer: ServiceResolver {
    func resolveService<T>(_ type: T.Type, name: String?) -> T where T : ServiceAssembly {
        let service = self.assemblyFactory.resolve(type, name: name)
        return service.init(container: self)
    }
}

extension DependencyContainer: ModuleResolver {
    func resolveModule<T>(_ type: T.Type, name: String?) -> T where T : ModuleAssembly {
        let module = self.assemblyFactory.resolve(type, name: name)
        return module.init(container: self)
    }
}

extension DependencyContainer: DependencyContainerProtocol {
    func applay<T>(_ type: T.Type, name: String?) where T : Assembly {
        self.assemblyFactory.apply(type, name: name)
    }
}
