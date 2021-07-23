//
//  HashSet.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/7/21.
//

import Cocoa

class HashSet<E: Hashable & Comparable>: Set<E> {

    fileprivate let map = HashMap<E, E>()
    
    /// 元素个数
    override func size() -> Int {
        return map.count()
    }
    
    /// 是否为空
    override func isEmpty() -> Bool {
        return map.isEmpty()
    }
    
    /// 清除所有元素
    override func clear() {
        map.clear()
    }
    
    /// 是否包含某元素
    override func contains(_ val: E) -> Bool {
        return map.containsKey(key: val)
    }
    
    /// 添加元素
    override func add(val: E) {
        map.put(key: val, val: nil)
    }
    
    /// 删除元素
    @discardableResult
    override func remove(val: E) -> E? {
        return map.remove(key: val)
    }
    
    /// 获取所有元素
    override func lists() -> [E] {
        var array = [E]()
        map.traversal { val, _ in
            if let v = val {
                array.append(v)
            }
        }
        return array
    }
}
