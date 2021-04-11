//
//  DoubleLinkList.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/8.
//

import Cocoa

class DoubleLinkList<E: Equatable>: AbstractList<E> {

    fileprivate var first: ListNode<E>?
    fileprivate var last: ListNode<E>?
    
    
    /**
     * 清除所有元素
     */
    override func clear() {
        var node = first
        for _ in 0..<count {
            node = node?.next
            node?.prev = nil
        }
        
        first = nil
        last = nil
        count = 0
    }
    
    /**
     * 获取index位置的元素
     * @param index
     * @return
     */
    override func get(index: Int) -> E? {
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
        
        if index == count {
            let oldLast = last
            last = ListNode(element: element, next: nil, prev: oldLast)
            if oldLast == nil {
                first = last
            } else {
                oldLast?.next = last
            }
        } else {
            let current = getNode(index)
            let befer = current?.prev
            let node = ListNode(element: element, next: current, prev: befer)
            
            current?.prev = node
            if befer == nil {
                first = node
            } else {
                befer?.next = node
            }
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
        
        let current = getNode(index)
        let befer = current?.prev
        let after = current?.next
        
        if befer == nil {
            first = after
        } else {
            befer?.next = after
        }
        
        if after == nil {
            last = befer
        } else {
            after?.prev = befer
        }
        count -= 1
        return current?.element
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
                return elementNotFound
            }
            node = node?.next
        }
        return elementNotFound
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

extension DoubleLinkList {
    /// 获取index位置对应的节点对象
    fileprivate func getNode(_ index: Int) -> ListNode<E>? {
        if rangeCheck(index) {
            return nil
        }
        
        // 前半部分
        if index < count >> 1 {
            var node = first
            for _ in 0..<index {
                node = node?.next
            }
            return node
        }

        // 后半部分
        var node = last
        for _ in (index+1..<count).reversed() {
            node = node?.prev
        }
        return node
    }
}

