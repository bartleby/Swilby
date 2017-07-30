//
//  SomeModuleAssembly.swift
//  LiteContainer
//
//  Created by Artemev Aleksey on 30.07.17.
//  Copyright © 2017 Artemev Aleksey. All rights reserved.
//

import Foundation

class SomeModuleAssembly: ModuleAssembly {
    func module() -> String {
        return "SomeModule with service: \(self.container.resolveService(SomeServiceAssembly.self).service())"
    }
}
