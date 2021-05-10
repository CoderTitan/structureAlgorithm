//
//  BinaryTreeTest.swift
//  
//
//  Created by zl on 2021/4/26.
//

import Cocoa



class BinaryTreeTest {
    
    fileprivate var header: TreeNode?
    
    func setTree(_ array: [Int?]) {
        if array.count == 0 { return }
        if array.count > 0 {
            if let val = array[0] {
                header = TreeNode(val)
            } else {
                return
            }
        }
        
        var node = header
        var queueList = [TreeNode?]()
        queueList.append(node)
        
        var listIndex = 1
        while !queueList.isEmpty && listIndex < array.count {
            node = queueList.removeFirst()
            if let val = array[listIndex] {
                node?.left = TreeNode(val)
            }
            if listIndex + 1 < array.count, let val = array[listIndex + 1] {
                node?.right = TreeNode(val)
            }
            
            if node?.left != nil {
                queueList.append(node?.left)
            }
            if node?.right != nil {
                queueList.append(node?.right)
            }
            
            listIndex += 2
        }
    }
}

extension BinaryTreeTest: BinaryTreeProtocol {
    func getRoot() -> Any? {
        return header as Any
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
            return String(describing: n.val)
        }
        return "-"
    }
}


extension BinaryTreeTest {
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
    
    /// 给你一棵所有节点为非负值的二叉搜索树，请你计算树中任意两节点的差的绝对值的最小值。
    func getMinimumDifference(_ root: TreeNode?) -> Int {
        if root == nil { return -1 }
        if root?.left == nil && root?.right == nil { return -1 }
            
        var node = root
        var lastElement = -1
        var minSub = 9999
        
        var stackList = [TreeNode?]()
        while !stackList.isEmpty || node != nil {
            while node != nil {
                stackList.append(node)
                node = node?.left
            }
            
            node = stackList.removeLast()
            if let element = node?.val {
                if lastElement != -1 {
                    let subNum = abs(element - lastElement)
                    minSub = min(minSub, subNum)
                }
                lastElement = element
            }
            node = node?.right
        }
        
        return minSub
    }
    
    
    /// 给定一个二叉树，判断其是否是一个有效的二叉搜索树。
    /// 假设一个二叉搜索树具有如下特征：
    ///  - 节点的左子树只包含小于当前节点的数。
    ///  - 节点的右子树只包含大于当前节点的数。
    ///  - 所有左子树和右子树自身必须也是二叉搜索树。
    ///  - https://leetcode-cn.com/problems/validate-binary-search-tree
    func isValidBST(_ root: TreeNode?) -> Bool {
        return isValidBST(root, lower: Int.max, upper: Int.max)
    }
    
    func isValidBST(_ node: TreeNode?, lower: Int, upper: Int) -> Bool {
        if node == nil { return true }
        guard let nodeVal = node?.val else { return false }
            
        if nodeVal <= lower || nodeVal >= upper {
            return false
        }
        
        return isValidBST(node?.left, lower: Int.max, upper: nodeVal) &&
            isValidBST(node?.right, lower: nodeVal, upper: Int.max)
    }
    
    
    /// 给定二叉搜索树（BST）的根节点和要插入树中的值，将值插入二叉搜索树
    func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
        var node = root
        if node == nil {
            return TreeNode(val)
        }
        
        while node != nil {
            if let nodeVal = node?.val {
                if nodeVal > val {
                    if node?.left == nil {
                        node?.left = TreeNode(val)
                        break
                    } else {
                        node = node?.left
                    }
                } else if nodeVal < val {
                    if node?.right == nil {
                        node?.right = TreeNode(val)
                        break
                    } else {
                        node = node?.right
                    }
                } else {
                    node?.val = val
                    break
                }
            }
        }
        
        return root
    }
    
    /// 给定二叉搜索树（BST）的根节点和一个值。 你需要在BST中找到节点值等于给定值的节点。 返回以该节点为根的子树
    func searchBST(_ root: TreeNode?, _ val: Int) -> (TreeNode?, TreeNode?) {
        if root == nil { return (nil, nil) }
        var node = root
        var parent: TreeNode?
        
        while node != nil {
            if let nodeVal = node?.val {
                if nodeVal > val {
                    parent = node
                    node = node?.left
                } else if nodeVal < val {
                    parent = node
                    node = node?.right
                } else if nodeVal == val {
                    return (node, parent)
                }
            }
        }
        
        return (nil, nil)
    }
    
    func isEqualNode(_ lhs: TreeNode?, rhs: TreeNode?) -> Bool {
        if let lhsVal = lhs?.val, let rhsVal = rhs?.val {
            if lhsVal == rhsVal {
                return true
            }
        }
        return false
    }
    
    /// 给定一个二叉树，检查它是否是镜像对称的。
    /// https://leetcode-cn.com/problems/delete-node-in-a-bst
    func isSymmetric(_ root: TreeNode?) -> Bool {
        if root == nil { return true }
        
        return isSymmetricNode(root, rhs: root)
    }
    
    func isSymmetricNode(_ lhs: TreeNode?, rhs: TreeNode?) -> Bool {
        var queueList = [TreeNode?]()
        queueList.append(lhs)
        queueList.append(rhs)
        
        while !queueList.isEmpty {
            let left = queueList.removeFirst()
            let right = queueList.removeFirst()
            
            if left == nil && right == nil {
                return true
            }
            if !isEqualNode(left, rhs: right) {
                return false
            }
            
            queueList.append(left?.left)
            queueList.append(right?.right)
            
            queueList.append(left?.right)
            queueList.append(right?.left)
        }
        
        return true
    }
    
    
    /// 二叉树展开为链表
    func flatten(_ root: TreeNode?) -> TreeNode? {
        if root == nil { return nil }
        
        var node = root
        var stacks = [TreeNode?]()
        stacks.append(node)
        
        var singLink: TreeNode? = nil
        while !stacks.isEmpty {
            node = stacks.removeLast()
            if singLink != nil {
                singLink?.left = nil
                singLink?.right = node
            }
            
            if node?.right != nil {
                stacks.append(node?.right)
            }
            if node?.left != nil {
                stacks.append(node?.left)
            }
            singLink = node
        }
        
        return singLink
    }
    
    /// 根据一棵树的前序遍历与中序遍历构造二叉树
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        if preorder.count != inorder.count { return nil }
        if preorder.count == 0 { return nil }
        
        let root = TreeNode(preorder[0])
        var stackList = [TreeNode]()
        stackList.append(root)
        
        var inorderIndex = 0
        for i in 1..<preorder.count {
            let preorderVal = preorder[i]
            var node = stackList.last
            
            if node?.val != inorder[inorderIndex] {
                let left = TreeNode(preorderVal)
                node?.left = left
                stackList.append(left)
            } else {
                while !stackList.isEmpty && stackList.last?.val == inorder[inorderIndex] {
                    node = stackList.removeLast()
                    inorderIndex += 1
                }
                let right = TreeNode(preorderVal)
                node?.right = right
                stackList.append(right)
            }
        }
        
        return root
    }
    
    /// 根据一棵树的中序遍历与后序遍历构造二叉树。
    func buildTree1(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        if postorder.count != inorder.count { return nil }
        if postorder.count == 0 { return nil }
        
        let root = TreeNode(postorder[postorder.count - 1])
        var stackList = [TreeNode]()
        stackList.append(root)
        
        var preorder = [Int]()
        var inordere = [Int]()
        postorder.reversed().forEach({ preorder.append($0) })
        inorder.reversed().forEach({ inordere.append($0) })
        
        var inorderIndex = 0
        for i in 1..<preorder.count {
            let preorderVal = preorder[i]
            var node = stackList.last

            if node?.val != inordere[inorderIndex] {
                let right = TreeNode(preorderVal)
                node?.right = right
                stackList.append(right)
            } else {
                while !stackList.isEmpty && stackList.last?.val == inordere[inorderIndex] {
                    node = stackList.removeLast()
                    inorderIndex += 1
                }
                let left = TreeNode(preorderVal)
                node?.left = left
                stackList.append(left)
            }
        }
        
        return root
    }
    
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        if root == nil { return [] }

        var node = root
        var array = [Int]()
        var list = [[Int]]()
        var leverCount = 1
        var leverHeight = -1
        
        var circleQueueArr = [TreeNode?]()
        circleQueueArr.append(node)
        
        while !circleQueueArr.isEmpty {
            node = circleQueueArr.removeFirst()
            leverCount -= 1
            if let val = node?.val {
                if leverHeight > 0 { // 奇数层
                    array.insert(val, at: 0)
                } else {// 偶数层
                    array.append(val)
                }
            }
            
            if node?.left != nil {
                circleQueueArr.append(node?.left)
            }
            if node?.right != nil {
                circleQueueArr.append(node?.right)
            }
            
            if leverCount == 0 {
                leverHeight *= -1
                list.append(array)
                array.removeAll()
                leverCount = circleQueueArr.count
            }
        }
        
        return list
    }
    
    func lowestCommonAncestor(lhs: TreeNode?, rhs: TreeNode?) -> Bool {
        if lhs == nil || rhs == nil {
            return false
        }
        
        var first = lhs
        var last = rhs
        while first != nil {
            while last != nil {
                if first?.val == last?.val {
                    return true
                }
                last = last?.parent
            }
            last = rhs
            first = first?.parent
        }
        
        return false
    }
}
