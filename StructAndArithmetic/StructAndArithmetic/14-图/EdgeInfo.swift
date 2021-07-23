//
//  EdgeInfo.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/7/22.
//

import Cocoa

/// 边信息
struct EdgeInfo<V: Comparable, E: Comparable>: Comparable {

    /// 起始点
    var from: V? {
        set {
            self.from = newValue
        }
        get {
            return self.from
        }
    }
    
    /// 终止点
    var to: V? {
        set {
            self.to = newValue
        }
        get {
            return self.to
        }
    }
    
    /// 权重
    var weight: E? {
        set {
            self.weight = newValue
        }
        get {
            return self.weight
        }
    }
    
    
    init(from: V?, to: V?, weight: E?) {
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
    
    
    static func < (lhs: EdgeInfo<V, E>, rhs: EdgeInfo<V, E>) -> Bool {
        return false
    }
    
    static func == (lhs: EdgeInfo<V, E>, rhs: EdgeInfo<V, E>) -> Bool {
        return false
    }
}
