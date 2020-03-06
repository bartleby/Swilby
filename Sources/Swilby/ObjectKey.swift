//
//  ObjectKey.swift
//  Swilby
//
//  Created by Aleksei Artemev on 13/02/2019
//  Copyright © 2019 iDevs.io All rights reserved.
//

import Foundation

internal struct ObjectKey {
    fileprivate let objectType: Any.Type
    fileprivate let name: String?
    
    fileprivate(set) var key: String {
        get { return String(self.hashValue) }
        set {}
    }
    
    internal init(_ objectType: Any.Type, name: String? = nil) {
        self.objectType = objectType
        self.name = name
    }
}

// MARK: Hashable
extension ObjectKey: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: objectType).hashValue ^ (name.hashValue ))
    }
}

// MARK: Equatable
func == (lhs: ObjectKey, rhs: ObjectKey) -> Bool {
    return lhs.objectType == rhs.objectType && lhs.name == rhs.name
}
