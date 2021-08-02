//
//  BinaryHeap.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/5/29.
//
// 二叉堆

import Cocoa


class BinaryHeap<E: Comparable>: AbstractHeap<E> {

    
    fileprivate var valueArray = [E]()
    
    init(vals: [E] = [], compare: ((E, E) -> Bool)? = nil) {
        super.init(compare: compare)
        
        if vals.count > 0 {
            vals.forEach({ valueArray.append($0) })
            heapify()
        }
    }

    
    func array() -> [E] {
        return valueArray
    }
    
    /// 元素的数量
    override func count() -> Int {
        return valueArray.count
    }
    
    /// 清空
    override func clear() {
        valueArray.removeAll()
    }
    
    /// 添加元素
    override func add(val: E) {
        valueArray.append(val)
        shiftUp(valueArray.count - 1)
    }
    
    /// 添加元素数组
    override func addAll(vals: [E]) {
        for val in vals {
            add(val: val)
        }
    }
    
    /// 获得堆顶元素
    override func top() -> E? {
        return valueArray.first
    }
    
    /// 删除堆顶元素
    @discardableResult
    override func remove() -> E? {
        let firstVal = valueArray.first
        if valueArray.count < 2 {
            return firstVal
        }
        
        // 吧最后一个元素放到第一个
        let lastVal = valueArray.removeLast()
        valueArray[0] = lastVal
        downUp(0)
        
        return firstVal
    }
    
    /// 删除堆顶元素的同时插入一个新元素
    @discardableResult
    override func replace(val: E) -> E? {
        var top: E? = nil
        if valueArray.count == 0 {
            valueArray.append(val)
        } else {
            top = valueArray.first
            valueArray[0] = val
            downUp(0)
        }
        return top
    }
}


extension BinaryHeap {
    /// 上滤
    fileprivate func shiftUp(_ index: Int) {
        var currentIndex = index
        let val = valueArray[currentIndex]
        
        // 是否还有父节点
        while currentIndex > 0 {
            // 父节点索引: floor((i - 1) / 2)
            let parentIndex = (currentIndex - 1) >> 1
            let parentVal = valueArray[parentIndex]
            
            if !compare(lhs: val, rhs: parentVal) { break }
            
            // 父节点放到currentIndex位置
            valueArray[currentIndex] = parentVal
            currentIndex = parentIndex
        }
        
        valueArray[currentIndex] = val
    }
    
    /// 下滤
    fileprivate func downUp(_ index: Int) {
        let value = valueArray[index]
        let half = valueArray.count >> 1
        var currentIndex = index
        
        // 是否还有父节点
        while currentIndex < half {
            // 左子节点索引
            var childIndex = currentIndex << 1 + 1
            var childVal = valueArray[childIndex]
            
            // 右子节点索引
            let rightIndex = childIndex + 1
            
            // 如果存在右子节点 >
            if rightIndex < valueArray.count && compare(lhs: valueArray[rightIndex], rhs: childVal) {
                childIndex = rightIndex
                childVal = valueArray[rightIndex]
            }
            
            // 比子节点都大
            if !compare(lhs: childVal, rhs: value) { break }
                
            valueArray[currentIndex] = childVal
            currentIndex = childIndex
        }
        
        valueArray[currentIndex] = value
    }
    
    /// 批量建堆
    fileprivate func heapify() {
//        // 自上而下的上滤
//        for i in 1..<valueArray.count {
//            shiftUp(i)
//        }
        
        // 自下而上的下滤
        let lastIndex = valueArray.count >> 1 - 1
        for i in (0...lastIndex).reversed() {
            downUp(i)
        }
    }
}


//MARK: 测试题
extension BinaryHeap {
    /// 找出数组中最大的前K个数
    func getMax(_ vals: [E], max: Int) -> [E] {
        if max >= vals.count { return vals }
        
        let heap = BinaryHeap(compare: <)
        for val in vals {
            if heap.count() < max {
                heap.add(val: val)
            } else if let top = heap.top(), top < val {
                heap.replace(val: val)
            }
        }
        
        return heap.array()
    }
}


extension BinaryHeap: BinaryTreeProtocol {
    func getRoot() -> Any? {
        return 0
    }
    
    func left(node: Any?) -> Any? {
        if let index = node as? Int {
            let childIndex = index << 1 + 1
            return childIndex < valueArray.count ? childIndex as Any : nil
        }
        return nil
    }
    
    func right(node: Any?) -> Any? {
        if let index = node as? Int {
            let childIndex = index << 1 + 2
            return childIndex < valueArray.count ? childIndex as Any : nil
        }
        return nil
    }
    
    func string(node: Any?) -> String {
        if let index = node as? Int, index < valueArray.count {
            return "\(valueArray[index])"
        }
        return "-"
    }
}
