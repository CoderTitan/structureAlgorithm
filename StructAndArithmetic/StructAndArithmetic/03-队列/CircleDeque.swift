//
//  CircleDeque.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/15.
//

import Cocoa

class CircleDeque<E: Comparable> {

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
    
    /**
     *[0, nil, nil, nil, nil, nil, nil, nil, nil, nil]
     *[0, nil, nil, nil, nil, nil, nil, nil, nil, 1]
     */
    /// 从队头入队
    func enQueueHeader(_ element: E) {
        addCapacity(count + 1)
        
        front = getIndex(-1)
        elements[front] = element
        count += 1
    }
    
    /// 从队头出队
    func deQueueHeader() -> E? {
        let element = elements[front]
        elements[front] = nil
        
        front = getIndex(1)
        count -= 1
        cutCapacity()
        
        return element
    }
    
    /// 从队尾入队
    func enQueueTail(_ element: E) {
        addCapacity(count + 1)
        
        let index = getIndex(count)
        elements[index] = element
        count += 1
    }
    
    /// 从队尾出队
    func deQueueTail() -> E? {
        let index = front + count - 1
        let element = elements[index]
        elements[index] = nil
        
        count -= 1
        cutCapacity()
        
        return element
    }
    
    /// 获取队列的头元素
    func header() -> E? {
        return elements[front]
    }
    
    /// 获取队列的尾元素
    func tail() -> E? {
        let index = front + count - 1
        return elements[index]
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


extension CircleDeque {
    /// 数组扩容
    fileprivate func addCapacity(_ capacity: Int) {
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
        var newIndex = index + front
        let length = elements.count
        if newIndex < 0 {
            newIndex = newIndex + length
        }
        return newIndex >= length ? newIndex - length : newIndex
    }
}

