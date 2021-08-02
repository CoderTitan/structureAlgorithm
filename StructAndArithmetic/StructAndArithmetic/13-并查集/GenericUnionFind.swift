//
//  GenericUnionFind.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/7/21.
//

import Cocoa

/// 泛型并查集
class GenericUnionFind<V: Hashable & Comparable> {

    fileprivate let nodes = HashMap<V, UnionFindNode<V>>()
    
    func makeSet(_ val: V) {
        if nodes.containsKey(key: val) { return }
        let node = UnionFindNode(val: val)
        nodes.put(key: val, val: node)
    }
    
    /// 查找V所属的集合(根节点)
    func find(val: V?) -> V? {
        let node = findNode(val)
        return node == nil ? nil : node?.value
    }
    
    /// 合并v1, v2所在的集合
    func union(v1: V?, v2: V?) {
        if let p1 = findNode(v1), let p2 = findNode(v2) {
            if p1.value == p2.value { return }
            
            if p1.rank < p2.rank {
                p1.parent = p2
            } else if p1.rank > p2.rank {
                p2.parent = p1
            } else {
                p1.parent = p2
                p2.rank += 1
            }
        }
    }
    
    /// 检查v1, v2是否属于同一个集合
    func isSame(v1: V?, v2: V?) -> Bool {
        return find(val: v1) == find(val: v2)
    }
}


extension GenericUnionFind {
    /// 找出V的跟节点
    fileprivate func findNode(_ val: V?) -> UnionFindNode<V>? {
        guard let value = val else { return nil }
        var node = nodes.get(key: value)
        if node == nil { return nil }
        
        while node?.value != node?.parent?.value {
            node?.parent = node?.parent?.parent
            node = node?.parent
        }
        return node
    }
}
