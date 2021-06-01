//
//  BinaryTree.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/5/7.
//

import Cocoa

class BinaryTree {

    /// 元素数量
    var count = 0
    /// 根节点
    var root: TreeNode?
    
    /// 是否为空
    func isEmpty() -> Bool {
        return count == 0
    }
    
    /// 节点是否存在
    func contains(_ element: Int) -> Bool {
        return getNode(element) != nil
    }
    
    /// 清除所有节点
    func clear() {
        root = nil
        count = 0
    }
    
    /// 添加节点
    func add(_ element: Int) {
        if root == nil {
            let node = TreeNode(element)
            root = node
            count += 1
            
            // 添加之后调整节点
            afterAdd(node)
            return
        }
        
        var node = root
        var parent = root
        var compare = 0
        while node != nil {
            parent = node
            if let tmp = node?.val {
                if tmp > element {
                    node = node?.left
                    compare = 1
                } else if tmp < element {
                    node = node?.right
                    compare = 2
                } else {
                    node?.val = element
                    return
                }
            } else {
                return
            }
        }
        
        let current = TreeNode(element, parent: parent)
        if compare == 1 {
            parent?.left = current
        } else {
            parent?.right = current
        }
        count += 1
        
        // 添加之后调整节点
        afterAdd(current)
    }
    
    /// 删除节点
    func remove(_ val: Int) {
        if let node = getNode(val) {
            remove(node)
        }
    }
    
    /// 获取当前节点的前序节点
    func frontNode(_ node: TreeNode?) -> TreeNode? {
        if node == nil || node?.left == nil { return nil }
        var tmpNode = node?.left
        while tmpNode?.right != nil {
            tmpNode = tmpNode?.right
        }
        return tmpNode
    }
    
    /// 获取当前节点的后序节点
    func behindRoot(_ node: TreeNode?) -> TreeNode? {
        if node == nil || node?.right == nil { return nil }
        var tmpNode = node?.right
        while tmpNode?.left != nil {
            tmpNode = tmpNode?.left
        }
        return tmpNode
    }
    
    
    //MARK: 需要呗子类重写
    /// 添加node之后的调整节点
    func afterAdd(_ node: TreeNode) {}
    
    /// 删除node之后的调整节点
    func afterRemove(_ node: TreeNode) {}
}

extension BinaryTree {
    /// 查找对应node
    func getNode(_ element: Int) -> TreeNode? {
        var node = root
        
        while node != nil {
            if let tmp = node?.val {
                if tmp > element {
                    node = node?.left
                } else if tmp < element {
                    node = node?.right
                } else {
                    return node
                }
            } else {
                return node
            }
        }
        
        return node
    }
    
    /// 前序遍历(迭代)
    func preorderForEach() -> [Int] {
        if root == nil { return [] }
        var node = root
        var array = [Int]()
        
        let stack = Statck<TreeNode>()
        stack.push(node)
        
        while !stack.isEmpty() {
            node = stack.pop()
            if let tmp = node?.val {
                array.append(tmp)
            }
            
            if let right = node?.right {
                stack.push(right)
            }
            if let left = node?.left {
                stack.push(left)
            }
        }
        
        return array
    }
    
    /// 中序遍历(迭代)
    func infixOrderForEach() -> [Int] {
        if root == nil { return [] }
        var node = root
        var array = [Int]()
        
        let stack = Statck<TreeNode>()
        while !stack.isEmpty() || node != nil {
            while node != nil {
                stack.push(node)
                node = node?.left
            }
            
            let peek = stack.pop()
            if let element = peek?.val {
                array.append(element)
            }
            node = peek?.right
        }
        
        return array
    }
    
    /// 后序遍历(迭代)
    func epilogueForEach() -> [Int] {
        if root == nil { return [] }
        var node = root
        var array = [Int]()
        var tmpNode: TreeNode?
        
        let stack = Statck<TreeNode>()
        stack.push(node)
        
        while !stack.isEmpty() {
            let peek = stack.peek()
            let isLeaf = peek?.isLeaf() ?? false
            
            // 栈顶节点是否是椰子节点, 上一次访问节点是否是栈顶节点的子节点
            if isLeaf || tmpNode?.parent == peek {
                node = stack.pop()
                tmpNode = node
                if let tmp = node?.val {
                    array.append(tmp)
                }
            } else {
                node = peek
                if let right = node?.right {
                    stack.push(right)
                }
                if let left = node?.left {
                    stack.push(left)
                }
            }
        }
        
        return array
    }
    
    /// 层序遍历
    func levelOrderForEach() -> [Int] {
        var node = root
        if node == nil { return [] }
        var array = [Int]()
        
        let queueLink = SingleQueue<TreeNode>()
        queueLink.enQueue(node)
        while !queueLink.isEmpty() {
            node = queueLink.deQueue()
            if let element = node?.val {
                array.append(element)
            }
            if let left = node?.left {
                queueLink.enQueue(left)
            }
            if let right = node?.right {
                queueLink.enQueue(right)
            }
        }
        
        return array
    }
}
 
extension BinaryTree {
    /// 删除对应的node
    fileprivate func remove(_ node: TreeNode) {
        count -= 1
        
        var tmpNode = node
        if tmpNode.twoChildren() {
            // 找后继结点
            if let front = behindRoot(tmpNode) {
                // 值覆盖
                tmpNode.val = front.val
                // 删除前寄结点
                tmpNode = front
            }
        }
        
        // 删除节点(节点的度肯定是1或者0)
        let replacement = tmpNode.left != nil ? tmpNode.left : tmpNode.right
        if replacement != nil { // 度为1的节点
            replacement?.parent = tmpNode.parent
            if tmpNode == tmpNode.parent?.left {
                tmpNode.parent?.left = replacement
            } else if tmpNode == tmpNode.parent?.right {
                tmpNode.parent?.right = replacement
            } else {
                root = tmpNode
            }
            
            // 平衡节点
            if let reNode = replacement {
                afterRemove(reNode)
            }
        } else if tmpNode.parent == nil {
            root = nil
            
            // 平衡节点
            afterRemove(tmpNode)
        } else { // 叶子节点
            if tmpNode == tmpNode.parent?.left {
                tmpNode.parent?.left = nil
            } else {
                tmpNode.parent?.right = nil
            }
            
            // 平衡节点
            afterRemove(tmpNode)
        }
    }
}

extension BinaryTree: BinaryTreeProtocol {
    func getRoot() -> Any? {
        return root as Any
    }
    
    func left(node: Any?) -> Any? {
        if let n = node as? TreeNode {
            return n.left as Any
        }
        return NSObject()
    }
    
    func right(node: Any?) -> Any? {
        if let n = node as? TreeNode {
            return n.right as Any
        }
        return NSObject()
    }
    
    func string(node: Any?) -> String {
        if let n = node as? TreeNode {
            if let parent = n.parent {
                let color = n.isRed ? "r" : "b"
                return "\(n.val)_p\(parent.val)_\(color)"
            }
            return "\(n.val)"
        }
        return "-"
    }
}
