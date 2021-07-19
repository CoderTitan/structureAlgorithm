//
//  InsertionSorted.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/6/26.
//

import Cocoa

/// 插入排序
class InsertionSorted1<T: Comparable>: Sorted<T> {

    /*
     * 插入排序会将数列分为两个部分, 头部是已经排序好的, 尾部是待排序的部分
     * 从头开始扫描每一个元素, 只要比头部的数据小, 就插入到头部一个合适的位置
     */
    override func sortAction() {
        for i in 1..<dataArray.count {
            var current = i
            while current > 0 {
                if cmp(i1: current, i2: current - 1) < 0 {
                    swap(i1: current, i2: current - 1)
                }
                current -= 1
            }
        }
    }
}


class InsertionSorted2<T: Comparable>: Sorted<T> {

    /*
     * 将交换改为挪动
     * 先记录待插入的元素
     * 头部有序数列中比待插入元素大的, 都向后挪动一个位置
     * 将待插入元素放到合适的位置
     */
    override func sortAction() {
        for i in 1..<dataArray.count {
            var current = i
            let value = dataArray[current]
            while current > 0 && cmp(e1: value, e2: dataArray[current - 1]) < 0 {
                dataArray[current] = dataArray[current - 1]
                current -= 1
            }
            dataArray[current] = value
        }
    }
}


class InsertionSorted3<T: Comparable>: Sorted<T> {

    /*
     * 二分搜索查找索引
     * 先记录待插入的元素
     * 头部有序数列中比待插入元素大的, 都向后挪动一个位置
     * 将待插入元素放到合适的位置
     */
    override func sortAction() {
        for i in 1..<dataArray.count {
            let searchIndex = dichotomySearch(index: i)
            let value = dataArray[i]
            
            for j in (searchIndex..<i).reversed() {
                dataArray[j + 1] = dataArray[j]
            }
            dataArray[searchIndex] = value
        }
    }
    
    
    /// 二分搜索, 根据索引搜索
    fileprivate func dichotomySearch(index: Int) -> Int {
        var begin = 0
        var end = index
        while begin < end {
            let mid = (begin + end) >> 1
            if cmp(e1: dataArray[index], e2: dataArray[mid]) < 0 {
                end = mid
            } else {
                // 查找到最后面的相等的索引
                begin = mid + 1
            }
        }
        return begin
    }
    
    
    /// 二分搜索, 根据值搜索
    fileprivate func dichotomySearch(value: T) -> Int {
        if dataArray.count == 0 { return -1 }
        var begin = 0
        var end = dataArray.count
        while begin < end {
            let mid = (begin + end) >> 1
            let compare = cmp(e1: value, e2: dataArray[mid])
            if compare > 0 {
                begin = mid + 1
            } else if compare < 0 {
                end = mid
            } else {
                return mid
            }
        }
        return -1
    }
}
