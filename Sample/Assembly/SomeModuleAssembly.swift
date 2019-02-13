//
//  SomeModuleAssembly.swift
//  LiteContainer
//
//  Created by Artemev Aleksey on 30.07.17.
//  Copyright © 2017 Artemev Aleksey. All rights reserved.
//

import Foundation

class SomeModuleAssembly: Assembly {
    func build() -> String {
        let service = container.resolve(SomeServiceAssembly.self).build()
        return "SomeModule with service: \(service)"
    }
}
