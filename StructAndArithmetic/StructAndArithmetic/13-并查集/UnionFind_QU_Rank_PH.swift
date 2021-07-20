//
//  UnionFind_QU_Rank_PH.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/7/20.
//

import Cocoa


/*
 * Quick Union - 基于rank的优化, 路径减半
 * 矮的树嫁接到高的树
 * 路径减半: 使路径上每隔一个节点就指向其祖父节点
 */
class UnionFind_QU_Rank_PH: UnionFind_QU_Rank {

    override func find(v: Int) -> Int {
        rangeCheck(v: v)
        
        var val = v
        if parents[val] != val {
            parents[val] = parents[parents[val]]
            val = parents[val]
        }
        return val
    }
}
