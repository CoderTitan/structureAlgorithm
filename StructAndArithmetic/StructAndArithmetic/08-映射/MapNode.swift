//
//  MapNode.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/5/12.
//

import Cocoa

class MapNode<K: Comparable, V: Comparable>: Comparable {
    public var key: K
    public var val: V?
    public var isRed = true

    public var parent: MapNode?
    public var left: MapNode?
    public var right: MapNode?
    public var height = 1
    
    
    public init(_ key: K, _ val: V?, parent: MapNode? = nil) {
        self.key = key
        self.val = val
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
    
    /// 当前节点是否是左节点
    func isLeftChild() -> Bool {
        return parent != nil && parent?.left == self
    }
    
    /// 当前节点是否是右节点
    func isRightChild() -> Bool {
        return parent != nil && parent?.right == self
    }
    
    /// 获取叔父节点
    func sibling() -> MapNode? {
        if isLeftChild() {
            return parent?.right
        }
        if isRightChild() {
            return parent?.left
        }
        return nil
    }
    
    
    static func < (lhs: MapNode, rhs: MapNode) -> Bool {
        let lElement = lhs.val
        let rElement = rhs.val
        
        if let lhsVal = lElement, let rhsVal = rElement {
            return lhsVal < rhsVal
        }
        return false
    }
    
    static func == (lhs: MapNode, rhs: MapNode) -> Bool {
        return lhs.val == rhs.val
    }
    
    
    func string() -> String {
        let v = val == nil ? "nil" : String(describing: val)
        return """
            {"\(key)": "\(v)"
        """
    }
}
