//
//  Node.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/19.
//

import Cocoa


class Node<E: Comparable>: Comparable {
    
    static func < (lhs: Node<E>, rhs: Node<E>) -> Bool {
        let lElement = lhs.element
        let rElement = rhs.element
        if lElement == nil && rElement == nil {
            return true
        } else if lElement == nil || rElement == nil {
            return false
        }
        return lElement! < rElement!
    }
    
    static func == (lhs: Node<E>, rhs: Node<E>) -> Bool {
        return lhs.element == rhs.element
    }
    

    var element: E?
    var left: Node?
    var right: Node?
    var parent: Node?
    
    init(element: E?, parent: Node? = nil) {
        
        self.element = element
        self.parent = parent
    }
    
    /// 是否是叶子节点
    func isLeaf() -> Bool {
        return left == nil && right == nil
    }
    
    /// 有两个节点
    func twoChildren() -> Bool {
        return left != nil && right != nil
    }
}
