//
//  AbstractHeap.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/5/29.
//

import Cocoa


class AbstractHeap<E: Comparable> {
    
    /// 比较
    var comparable: ((E, E) -> Bool)?
    
    
    init(compare: ((E, E) -> Bool)? = nil) {
        self.comparable = compare
    }
    
    
    
    /// 元素的数量
    func count() -> Int {
        return 0
    }
    
    /// 是否为空
    func isEmpty() -> Bool {
        return count() == 0
    }
    
    /// 清空
    func clear() { }
    
    /// 添加元素
    func add(val: E) { }
    
    /// 添加元素数组
    func addAll(vals: [E]) { }
    
    /// 获得堆顶元素
    func top() -> E? {
        return nil
    }
    
    /// 删除堆顶元素
    func remove() -> E? {
        return nil
    }
    
    /// 删除堆顶元素的同时插入一个新元素
    func replace(val: E) -> E? {
        return nil
    }
    
    func compare(lhs: E, rhs: E) -> Bool {
        if let com = comparable {
            return com(lhs, rhs)
        }
        return lhs > rhs
    }
}
