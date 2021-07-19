//
//  BubbleSorted.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/6/7.
//

import Cocoa

/// 冒泡排序
class BubbleSorted1<T: Comparable>: Sorted<T> {
    
    /*
     * 正常排序
     * [51, 30, 39, 92, 74, 25, 16, 93, 91, 19, 54, 47, 73, 62, 76, 63, 35, 18, 90, 6, 65, 49, 3, 26, 61, 21, 48]
     * 比较：351次, 交换：147次
     */
    override func sortAction() {
        for i in (1...dataArray.count - 1).reversed() {
            for j in 1...i {
                if cmp(i1: j, i2: j - 1) > 0 {
                    swap(i1: j, i2: j - 1)
                }
            }
        }
    }
}





class BubbleSorted2<T: Comparable>: Sorted<T> {
    
    /*
     * 判断是否已经是有序
     * [51, 30, 39, 92, 74, 25, 16, 93, 91, 19, 54, 47, 73, 62, 76, 63, 35, 18, 90, 6, 65, 49, 3, 26, 61, 21, 48]
     * 比较：296次, 交换：147次
     */
    override func sortAction() {
        for i in (1...dataArray.count - 1).reversed() {
            // 当前序列已经有序
            var isSorted = true
            for j in 1...i {
                if cmp(i1: j, i2: j - 1) > 0 {
                    swap(i1: j, i2: j - 1)
                    isSorted = false
                }
            }
            if isSorted { break }
        }
    }
}


