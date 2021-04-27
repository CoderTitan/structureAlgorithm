//
//  SingleDeque.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/15.
//

import Cocoa

/// 双端队列
class SingleDeque<E: Comparable> {
    
    fileprivate var list = DoubleLinkList<E>()
    
    /// 元素数量
    func size() -> Int {
        return list.count
    }
    
    /// 是否为空
    func isEmpty() -> Bool {
        return list.count == 0
    }
    
    /// 清除所有元素
    func clear() {
        list.clear()
    }
    
    /// 从队头入队
    func enQueueHeader(_ element: E) {
        list.add(by: 0, element: element)
    }
    
    /// 从队头出队
    func deQueueHeader() -> E? {
        return list.remove(0)
    }
    
    /// 从队尾入队
    func enQueueTail(_ element: E) {
        list.add(element)
    }
    
    /// 从队尾出队
    func deQueueTail() -> E? {
        return list.remove(list.count - 1)
    }
    
    /// 获取队列的头元素
    func header() -> E? {
        return list.get(0)
    }
    
    /// 获取队列的尾元素
    func tail() -> E? {
        return list.get(list.count - 1)
    }
}
