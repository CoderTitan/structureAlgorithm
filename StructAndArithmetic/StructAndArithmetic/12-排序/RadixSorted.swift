//
//  RadixSorted.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/7/14.
//

import Cocoa


/// 基数排序
class RadixSorted<T: Comparable>: Sorted<T> {
    

    override func sortAction() {
        // 找出最大值
        var max = dataArray[0]
        for item in dataArray {
            if cmp(e1: max, e2: item) < 0 {
                max = item
            }
        }
        
        var divider = 1
        let maxInt = max as? Int ?? 0
        while divider <= maxInt {
            insertSort(divider)
            divider *= 10
        }
    }
    
    fileprivate func insertSort(_ divider: Int) {
        for i in 1..<dataArray.count {
            var current = i
            while current > 0 {
                let e1 = (dataArray[current] as? Int ?? 0) / divider % 10
                let e2 = (dataArray[current - 1] as? Int ?? 0) / divider % 10
                if e1 < e2 {
                    swap(i1: current, i2: current - 1)
                }
                current -= 1
            }
        }
    }
}
