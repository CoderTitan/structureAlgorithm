//
//  ShellSort.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/6/26.
//

import Cocoa

/// 希尔排序
class ShellSort<T: Comparable>: Sorted<T> {

    override func sortAction() {
        let stepArr = sedgewickStepArray()
        stepArr.forEach({ stepSorted($0) })
    }
    
    
    /// 分成step列进行排序
    fileprivate func stepSorted(_ step: Int) {
        for i in 0..<step {
            var begin = step + i
            while begin < dataArray.count {
                var current = begin
                while current > i, cmp(i1: current, i2: current - step) < 0 {
                    swap(i1: current, i2: current - step)
                    current -= step
                }
                begin += step
            }
        }
    }
}


extension ShellSort {
    /// 希尔本人提出的步长
    fileprivate func shellStepArray() -> [Int] {
        var stepArr = [Int]()
        var step = dataArray.count >> 1
        while step > 0 {
            stepArr.append(step)
            step >>= 1
        }
        return stepArr
    }
    
    /// 目前最好的步长序列
    fileprivate func sedgewickStepArray() -> [Int] {
        var stepArr = [Int]()
        var k: Float = 0
        var step = 0
        while step < dataArray.count {
            if Int(k) % 2 == 0 {
                let pow = Int(powf(2, k / 2))
                step = 9 * pow * (pow - 1)  + 1
            } else {
                let pow1 = Int(powf(2, k))
                let pow2 = Int(powf(2, (k + 1) / 2))
                step = 8 * pow1 - 6 * pow2 + 1
            }
            stepArr.insert(step, at: 0)
            k += 1
        }
        
        return stepArr
    }
}
