//
//  WeightManager.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/7/22.
//

import Cocoa

class WeightManager<E: Comparable> {

    func compare(e1: E, e2: E) -> Int {
        return 0
    }
    
    func add(e1: E, e2: E) -> E? {
        return nil
    }
    
    func zero() -> E? {
        return nil
    }
}


class VertexVisitor<V: Comparable> {
    func visit(v: V) -> Bool {
        return false
    }
}
