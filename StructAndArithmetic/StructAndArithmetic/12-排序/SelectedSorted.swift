//
//  SelectedSorted.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/6/26.
//

import Cocoa

/// 选择排序
class SelectedSorted<T: Comparable>: Sorted<T> {
    
    /// 从序列中找出最大的元素放到最后, 以此类推
    override func sortAction() {
        for i in (1..<dataArray.count).reversed() {
            var max = 0
            for j in 1...i {
                if cmp(i1: max, i2: j) < 0 {
                    max = j
                }
            }

            swap(i1: max, i2: i)
        }
    }
}
