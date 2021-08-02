//
//  UnionFind.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/7/19.
//

import Cocoa

/*
 * 并查集
 * 只接受Int
 * 支持泛型的并查集使用: GenericUnionFind
 */
class UnionFind {

    /// 当前集
    var parents = [Int]()
    
    init(capacity: Int) {
        if capacity <= 0 {
            fatalError("capacity must be >= 1")
        }
        
        parents = Array(repeating: 0, count: capacity)
        for i in 0..<parents.count {
            parents[i] = i
        }
    }
    
    
    /// 查找V所属的集合(根节点)
    func find(v: Int) -> Int {
        fatalError()
    }
    
    /// 合并v1, v2所在的集合
    func union(v1: Int, v2: Int) { }
    
    /// 检查v1, v2是否属于同一个集合
    func isSame(v1: Int, v2: Int) -> Bool {
        return find(v: v1) == find(v: v2)
    }
}

extension UnionFind {
    /// 判断是否越界
    func rangeCheck(v: Int) {
        if v < 0 || v >= parents.count {
            fatalError("v is out of bounds")
        }
    }
}
