//
//  QuickSorted.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/6/26.
//

import Cocoa

/// 快速排序
class QuickSorted<T: Comparable>: Sorted<T> {

    
    override func sortAction() {
        quickSort(begin: 0, end: dataArray.count)
    }

    
    /**
     * 对 [begin, end) 范围的元素进行快速排序
     * @param begin
     * @param end
     */
    fileprivate func quickSort(begin: Int, end: Int) {
        if end - begin < 2 { return }
        let pivot = pivotIndex(first: begin, last: end)
        
        // 对子序列排序
        quickSort(begin: begin, end: pivot)
        quickSort(begin: pivot + 1, end: end)
    }
    
    
    /**
     * 构造出 [begin, end) 范围的轴点元素
     * @return 轴点元素的最终位置
     * 为了避免分割出来的数列极度不均匀, 取一个随机的索引和第一个交换
     */
    fileprivate func pivotIndex(first: Int, last: Int) -> Int {
        // 随机的索引和first交换
        let random = Int.random(in: first..<last)
        swap(i1: random, i2: first)
        
        let pivotVal = dataArray[first]
        var begin = first
        var end = last - 1
        
        while begin < end {
            while begin < end {
                if cmp(e1: pivotVal, e2: dataArray[end]) < 0 {
                    end -= 1
                } else {
                    dataArray[begin] = dataArray[end]
                    begin += 1
                    break
                }
            }
            while begin < end {
                if cmp(e1: pivotVal, e2: dataArray[begin]) > 0 {
                    begin += 1
                } else {
                    dataArray[end] = dataArray[begin]
                    end -= 1
                    break
                }
            }
        }
        
        dataArray[begin] = pivotVal
        return begin
    }
}
