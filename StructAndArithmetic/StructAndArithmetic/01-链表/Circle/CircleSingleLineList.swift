//
//  CircleSingleLineList.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/10.
//

import Cocoa

/// 单向循环链表
class CircleSingleLineList<E: Comparable>: AbstractList<E> {
    
    fileprivate var first: ListNode<E>?
    
    /**
     * 清除所有元素
     */
    override func clear() {
        count = 0
        first = nil
    }
    
    /**
     * 获取index位置的元素
     * @param index
     * @return
     */
    override func get(_ index: Int) -> E? {
        let node = getNode(index)
        return node?.element
    }
    
    /**
     * 替换index位置的元素
     * @param index
     * @param element
     * @return 原来的元素ֵ
     */
    override func set(by index: Int, element: E) -> E? {
        if rangeCheck(index) {
            return nil
        }
        
        let current = getNode(index)
        let oldElement = current?.element
        current?.element = element
        return oldElement
    }
    
    /**
     * 在index位置插入一个元素
     * @param index
     * @param element
     */
    override func add(by index: Int, element: E) {
        if rangeCheckForAdd(index) {
            return
        }
        
        if index == 0 {
            let newFirst = ListNode(element: element, next: first)
            let last = count == 0 ? first : getNode(count - 1)
            last?.next = newFirst
            first = newFirst
        } else {
            let befer = getNode(index - 1)
            befer?.next = ListNode(element: element, next: befer?.next)
        }
        count += 1
    }
    
    /**
     * 删除index位置的元素
     * @param index
     * @return
     */
    override func remove(_ index: Int) -> E? {
        if rangeCheck(index) {
            return nil
        }
        
        var node = first
        if index == 0 {
            if count == 1 {
                first = nil
            } else {
                let last = count == 0 ? first : getNode(index - 1)
                first = node?.next
                last?.next = first
            }
        } else {
            let befer = getNode(index - 1)
            node = befer?.next
            befer?.next = befer?.next?.next
        }
        count -= 1
        return node?.element
    }
    
    /**
     * 查看元素的索引
     * @param element
     * @return
     */
    override func indexOf(_ element: E?) -> Int {
        var node = first
        for i in 0..<count {
            if node?.element == element {
                return i
            }
            if node?.next == nil {
                return Statical.notFound
            }
            node = node?.next
        }
        return Statical.notFound
    }
    
    
    func toString() -> String {
        var text = "count = \(count), ["
        var currentNode = first
        for i in 0..<count {
            if i != 0 {
                text += ", "
            }
            if let e = currentNode?.element {
                text += "\(e)"
            } else {
                text += "nil"
            }
            
            currentNode = currentNode?.next
        }
        text += "]"
        return text
    }
}

extension CircleSingleLineList {
    /// 获取index位置对应的节点对象
    fileprivate func getNode(_ index: Int) -> ListNode<E>? {
        if rangeCheck(index) {
            return nil
        }

        var node = first
        for _ in 0..<index {
            node = node?.next
        }
        return node
    }
}
