//
//  RedBlackTree.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/5/7.
//

import Cocoa

class RedBlackTree: BinaryBalanceTree {
    
    /// 添加node之后的调整节点
    override func afterAdd(_ node: TreeNode) {
        guard let parent = node.parent else {
            // 添加的是跟节点或者上益到了跟节点
            node.isRed = false
            return
        }
        
        // 如果父节点是黑色
        if parent.isRed == false { return }
        
        // 叔父节点
        let sibNode = parent.sibling()
        // 祖父节点
        let grand = parent.parent
        // 祖父节点置红
        grand?.isRed = true
        
        // 叔父节点是否为红
        if sibNode?.isRed == true {
            sibNode?.isRed = false
            parent.isRed = false
            
            // 吧祖父节点当成新添加节点处理
            if let node = grand {
                afterAdd(node)
            }
            return
        }
        
        // 叔父节点不是红色
        if parent.isLeftChild() { // L
            if node.isLeftChild() { // LL
                parent.isRed = false
            } else { // LR
                node.isRed = false
                rotateLeft(parent)
            }
            if let node = grand {
                rotateRight(node)
            }
        } else { // R
            if node.isLeftChild() { // RL
                node.isRed = false
                rotateRight(parent)
            } else { // RR
                parent.isRed = false
            }
            if let node = grand {
                rotateLeft(node)
            }
        }
    }
    
    
    /// 删除node之后的调整节点
    override func afterRemove(_ node: TreeNode) {
        // 删除的节点是红色
        // 或者, 用以取代node的节点的子节点是红色
        if node.isRed {
            node.isRed = false
            return
        }
        
        // 如果是根节点
        guard let parent = node.parent else { return }
        
        // 删除的是黑色节点
        // 判断被删除的节点是做还是右
        let isLeft = parent.left == nil || node.isLeftChild()
        // 兄弟节点
        var brother = isLeft ? parent.right : parent.left

        if isLeft {//被删除的节点在左边
            // 兄弟节点是红色
            if brother?.isRed == true {
                brother?.isRed = false
                parent.isRed = true
                rotateLeft(parent)
                // 重置兄弟节点
                brother = parent.right
            }
            
            // 兄弟节点必然是黑色
            if brother?.left?.isRed != true && brother?.right?.isRed != true {
                // 兄弟节点没有红色子节点, 父节点要下溢和子节点合并
                let parentRed = parent.isRed
                parent.isRed = false
                brother?.isRed = true
                if !parentRed {
                    afterRemove(parent)
                }
            } else { // 兄弟节点至少有一个红色子节点
                if let node = brother {
                    if node.right?.isRed == true {
                        rotateRight(node)
                        brother = parent.right
                    }
                }
                
                brother?.isRed = parent.isRed
                parent.isRed = false
                brother?.right?.isRed = false
                rotateLeft(parent)
            }
        } else { // 被删除的节点在右边
            // 兄弟节点是红色
            if brother?.isRed == true {
                brother?.isRed = false
                parent.isRed = true
                rotateRight(parent)
                // 重置兄弟节点
                brother = parent.left
            }
            
            // 兄弟节点必然是黑色
            if brother?.left?.isRed != true && brother?.right?.isRed != true {
                // 兄弟节点没有红色子节点, 父节点要下溢和子节点合并
                let parentRed = parent.isRed
                parent.isRed = false
                brother?.isRed = true
                if !parentRed {
                    afterRemove(parent)
                }
            } else { // 兄弟节点至少有一个红色子节点
                if let node = brother {
                    if node.left?.isRed == true {
                        rotateLeft(node)
                        brother = parent.left
                    }
                }
                
                brother?.isRed = parent.isRed
                parent.isRed = false
                brother?.left?.isRed = false
                rotateRight(parent)
            }
        }
    }
}


