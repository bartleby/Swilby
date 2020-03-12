//
//  AssemblyFactory.swift
//  Swilby
//
//  Created by Aleksei Artemev on 13/02/2019
//  Copyright © 2019 iDevs.io All rights reserved.
//

import Foundation

public protocol AssemblyFactoryProtocol: class {
    func apply<T: AssemblyType>(_ assembly: T.Type, name: String?)
    func resolve<T: AssemblyType>(_ type: T.Type, name: String?) -> T.Type
}

public class AssemblyFactory {
    typealias AssemblyCollection = [String : Any.Type]
    fileprivate var assemblyCollection = AssemblyCollection()
    
    public init(){
        
    }
}

extension AssemblyFactory: AssemblyFactoryProtocol {
    public func apply<T: AssemblyType>(_ assembly: T.Type, name: String? = nil) {
        let key = ObjectKey(assembly, name: name).key
        self.assemblyCollection[key] = assembly
    }
    
    public func resolve<T: AssemblyType>(_ type: T.Type, name: String? = nil) -> T.Type {
        let key = ObjectKey(type, name: name).key
        guard let assembly = assemblyCollection[key] else { fatalError("Assemblay '\(String(describing: type))' has't been registered, use 'apply( _:)' method") }
        return assembly as! T.Type
    }
}
