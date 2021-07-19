//
//  MergeSort.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/6/26.
//

import Cocoa

/// 归并排序
class MergeSort<T: Comparable>: Sorted<T> {

    fileprivate var leftArray = [T]()

    override func sortAction() {
        let mid = dataArray.count >> 1
        for i in 0..<mid {
            leftArray.append(dataArray[i])
        }
        sortRange(begin: 0, end: dataArray.count)
    }
    
    
    /**
     * 对 [begin, end) 范围的数据进行归并排序
     */
    fileprivate func sortRange(begin: Int, end: Int) {
        if end - begin < 2 { return }
        
        let mid = (begin + end) >> 1
        sortRange(begin: begin, end: mid)
        sortRange(begin: mid, end: end)
        mergeAction(begin: begin, mid: mid, end: end)
    }
    
    
    /**
     * 将 [begin, mid) 和 [mid, end) 范围的序列合并成一个有序序列
     */
    fileprivate func mergeAction(begin: Int, mid: Int, end: Int) {
        var li = 0
        var le = mid - begin
        var ri = mid
        var re = end
        
    }
}
