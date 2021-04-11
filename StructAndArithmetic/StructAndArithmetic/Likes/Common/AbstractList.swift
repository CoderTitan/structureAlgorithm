//
//  AbstractList.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/8.
//

import Cocoa

class AbstractList<E: Equatable>: List<E> {

    /**
     * 元素的数量
     */
    var count = 0
    
    /**
     * 元素的数量
     * @return
     */
    override func size() -> Int {
        return count
    }
    
    /**
     * 是否为空
     * @return
     */
    override func isEmpty() -> Bool {
        return count == 0
    }
    
    /**
     * 是否包含某个元素
     * @param element
     * @return
     */
    override func contains(_ element: E) -> Bool {
        return indexOf(element) != -1
    }

    /**
     * 添加元素到尾部
     * @param element
     */
    override func add(_ element: E) {
        add(by: count, element: element)
    }

    
    /// 数组越界处理
    func outOfBouns(_ index: Int) {
        print("数组越界: index = \(index), count = \(count)")
    }
    
    /// 获取元素判断是否越界
    func rangeCheck(_ index: Int) -> Bool {
        if index < 0 || index >= count {
            outOfBouns(index)
            return true
        }
        return false
    }
    
    /// 添加元素判断越界
    func rangeCheckForAdd(_ index: Int) -> Bool  {
        if index < 0 || index > count {
            outOfBouns(index)
            return true
        }
        return false
    }
}
