//
//  UnionFind_QU_Rank_PS.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/7/20.
//

import Cocoa


/*
 * Quick Union - 基于rank的优化, 路径分裂
 * 矮的树嫁接到高的树
 * 路径分裂: 使路径上的每个节点都指向其祖父节点
 */
class UnionFind_QU_Rank_PS: UnionFind_QU_Rank {

    override func find(v: Int) -> Int {
        rangeCheck(v: v)
        
        var val = v
        if parents[val] != val {
            let p = parents[val]
            parents[val] = parents[p]
            val = p
        }
        return val
    }
}
