//
//  EdgeInfo.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/7/22.
//

import Cocoa

/// 边信息
struct EdgeInfo<V: Comparable, E: Comparable> {

    /// 起始点
    var from: V?
    
    /// 终止点
    var to: V?
    
    /// 权重
    var weight: Double?
    
    
    init(from: V?, to: V?, weight: Double?) {
        self.from = from
        self.to = to
        self.weight = weight
    }
    
    func toString() -> String {
        let from = String(describing: from)
        let to = String(describing: to)
        let weight = String(describing: weight)
        return "EdgeInfo [from=\(from), to=\(to), weight=\(weight)]"
    }
}
 
extension EdgeInfo: Comparable & Hashable {
    static func < (lhs: EdgeInfo<V, E>, rhs: EdgeInfo<V, E>) -> Bool {
        if let lhsW = lhs.weight, let rhsW = rhs.weight {
            return lhsW < rhsW
        }
        if lhs.weight == nil && rhs.weight != nil {
            return true
        }
        return false
    }
    
    static func > (lhs: EdgeInfo<V, E>, rhs: EdgeInfo<V, E>) -> Bool {
        if let lhsW = lhs.weight, let rhsW = rhs.weight {
            return lhsW > rhsW
        }
        if lhs.weight != nil && rhs.weight == nil {
            return true
        }
        return false
    }
    
    static func == (lhs: EdgeInfo<V, E>, rhs: EdgeInfo<V, E>) -> Bool {
        if let lhsW = lhs.weight, let rhsW = rhs.weight {
            return lhsW == rhsW
        }
        return lhs.weight == nil && rhs.weight == nil
    }
    
    func hash(into hasher: inout Hasher) {
        let from = String(describing: from)
        let to = String(describing: to)
        let weight = String(describing: weight)
        hasher.combine(from + to + weight)
    }
}
