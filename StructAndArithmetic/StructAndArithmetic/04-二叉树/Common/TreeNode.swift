//
//  TreeNode.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/29.
//

import Cocoa


class TreeNode: Comparable {
    public var val: Int
    public var isRed = true
    public var left: TreeNode?
    public var right: TreeNode?
    public var parent: TreeNode?
    public var children: [TreeNode]
    public var height = 1
    
    
    public init(_ val: Int, left: TreeNode? = nil, right: TreeNode? = nil, parent: TreeNode? = nil) {
        self.val = val
        self.left = left
        self.right = right
        self.parent = parent
        self.children = []
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
    func sibling() -> TreeNode? {
        if isLeftChild() {
            return parent?.right
        }
        if isRightChild() {
            return parent?.left
        }
        return nil
    }
    
    /// 平衡因子
    func balanceFactor() -> Int {
        let leftHeight = left == nil ? 0 : left?.height ?? 0
        let rightHeight = right == nil ? 0 : right?.height ?? 0
        return leftHeight - rightHeight
    }
    
    /// 更新平衡因子
    func updateBalanceFactor() {
        let leftHeight = left == nil ? 0 : left?.height ?? 0
        let rightHeight = right == nil ? 0 : right?.height ?? 0
        height = max(leftHeight, rightHeight) + 1
    }
    
    /// 获取高度大的节点
    func tallerChild() -> TreeNode? {
        let leftHeight = left == nil ? 0 : left?.height ?? 0
        let rightHeight = right == nil ? 0 : right?.height ?? 0
        if leftHeight > rightHeight { return left }
        if rightHeight > leftHeight { return right }
        if parent != nil && parent?.left == left {
            return left
        }
        return right
    }
    
    
    static func < (lhs: TreeNode, rhs: TreeNode) -> Bool {
        let lElement = lhs.val
        let rElement = rhs.val
        return lElement < rElement
    }
    
    static func == (lhs: TreeNode, rhs: TreeNode) -> Bool {
        return lhs.val == rhs.val
    }
}


