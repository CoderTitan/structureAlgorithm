//
//  Set.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/5/11.
//

import Cocoa

class Set<E: Comparable & Hashable> {

    /// 元素个数
    func size() -> Int {
        return 0
    }
    
    /// 是否为空
    func isEmpty() -> Bool {
        return size() == 0
    }
    
    /// 清除所有元素
    func clear() {}
    
    /// 是否包含某元素
    func contains(_ val: E) -> Bool {
        return true
    }
    
    /// 添加元素
    func add(val: E) {}
    
    /// 删除元素
    @discardableResult
    func remove(val: E) -> E? {
        return nil
    }
    
    /// 获取所有元素
    func lists() -> [E] {
        return []
    }
}
