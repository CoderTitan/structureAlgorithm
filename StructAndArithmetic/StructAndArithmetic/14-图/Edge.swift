//
//  Edge.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/7/22.
//

import Cocoa

/// 边
struct Edge<V: Comparable & Hashable, E: Comparable> {
    
    var from: Vertex<V, E>?
    var to: Vertex<V, E>?
    var weight: Double?
    
    init(from: Vertex<V, E>?, to: Vertex<V, E>?) {
        self.from = from
        self.to = to
    }
    
    /// 边信息
    func edgeInfo() -> EdgeInfo<V, E> {
        return EdgeInfo(from: from?.value, to: to?.value, weight: weight)
    }
    
    /// 哈希值
    func hashCode() -> Int {
        return (from?.hashCode() ?? 0) * 31 + (to?.hashCode() ?? 0)
    }

    func toString() -> String {
        let from = from?.toString() ?? ""
        let to = to?.toString() ?? ""
        let weight = String(describing: weight)
        return "Edge [from=\(from), to=\(to), weight=\(weight)]"
    }
}


extension Edge: Hashable & Comparable {
    static func == (lhs: Edge<V, E>, rhs: Edge<V, E>) -> Bool {
        return lhs.from == rhs.from && lhs.to == lhs.to
    }
    
    static func < (lhs: Edge<V, E>, rhs: Edge<V, E>) -> Bool {
        if let lhsW = lhs.weight, let rhsW = rhs.weight {
            return lhsW < rhsW
        }
        if lhs.weight == nil && rhs.weight != nil {
            return true
        }
        return false
    }
    
    static func > (lhs: Edge<V, E>, rhs: Edge<V, E>) -> Bool {
        if let lhsW = lhs.weight, let rhsW = rhs.weight {
            return lhsW > rhsW
        }
        if lhs.weight != nil && rhs.weight == nil {
            return true
        }
        return false
    }
    
    func hash(into hasher: inout Hasher) {
        let from = String(describing: from?.hashCode())
        let to = String(describing: to?.hashCode())
        let weight = String(describing: weight?.hashValue)
        hasher.combine(from + to + weight)
    }
}
