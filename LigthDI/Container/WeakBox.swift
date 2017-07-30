//
//  AssemblyWeakBox.swift
//  iBlades
//
//  Created by Bartleby on 17.02.17.
//  Copyright © 2017 i-Blades. All rights reserved.
//

import Foundation

protocol WeakBox: class {
    var weakBoxHolder: [String : WeakContainer<AnyObject>] { set get}
}

extension WeakBox {
    func weakBox<T>(_ configure: () -> T) -> T {
        let key = ObjectKey(T.self).key
        if let object = self.weakBoxHolder[key]?.value {
            return object as! T
        }
        let object = configure()
        weakBoxHolder[key] = WeakContainer(value: object as AnyObject)
        return object
    }
}
