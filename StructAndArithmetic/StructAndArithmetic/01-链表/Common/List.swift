//
//  List.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/8.
//

import Cocoa


class List<E: Comparable> {
    
    /**
     * 清除所有元素
     */
    func clear() {}

    /**
     * 元素的数量
     * @return
     */
    func size() -> Int {
        return 0
    }

    /**
     * 是否为空
     * @return
     */
    func isEmpty() -> Bool {
        return true
    }

    /**
     * 是否包含某个元素
     * @param element
     * @return
     */
    func contains(_ element: E) -> Bool {
        return true
    }

    /**
     * 添加元素到尾部
     * @param element
     */
    func add(_ element: E) {}

    /**
     * 获取index位置的元素
     * @param index
     * @return
     */
    func get(_ index: Int) -> E? {
        return nil
    }

    /**
     * 替换index位置的元素
     * @param index
     * @param element
     * @return 原来的元素ֵ
     */
    func set(by index: Int, element: E) -> E? {
        return nil
    }

    /**
     * 在index位置插入一个元素
     * @param index
     * @param element
     */
    func add(by index: Int, element: E) {}

    /**
     * 删除index位置的元素
     * @param index
     * @return
     */
    func remove(_ index: Int) -> E? {
        return nil
    }

    /**
     * 查看元素的索引
     * @param element
     * @return
     */
    func indexOf(_ element: E) -> Int {
        return 0
    }
}
