//
//  WeakContainer.swift
//  iBlades
//
//  Created by Bartleby on 15.08.16.
//  Copyright © 2016 i-Blades. All rights reserved.
//

import Foundation

class WeakContainer<T> {
    fileprivate weak var _value: AnyObject?
    var value: T? {
        set { self._value = newValue as AnyObject }
        get { return _value as? T }
    }
    
    init(value: T) {
        self._value = value as AnyObject
    }
}
