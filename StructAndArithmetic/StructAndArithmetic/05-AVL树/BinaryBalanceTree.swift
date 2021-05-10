//
//  BinaryBalanceTree.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/5/7.
//

import Cocoa

class BinaryBalanceTree: BinaryTree {
    
    /// 左旋转
    func rotateLeft(_ grand: TreeNode) {
        guard let pNode = grand.right else { return }
        let child = pNode.left
        grand.right = child
        pNode.left = grand
        afterRorate(grand, pNode: pNode, child: child)
    }
    
    /// 右旋转
    func rotateRight(_ grand: TreeNode) {
        guard let pNode = grand.left else { return }
        let child = pNode.right
        grand.left = child
        pNode.right = grand
        afterRorate(grand, pNode: pNode, child: child)
    }
    
    /// 旋转
    func afterRorate(_ grand: TreeNode, pNode: TreeNode, child: TreeNode?) {
        // 设置根节点
        pNode.parent = grand.parent
        if grand.isLeftChild() {
            grand.parent?.left = pNode
        } else if grand.isRightChild() {
            grand.parent?.right = pNode
        } else {
            root = pNode
        }
        
        // 设置父节点
        child?.parent = grand
        grand.parent = pNode
    }
    
    /// 平衡旋转
    func rotate(r: TreeNode,
                          b: TreeNode?, c: TreeNode?,
                          d: TreeNode,
                          e: TreeNode?, f: TreeNode?) {
        // 设置d为根节点
        d.parent = r.parent
        if r.isLeftChild() {
          r.parent?.left = d
        } else if r.isRightChild() {
          r.parent?.right = d
        } else {
          root = d
        }

        // 设置b, c
        b?.right = c
        c?.parent = b

        // 设置e, f
        f?.left = e
        e?.parent = f

        // 设置b, d, f
        d.left = b
        d.right = f
        b?.parent = d
        f?.parent = d
    }
}


