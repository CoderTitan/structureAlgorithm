//
//  ListSet.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/5/11.
//

import Cocoa

class ListSet<E: Comparable>: Set<E> {

    fileprivate var list = DoubleLinkList<E>()
    
    /// 元素个数
    override func size() -> Int {
        return list.count
    }
    
    /// 是否为空
    override func isEmpty() -> Bool {
        return list.isEmpty()
    }
    
    /// 清除所有元素
    override func clear() {
        list.clear()
    }
    
    /// 是否包含某元素
    override func contains(_ val: E) -> Bool {
        return list.contains(val)
    }
    
    /// 添加元素
    override func add(val: E) {
        if !list.contains(val) {
            list.add(val)
        }
    }
    
    /// 删除元素
    override func remove(val: E) -> E? {
        let index = list.indexOf(val)
        if index > 0 {
            return list.remove(index)
        }
        return nil
    }
    
    /// 获取所有元素
    override func lists() -> [E] {
        var array = [E]()
        for i in 0..<size() {
            if let node = list.get(i) {
                array.append(node)
            }
        }
        return array
    }
}
