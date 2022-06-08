//
//  Pirater.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/11/4.
//

import Cocoa

/// 最优装载问题
struct Pirater {

    /**
     * 船的载重量为W, 每件股东的重量为Wi, 尽可能多的装载古董
     */
    static func reloadWeight(_ weights: [Double], maxWeight: Double) -> [Double] {
        let newWeights = weights.sorted(by: <)
        
        var weight = 0.0
        var arr = [Double]()
        for i in 0..<newWeights.count {
            weight += newWeights[i]
            if weight < maxWeight {
                arr.append(newWeights[i])
            } else {
                break
            }
        }
        return arr
    }
}
