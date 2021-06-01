//
//  TreeSet.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/5/11.
//

import Cocoa

class TreeSet<E: Comparable>: Set<E> {

    fileprivate var tree = RedBlackTree()
    
    /// 元素个数
    override func size() -> Int {
        return tree.count
    }
    
    /// 是否为空
    override func isEmpty() -> Bool {
        return tree.isEmpty()
    }
    
    /// 清除所有元素
    override func clear() {
        tree.clear()
    }
    
    /// 是否包含某元素
    override func contains(_ val: E) -> Bool {
        return tree.contains(val as? Int ?? 0)
    }
    
    /// 添加元素
    override func add(val: E) {
        tree.add(val as? Int ?? 0)
    }
    
    /// 删除元素
    override func remove(val: E) -> E? {
        return tree.remove(val as? Int ?? 0) as? E
    }
    
    /// 获取所有元素
    override func lists() -> [E] {
        let array = tree.infixOrderForEach()
        return array as? [E] ?? []
    }
}
