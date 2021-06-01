//
//  PriorityQueue.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/5/30.
//

import Cocoa

class PriorityQueue<E: Comparable> {

    fileprivate var heap = BinaryHeap<E>()
    
    init(compare: ((E, E) -> Bool)? = nil) {
        heap = BinaryHeap(compare: compare)
    }
    
    /// 元素的数量
    func count() -> Int {
        return heap.count()
    }
    
    /// 是否为空
    func isEmpty() -> Bool {
        return heap.isEmpty()
    }
    
    /// 清空
    func clear() {
        heap.clear()
    }
    
    /// 入队
    func enQueue(_ val: E) {
        heap.add(val: val)
    }
    
    /// 出队
    func deQueue(_ val: E) -> E? {
        return heap.remove()
    }

    /// 获取对顶元素
    func front() -> E? {
        return heap.top()
    }
}
