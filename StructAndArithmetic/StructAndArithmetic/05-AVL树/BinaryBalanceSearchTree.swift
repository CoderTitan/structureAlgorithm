//
//  BinaryBalanceSearchTree.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/29.
//

import Cocoa

/// 二叉平衡搜索树
class BinaryBalanceSearchTree: BinaryBalanceTree {
    /// 添加node之后的调整节点
    override func afterAdd(_ node: TreeNode) {
        var tmpNode = node.parent
        while tmpNode != nil {
            guard let currentNode = tmpNode else { break }
            if isBalanceNode(currentNode) {
                // 更新节点高度
                updateHeight(currentNode)
            } else {
                // 需要平衡节点
                recoverBalance(currentNode)
                break
            }
            tmpNode = currentNode.parent
        }
    }
    
    /// 删除node之后的调整节点
    override func afterRemove(_ node: TreeNode) {
        var tmpNode = node.parent
        while tmpNode != nil {
            guard let currentNode = tmpNode else { break }
            if isBalanceNode(currentNode) {
                // 更新节点高度
                updateHeight(currentNode)
            } else {
                // 需要平衡节点
                recoverBalance(currentNode)
            }
            tmpNode = currentNode.parent
        }
    }
    
    /// 旋转
    override func afterRorate(_ grand: TreeNode, pNode: TreeNode, child: TreeNode?) {
        super.afterRorate(grand, pNode: pNode, child: child)
        
        // 更新高度
        updateHeight(pNode)
        updateHeight(grand)
    }
    
    /// 平衡旋转
    override func rotate(r: TreeNode, b: TreeNode?, c: TreeNode?, d: TreeNode, e: TreeNode?, f: TreeNode?) {
        super.rotate(r: r, b: b, c: c, d: d, e: e, f: f)
        
        // 更新高度
        if let node = f {
            updateHeight(node)
        }
        if let node = b {
            updateHeight(node)
        }
        updateHeight(d)
    }
}

extension BinaryBalanceSearchTree {
    /// 恢复平衡(统一处理)
    fileprivate func rotateBalance(_ grand: TreeNode) {
        guard let pNode = grand.tallerChild() else { return }
        guard let nNode = pNode.tallerChild() else { return }
        
        if pNode.isLeftChild() { // L
            if nNode.isLeftChild() { // L
                rotate(r: grand, b: nNode, c: nNode.right, d: pNode, e: pNode.right, f: grand)
            } else { // R
                // LR: 先右旋在左旋
                rotate(r: grand, b: pNode, c: nNode.left, d: nNode, e: nNode.right, f: grand)
            }
        } else { // R
            if nNode.isLeftChild() { // L
                // RL 先左旋在右旋
                rotate(r: grand, b: grand, c: nNode.left, d: nNode, e: nNode.right, f: pNode)
            } else { // R
                // RR: 左旋
                rotate(r: grand, b: grand, c: pNode.left, d: pNode, e: nNode.left, f: nNode)
            }
        }
    }
    
    /// 恢复平衡(左右旋转单独处理)
    fileprivate func recoverBalance(_ grand: TreeNode) {
        guard let pNode = grand.tallerChild() else { return }
        guard let nNode = pNode.tallerChild() else { return }
        
        if pNode.isLeftChild() { // L
            if nNode.isLeftChild() { // L
                rotateRight(grand)
            } else { // R
                // LR: 先右旋在左旋
                rotateRight(grand)
                rotateLeft(grand)
            }
        } else { // R
            if nNode.isLeftChild() { // L
                // RL 先左旋在右旋
                rotateLeft(grand)
                rotateRight(grand)
            } else { // R
                // RR: 左旋
                rotateLeft(grand)
            }
        }
    }

    /// 当前节点是否是平衡的
    fileprivate func isBalanceNode(_ node: TreeNode) -> Bool {
        return abs(node.balanceFactor()) <= 1
    }
    
    /// 更新高度
    fileprivate func updateHeight(_ node: TreeNode) {
        node.updateBalanceFactor()
    }
}

