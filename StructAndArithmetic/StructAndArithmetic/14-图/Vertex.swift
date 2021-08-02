//
//  Vertex.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/7/22.
//

import Cocoa

struct Vertex<V: Comparable & Hashable, E: Comparable> {

    var value: V?
    var inEdges = HashSet<Edge<V, E>>()
    var outEdges = HashSet<Edge<V, E>>()
    
    init(val: V) {
        self.value = val
    }
    
    /// 哈希值
    func hashCode() -> Int {
        if let val = value {
            return val.hashValue
        }
        return 0
    }
    
    func toString() -> String {
        if let val = value {
            return String(describing: val)
        }
        return "nil"
    }
    
    func inEdgesString() -> String {
        if inEdges.lists().isEmpty {
            return "[]"
        }
        var string = ""
        inEdges.lists().forEach { edge in
            string += edge.toString()
            string += "\n"
        }
        return string
    }
    
    func outEdgesString() -> String {
        if outEdges.lists().isEmpty {
            return "[]"
        }
        var string = ""
        outEdges.lists().forEach { edge in
            string += edge.toString()
            string += "\n"
        }
        return string
    }
}

extension Vertex: Hashable & Comparable {
    static func < (lhs: Vertex<V, E>, rhs: Vertex<V, E>) -> Bool {
        return false
    }
    
    static func == (lhs: Vertex<V, E>, rhs: Vertex<V, E>) -> Bool {
        return lhs.value == rhs.value
    }
    
    func hash(into hasher: inout Hasher) {
        let text = String(describing: value)
        hasher.combine(text)
    }
}
