//
//  UnionFindNode.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/7/22.
//

import Cocoa

class UnionFindNode<V: Hashable & Comparable>: Comparable {
    
    var value: V?
    var parent: UnionFindNode<V>?
    var rank = 1
    
    init(val: V?) {
        value = val
        parent = self
    }
    
    static func == (lhs: UnionFindNode<V>, rhs: UnionFindNode<V>) -> Bool {
        return lhs.value == rhs.value
    }
    
    static func < (lhs: UnionFindNode<V>, rhs: UnionFindNode<V>) -> Bool {
        let lElement = lhs.value
        let rElement = rhs.value

        if let lhsVal = lElement, let rhsVal = rElement {
            return lhsVal < rhsVal
        } else if lElement != nil && rElement == nil {
            return false
        } else if lElement == nil && rElement != nil {
            return true
        }
        return false
    }
    
}
