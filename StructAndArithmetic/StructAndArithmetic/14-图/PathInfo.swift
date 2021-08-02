//
//  PathInfo.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/7/22.
//

import Cocoa


/// 路径信息
class PathInfo<V: Comparable, E: Comparable> {
    
    /// 权重
    var weight: Double = 0
    
    /// 路径上所有的边, 存储的有顺序的边
    var edgeInfos = [EdgeInfo<V, E>]()
    
    
    func toString() -> String {
        let weight = String(describing: weight)
        var infoString = "PathInfo = [ weight=\(weight), edgeInfos = [\n"
        for edge in edgeInfos.reversed() {
            infoString += edge.toString() + "\n"
        }
        infoString += "]]"
        return infoString
    }
}

extension PathInfo: Comparable {
    static func < (lhs: PathInfo<V, E>, rhs: PathInfo<V, E>) -> Bool {
        return lhs.weight < rhs.weight
    }
    
    static func > (lhs: PathInfo<V, E>, rhs: PathInfo<V, E>) -> Bool {
        return lhs.weight > rhs.weight
    }
    
    static func == (lhs: PathInfo<V, E>, rhs: PathInfo<V, E>) -> Bool {
        return lhs.weight == rhs.weight
    }
}
