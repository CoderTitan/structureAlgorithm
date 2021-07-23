//
//  PathInfo.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/7/22.
//

import Cocoa


/// 顶点信息
struct PathInfo<V: Comparable, E: Comparable> {
    
    /// 权重
    var weight: E? {
        set {
            self.weight = newValue
        }
        get {
            return self.weight
        }
    }
    
    /// 所有的边
    var edgeInfos: SingleLinkList<EdgeInfo<V, E>>? {
        set {
            self.edgeInfos = newValue
        }
        get {
            self.edgeInfos
        }
    }
    
    init(weight: E) {
        self.weight = weight
    }
    
    func toString() -> String {
        let weight = String(describing: weight)
        let edgeInfos = String(describing: edgeInfos)
        return "PathInfo [weight=\(weight), edgeInfos = \(edgeInfos)]"
    }
}
