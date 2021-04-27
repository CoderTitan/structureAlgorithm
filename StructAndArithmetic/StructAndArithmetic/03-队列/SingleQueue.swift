//
//  SingleQueue.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/15.
//

import Cocoa

/// 单端队列
class SingleQueue<E: Comparable> {

    fileprivate var list = [E]()
    
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
        list.removeAll()
    }
    
    /// 入队
    func enQueue(_ element: E?) {
        if let tmp = element {
            list.append(tmp)
        }
    }
    
    /// 出队
    func deQueue() -> E? {
        var element: E?
        if list.count > 0 {
            element = list.removeFirst()
        }
        return element
    }
    
    /// 获取队列的头元素
    func front() -> E? {
        return list.first
    }
    
    func string() -> String {
        var text = "["
        for item in list {
            text += "\(item),"
        }
        if text.count > 1 {
            text = String(text.dropLast())
        }
        text += "]"
        return text
    }
}





class StackQueue<E: Comparable> {
    fileprivate var queue = SingleQueue<E>()
    fileprivate var last = SingleQueue<E>()
    
    

    /// 元素个数
    func size() -> Int {
        return queue.size()
    }
    
    /// 是否为空
    func isEmpty() -> Bool {
        return queue.isEmpty()
    }
    
    /// 入栈
    func push(_ element: E) {
        queue.enQueue(element)
    }
    
    /// 出栈
    @discardableResult
    func pop() -> E? {
        let tmpQueue = SingleQueue<E>()
        for _ in 0..<queue.size() - 1 {
            tmpQueue.enQueue(queue.deQueue()!)
        }
        let element = queue.deQueue()
        for _ in 0..<tmpQueue.size() {
            queue.enQueue(tmpQueue.deQueue()!)
        }
        return element
    }
    
    /// 获取栈顶元素
    func peek() -> E? {
        let tmpQueue = SingleQueue<E>()
        for _ in 0..<queue.size() - 1 {
            tmpQueue.enQueue(queue.deQueue()!)
        }
        let element = queue.front()
        for _ in 0..<tmpQueue.size() {
            queue.enQueue(tmpQueue.deQueue()!)
        }
        queue.enQueue(element!)
        return element
    }
    
    /// 清空
    func clear() {
        queue.clear()
    }
    
    func toString() -> String {
        let count = queue.size()
        var text = "count = \(count), ["
        for i in 0..<count {
            if i != 0 {
                text += ", "
            }
            if let e = queue.deQueue() {
                text += "\(e)"
            } else {
                text += "nil"
            }
        }
        text += "]"
        return text
    }
}
