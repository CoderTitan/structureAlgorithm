//
//  SingleLinkList.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/7.
//

import Cocoa

class SingleLinkList<E: Equatable>: AbstractList<E> {

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
        
        if index == 0 {
            first = ListNode(element: element, next: first)
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
            first = node?.next
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

extension SingleLinkList {
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


// MARK: 练习题
extension SingleLinkList {
    /// 反转一个链表(迭代方式)
    func reverseLinkedListDie(header: ListNode<E>?) -> ListNode<E>? {
        if header == nil || header?.next == nil {
            return header
        }
        let newHeader = reverseLinkedListDie(header: header?.next)
        header?.next?.next = header
        header?.next = nil
        return newHeader
    }
    
    /// 反转一个链表(递归方式)
    func reverseLinkedList(header: ListNode<E>?) -> ListNode<E>? {
        var tmpHeader = header
        var newHeader: ListNode<E>? = nil
        while tmpHeader != nil {
            let next = tmpHeader?.next
            next?.next = newHeader
            newHeader = tmpHeader
            tmpHeader = next
        }
        return newHeader
    }
    
    /// 判断一个链表是否有环
    func hasCycle(_ head: ListNode<E>?) -> Bool {
        var slow = head?.next
        var fast = head?.next?.next
        while fast != nil && fast?.next != nil {
            if slow == fast {
                return true
            }
            slow = slow?.next
            fast = fast?.next?.next
        }
        return false
    }
}

