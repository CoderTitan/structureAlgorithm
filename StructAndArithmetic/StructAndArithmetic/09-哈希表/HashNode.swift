//
//  HashNode.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/5/15.
//

import Cocoa


class HashNode<K: NSObject, V: Comparable>: Comparable {
    public var key: K?
    public var val: V?
    public var isRed = true
    public var hash = 0

    public var parent: HashNode?
    public var left: HashNode?
    public var right: HashNode?
    
    
    public init(_ key: K?, _ val: V?, parent: HashNode? = nil) {
        self.key = key
        self.val = val
        self.parent = parent
        
        let h = key == nil ? 0 : key?.hashValue ?? 0
        hash = h ^ (h >> 32)
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
    func sibling() -> HashNode? {
        if isLeftChild() {
            return parent?.right
        }
        if isRightChild() {
            return parent?.left
        }
        return nil
    }
    
    
    static func < (lhs: HashNode, rhs: HashNode) -> Bool {
        let lElement = lhs.val
        let rElement = rhs.val

        if let lhsVal = lElement, let rhsVal = rElement {
            return lhsVal < rhsVal
        }
        return false
    }

    static func == (lhs: HashNode, rhs: HashNode) -> Bool {
        return lhs.val == rhs.val
    }

    
    func string() -> String {
        let v = val == nil ? "nil" : String(describing: val)
        return """
            {"\(1)": "\(v)"
        """
    }
}
