//
//  BinaryTreeTest.swift
//  
//
//  Created by zl on 2021/4/26.
//

import Cocoa

class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public var children: [TreeNode]
    
    
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
        self.children = []
    }
}


class BinaryTreeTest {

    /// 中序遍历
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        if root == nil { return [] }
        var node = root
        var array = [Int]()
        var stack = [TreeNode?]()
        
        while !stack.isEmpty || node != nil {
            while node != nil {
                stack.append(node)
                node = node?.left
            }
            
            node = stack.removeLast()
            if let element = node?.val {
                array.append(element)
            }
            node = node?.right
        }
        return array
    }
    
    func invertTree(_ root: TreeNode?) -> [[Int]] {
        if root == nil { return [] }
        
        var leverCount = 1
        var elementArr = [Int]()
        var node = root
        
        var stack = [[Int]]()
        var queueLink = [TreeNode?]()
        queueLink.append(node)
        
        while !queueLink.isEmpty {
            leverCount -= 1
            
            node = queueLink.removeFirst()
            if let element = node?.val {
                elementArr.append(element)
            }
            
            if node?.left != nil {
                queueLink.append(node?.left)
            }
            if node?.right != nil {
                queueLink.append(node?.right)
            }
            
            if leverCount == 0 {
                stack.append(elementArr)
                leverCount = queueLink.count
                elementArr.removeAll()
            }
        }
        
        var array = [[Int]]()
        for _ in 0..<stack.count {
            let element = stack.removeLast()
            array.append(element)
        }
        return array
    }
    
    /// 计算二叉树的高度
    func treeHeight(_ root: TreeNode?) -> Int {
        if root == nil { return 0 }
        var node = root
        // 高度
        var height = 0
        // 每一层的个数
        var leverCount = 1
        
        var queueLink = [TreeNode?]()
        queueLink.append(node)
        
        while !queueLink.isEmpty {
            node = queueLink.removeFirst()
            leverCount -= 1
            
            if node?.left != nil {
                queueLink.append(node?.left)
            }
            if node?.right != nil {
                queueLink.append(node?.right)
            }
            
            if leverCount == 0 {
                leverCount = queueLink.count
                height += 1
            }
        }
        
        return height
    }
    
    /// 给定一个 N 叉树，返回其节点值的 前序遍历 。
    func preorder(_ root: TreeNode?) -> [Int] {
        if root == nil { return [] }
        var node = root
        var array = [Int]()
        
        var stack = [TreeNode?]()
        stack.append(node)
        
        while !stack.isEmpty {
            node = stack.removeLast()
            if let tmp = node?.val {
                array.insert(tmp, at: 0)
            }
            
            if let children = node?.children {
                for item in children {
                    stack.append(item)
                }
            }
            
        }
        
        return array
    }
    
    
    func maxDepth(_ root: TreeNode?) -> Int {
        if root == nil { return 0 }
        var node = root
        // 高度
        var height = 0
        // 每一层的个数
        var leverCount = 1
        
        var queueLink = [TreeNode?]()
        queueLink.append(node)
        
        while !queueLink.isEmpty {
            node = queueLink.removeFirst()
            leverCount -= 1
            
            if let children = node?.children {
                for item in children {
                    queueLink.append(item)
                }
            }
            
            if leverCount == 0 {
                leverCount = queueLink.count
                height += 1
            }
        }
        
        return height
    }

    /// 给定一个二叉搜索树的根节点 root ，和一个整数 k ，请你设计一个算法查找其中第 k 个最小元素（从 1 开始计数）
    func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        if root == nil { return -1 }
        
        var node = root
        var currentIndex = 0
        
        // 栈操作
        var stackList = [TreeNode?]()
        while !stackList.isEmpty || node != nil {
            while node != nil {
                stackList.append(node)
                node = node?.left
            }
            
            let current = stackList.removeLast()
            currentIndex += 1
            if currentIndex == k {
                return current?.val ?? -1
            }
            node = current?.right
        }
        return -1
    }
    
    /// 给定一个二叉搜索树, 找到该树中两个指定节点的最近公共祖先
    func lowestCommonAncestor(_ root: TreeNode?, _ p: TreeNode?, _ q: TreeNode?) -> TreeNode? {
        if root == nil { return nil }
        let rootValue = root?.val ?? -1
        let pValue = p?.val ?? -1
        let qValue = q?.val ?? -1
        
        if rootValue < pValue && rootValue < qValue {
            return lowestCommonAncestor(root?.right, p, q)
        }
        if rootValue > pValue && rootValue > qValue {
            return lowestCommonAncestor(root?.left, p, q)
        }
        
        return root
    }
    
    func rangeSumBST(_ root: TreeNode?, _ low: Int, _ high: Int) -> Int {
        if root == nil { return 0 }
        
        var node = root
        var number = 0
        var queueList = [TreeNode?]()
        
        queueList.append(node)
        while !queueList.isEmpty {
            node = queueList.removeFirst()
            if let nodeValue = node?.val {
                if nodeValue >= low && nodeValue <= high {
                    number += nodeValue
                }
            }
            
            if node?.left != nil {
                queueList.append(node?.left)
            }
            if node?.right != nil {
                queueList.append(node?.right)
            }
        }
        
        return number
    }
}
