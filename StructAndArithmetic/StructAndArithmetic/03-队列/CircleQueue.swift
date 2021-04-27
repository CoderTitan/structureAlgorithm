//
//  CircleQueue.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/15.
//

import Cocoa

class CircleQueue<E: Comparable> {

    fileprivate var elements = [E?]()
    fileprivate var front = 0
    fileprivate var count = 0
    
    
    required init() {
        for _ in 0..<Statical.capacity {
            elements.append(nil)
        }
    }
    
    
    /// 元素数量
    func size() -> Int {
        return count
    }
    
    /// 是否为空
    func isEmpty() -> Bool {
        return count == 0
    }
    
    /// 清除所有元素
    func clear() {
        for i in 0..<elements.count {
            elements[i] = nil
        }
        count = 0
    }
    
    /// 入队
    func enQueue(_ element: E) {
        ensureCapacity(count + 1)
        
        let index = getIndex(count)
        elements[index] = element
        count += 1
    }

    /// 出队
    func deQueue() -> E? {
        let element = elements[front]
        elements[front] = nil
        
        front = getIndex(1)
        count -= 1
        cutCapacity()
        return element
    }

    /// 获取队列的头元素
    func header() -> E? {
        return elements[front]
    }
    
    func toString() -> String {
        var text = "count = \(count), ["
        for i in 0..<elements.count {
            if i != 0 {
                text += ", "
            }
            if let e = elements[i] {
                text += "\(e)"
            } else {
                text += "nil"
            }
        }
        text += "]"
        return text
    }
}


extension CircleQueue {
    /// 数组扩容
    fileprivate func ensureCapacity(_ capacity: Int) {
        let oldCapacity = elements.count
        if capacity <= oldCapacity { return }
        let newCapacity = oldCapacity + oldCapacity >> 1
        
        var newElements = [E?]()
        for _ in 0..<newCapacity {
            newElements.append(nil)
        }
        for i in 0..<count {
            let index = getIndex(i)
            newElements[i] = elements[index]
        }
        elements = newElements
        front = 0
    }
    
    /// 数组缩容
    fileprivate func cutCapacity() {
        let oldCapacity = elements.count
        let newCapacity = oldCapacity >> 1
        if count < newCapacity {
            var newElements = [E?]()
            for _ in 0..<newCapacity {
                newElements.append(nil)
            }
            for i in 0..<count {
                let index = getIndex(i)
                newElements[i] = elements[index]
            }
            elements = newElements
            front = 0
        }
    }
    
    /// 获取当前索引所在数组的真正索引
    fileprivate func getIndex(_ index: Int) -> Int {
        let newIndex = index + front
        let length = elements.count
        return newIndex >= length ? newIndex - length : newIndex
    }
}
