//
//  UnionFind_QU_Rank_PC.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/7/20.
//

import Cocoa

/*
 * Quick Union - 基于rank的优化, 路径压缩
 * 矮的树嫁接到高的树
 * 路径压缩: 在find时是路径上的所有节点都指向根节点, 从而降低树的高度
 */
class UnionFind_QU_Rank_PC: UnionFind_QU_Rank {

    override func find(v: Int) -> Int {
        rangeCheck(v: v)
        
        if parents[v] != v {
            parents[v] = find(v: parents[v])
        }
        return parents[v]
    }
}
