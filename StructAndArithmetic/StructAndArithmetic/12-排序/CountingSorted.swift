//
//  CountingSorted.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/6/28.
//

import Cocoa

/// 计数排序
class CountingSorted<T: Comparable>: Sorted<T> {
    
    override func sortAction() {
        guard let intArray = dataArray as? [Int] else { return }
        // 最值
        var min = intArray[0]
        var max = intArray[0]
        for val in intArray {
            if val > max {
                max = val
            }
            if val < min {
                min = val
            }
        }
        
        // 开辟内存空间存储次数
        var counts = Array(repeating: 0, count: max - min + 1)
        // 统计每个整数出现的次数
        for val in intArray {
            var count = counts[val - min]
            count += 1
            counts[val - min] = count
        }
        // 累加次数
        for i in 1..<counts.count {
            var count = counts[i]
            count += counts[i - 1]
            counts[i] = count
        }
        
        // 从后往前遍历元素, 将它放到有序数组中的合适位置
        var newArray = Array(repeating: 0, count: intArray.count)
        for i in (0..<intArray.count - 1).reversed() {
            var count = counts[intArray[i] - min]
            count -= 1
            newArray[count] = intArray[i]
        }
        
        // 将有序数组复制到array
        for i in 0..<newArray.count {
            if let item = newArray[i] as? T {
                dataArray[i] = item
            }
        }
    }
}
