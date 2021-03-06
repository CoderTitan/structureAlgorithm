//
//  BinarySearchTree.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/4/19.
//

import Cocoa

class BinarySearchTree<E: Comparable> {
    

    fileprivate var size = 0
    fileprivate var root: Node<E>?
    
    func setRoot(_ node: Node<E>?) {
        root = node
    }
    
    /// 元素数量
    func count() -> Int {
        return size
    }
    
    /// 是否为空
    func isEmpty() -> Bool {
        return size == 0
    }
    
    /// 清除所有元素
    func clear() {
        root = nil
        size = 0
    }
    
    /// 节点是否存在
    func contains(_ element: E) -> Bool {
        return getNode(element) != nil
    }
    
    /// 添加节点
    func add(_ element: E) {
        if root == nil {
            root = Node(element: element, parent: nil)
            size += 1
            return
        }
        
        var node = root
        var parent = root
        var compare = 0
        while node != nil {
            parent = node
            if let tmp = node?.element {
                if tmp > element {
                    node = node?.left
                    compare = 1
                } else if tmp < element {
                    node = node?.right
                    compare = 2
                } else {
                    node?.element = element
                    return
                }
            } else {
                return
            }
        }
        
        let current = Node(element: element, parent: parent)
        if compare == 1 {
            parent?.left = current
        } else {
            parent?.right = current
        }
        
        size += 1
    }
    
    /// 删除节点
    func remove(_ element: E) {
        if let node = getNode(element) {
            remove(node)
        }
    }
    
    func inorderTraversal() -> [E] {
        if root == nil { return [] }
        var node = root
        var array = [E]()
        var stack = [Node<E>?]()
        
        while !stack.isEmpty || node != nil {
            while node != nil {
                stack.append(node)
                node = node?.left
            }
            
            node = stack.removeLast()
            if let element = node?.element {
                array.append(element)
            }
            node = node?.right
        }
        return array
    }
}
    
//MARK: 遍历
extension BinarySearchTree {
    /// 前序遍历(递归)
    func preorderForRecursion() -> [E] {
        return preorderEach(root)
    }
    
    /// 前序遍历(迭代)
    func preorderForEach() -> [E] {
        if root == nil { return [] }
        var node = root
        var array = [E]()
        
        let stack = Statck<Node<E>>()
        stack.push(node)
        
        while !stack.isEmpty() {
            node = stack.pop()
            if let tmp = node?.element {
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
    
    /// 中序遍历(递归)
    func infixOrderForRecursion() -> [E] {
        return infixOrderEach(root)
    }
    
    /// 中序遍历(迭代)
    func infixOrderForEach() -> [E] {
        if root == nil { return [] }
        var node = root
        var array = [E]()
        
        let stack = Statck<Node<E>>()
        while !stack.isEmpty() || node != nil {
            while node != nil {
                stack.push(node)
                node = node?.left
            }
            
            let peek = stack.pop()
            if let element = peek?.element {
                array.append(element)
            }
            node = peek?.right
        }
        
        return array
    }
    
    /// 后序遍历(递归)
    func epilogueForRecursion() -> [E] {
        return epilogueEach(root)
    }
    
    /// 后序遍历(迭代)
    func epilogueForEach() -> [E] {
        if root == nil { return [] }
        var node = root
        var array = [E]()
        var tmpNode: Node<E>?
        
        let stack = Statck<Node<E>>()
        stack.push(node)
        
        while !stack.isEmpty() {
            let peek = stack.peek()
            let isLeaf = peek?.isLeaf() ?? false
            
            // 栈顶节点是否是椰子节点, 上一次访问节点是否是栈顶节点的子节点
            if isLeaf || tmpNode?.parent == peek {
                node = stack.pop()
                tmpNode = node
                if let tmp = node?.element {
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
    func levelOrderForEach() -> [E] {
        var node = root
        if node == nil { return [] }
        var array = [E]()
        
        let queueLink = SingleQueue<Node<E>>()
        queueLink.enQueue(node)
        while !queueLink.isEmpty() {
            node = queueLink.deQueue()
            if let element = node?.element {
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
    
    /// 获取当前节点的前序节点
    func frontNode(_ node: Node<E>?) -> Node<E>? {
        if node == nil || node?.left == nil { return nil }
        var tmpNode = node?.left
        while tmpNode?.right != nil {
            tmpNode = tmpNode?.right
        }
        return tmpNode
    }
    
    /// 获取当前节点的后序节点
    func behindRoot(_ node: Node<E>?) -> Node<E>? {
        if node == nil || node?.right == nil { return nil }
        var tmpNode = node?.right
        while tmpNode?.left != nil {
            tmpNode = tmpNode?.left
        }
        return tmpNode
    }
}


extension BinarySearchTree {
    /// 判断是否为完全二叉树
    func isCompleteTree() -> Bool {
        if root == nil { return false }
        var node = root
        
        let queueLink = SingleQueue<Node<E>>()
        queueLink.enQueue(node)
        
        while !queueLink.isEmpty() {
            node = queueLink.deQueue()
            
            if node?.left != nil {
                queueLink.enQueue(node?.left)
                if node?.right != nil {
                    queueLink.enQueue(node?.right)
                } else {
                    return false
                }
            } else {
                if node?.right != nil {
                    return false
                }
            }
        }
        
        return true
    }
    
    /// 计算二叉树的高度
    func treeHeight() -> Int {
        if root == nil { return 0 }
        var node = root
        // 高度
        var height = 0
        // 每一层的个数
        var leverCount = 1
        
        let queueLink = SingleQueue<Node<E>>()
        queueLink.enQueue(node)
        
        while !queueLink.isEmpty() {
            node = queueLink.deQueue()
            leverCount -= 1
            
            if node?.left != nil {
                queueLink.enQueue(node?.left)
            }
            if node?.right != nil {
                queueLink.enQueue(node?.right)
            }
            
            if leverCount == 0 {
                leverCount = queueLink.size()
                height += 1
            }
        }
        
        return height
    }
    
    /// 反转二叉树(迭代)
    func invertTree() -> Node<E>? {
        if root == nil || root?.isLeaf() ?? false { return root }
        
        let queueLink = SingleQueue<Node<E>>()
        queueLink.enQueue(root)
        
        while !queueLink.isEmpty() {
            let node = queueLink.deQueue()
            let tmp = node?.left
            node?.left = node?.right
            node?.right = tmp
            
            if node?.left != nil {
                queueLink.enQueue(node?.left)
            }
            if node?.right != nil {
                queueLink.enQueue(node?.right)
            }
        }
        
        return root
    }
    
    /// 反转二叉树(递归)
    func invertRecursiveTree(_ root: Node<E>?) -> Node<E>? {
        if root == nil || root?.isLeaf() ?? false { return root }
        
        let left = invertRecursiveTree(root?.left)
        let right = invertRecursiveTree(root?.right)
        
        root?.left = right
        root?.right = left
        return root
    }
}

//MARK: 部分力扣题目
extension BinarySearchTree {
    /// 107. 二叉树的层序遍历 II : https://leetcode-cn.com/problems/binary-tree-level-order-traversal-ii/
    /// 给定一个二叉树，返回其节点值自底向上的层序遍历。 （即按从叶子节点所在层到根节点所在的层，逐层从左向右遍历）
    func levelOrderBottom() -> [[E]] {
        if root == nil { return [] }
        
        var leverCount = 1
        var elementArr = [E]()
        var node = root
        let stack = Statck<[E]>()
        
        let queueLink = SingleQueue<Node<E>>()
        queueLink.enQueue(root)
        
        while !queueLink.isEmpty() {
            leverCount -= 1
            
            node = queueLink.deQueue()
            if let element = node?.element {
                elementArr.append(element)
            }
            
            if node?.left != nil {
                queueLink.enQueue(node?.left)
            }
            if node?.right != nil {
                queueLink.enQueue(node?.right)
            }
            
            if leverCount == 0 {
                stack.push(elementArr)
                leverCount = queueLink.size()
                elementArr.removeAll()
            }
        }
        
        var array = [[E]]()
        for _ in 0..<stack.size() {
            if let element = stack.pop() {
                array.append(element)
            }
        }
        return array
    }
    
    
    /// 二叉树的宽度: https://leetcode-cn.com/problems/maximum-width-of-binary-tree
    /// 给定一个二叉树，编写一个函数来获取这个树的最大宽度。树的宽度是所有层中的最大宽度。这个二叉树与满二叉树（full binary tree）结构相同，但一些节点为空。
    /// 每一层的宽度被定义为两个端点（该层最左和最右的非空节点，两端点间的null节点也计入长度）之间的长度。
    func widthOfBinaryTree() -> Int {
        if root == nil { return 0 }
        
        var node = root
        var widthArr = [Int]()
        var leverCount = 1
        
        let queueLink = SingleQueue<Node<E>>()
        queueLink.enQueue(node)
        
        while !queueLink.isEmpty() {
            node = queueLink.deQueue()
            leverCount -= 1
            
            if node?.left != nil {
                queueLink.enQueue(node?.left)
            }
            if node?.right != nil {
                queueLink.enQueue(node?.right)
            }
            
            if leverCount == 0 {
                leverCount = queueLink.size()
                widthArr.append(leverCount)
            }
        }
        
        return widthArr.max() ?? 0
    }
    
    /// 给定一个二叉树，判断其是否是一个有效的二叉搜索树。
    /// 假设一个二叉搜索树具有如下特征：
    ///  - 节点的左子树只包含小于当前节点的数。
    ///  - 节点的右子树只包含大于当前节点的数。
    ///  - 所有左子树和右子树自身必须也是二叉搜索树。
    ///  - https://leetcode-cn.com/problems/validate-binary-search-tree
    func isValidBST() -> Bool {
        if root == nil { return true }
        
        var node = root
        var stackList = [Node<E>?]()
        stackList.append(node)
        
        while !stackList.isEmpty {
            node = stackList.removeFirst()
            let nodeValue = node?.element
            
            if let left = node?.left {
                if left.element! > nodeValue! {
                    return false
                }
                stackList.append(left)
            }
            if let right = node?.right {
                if right.element! < nodeValue! {
                    return false
                }
                stackList.append(right)
            }
        }
        
        return true
    }
    
    /// 根据一棵树的前序遍历与中序遍历构造二叉树(迭代)
    func buildTree(_ preorder: [Int], _ inorder: [Int]) -> Node<Int>? {
        if preorder.count != inorder.count { return nil }
        if preorder.count == 0 { return nil }
        
        let root = Node(element: preorder[0])
        var stackList = [Node<Int>]()
        stackList.append(root)
        
        var inorderIndex = 0
        for i in 1..<preorder.count {
            let preorderVal = preorder[i]
            var node = stackList.last
            
            if node!.element != inorder[inorderIndex] {
                let left = Node(element: preorderVal)
                node?.left = left
                stackList.append(left)
            } else {
                while !stackList.isEmpty && stackList.last!.element == inorder[inorderIndex] {
                    node = stackList.removeLast()
                    inorderIndex += 1
                }
                let right = Node(element: preorderVal)
                node?.right = right
                stackList.append(right)
            }
        }
        
        
        return root
    }
    
    /// 根据一棵树的前序遍历与中序遍历构造二叉树(递归)
    func buildTreeNode(_ preorder: [Int], _ inorder: [Int]) -> Node<Int>? {
        if preorder.count != inorder.count { return nil }
        if preorder.count == 0 { return nil }
        if preorder.count == 1 {
            return Node(element: preorder[0])
        }
        
        var root: Node<Int>?
        let firstVal = preorder[0]
        root = Node(element: firstVal)
        
        let subArr = inorder.split(separator: firstVal)
        var leftInorder = [Int]()
        var rightInorder = [Int]()
        if subArr.count > 1 {
            leftInorder = Array(subArr[0])
            rightInorder = Array(subArr[1])
        } else if subArr.count == 1 {
            let oneArr = Array(subArr[0])
            if oneArr.count > 0 {
                if oneArr[0] > firstVal {
                    rightInorder = oneArr
                } else {
                    leftInorder = oneArr
                }
            }
        }
        
        let leftPreorder = preorder.filter({ leftInorder.contains($0) })
        root?.left = buildTree(leftPreorder, leftInorder)
        
        let rightPreorder = preorder.filter({ rightInorder.contains($0) })
        root?.right = buildTree(rightPreorder, rightInorder)
        
        return root
    }
    
    /// 根据一棵树的后序遍历与中序遍历构造二叉树(迭代)
    func buildTreeBind(_ inorder: [Int], _ postorder: [Int]) -> Node<Int>? {
        if postorder.count != inorder.count { return nil }
        if postorder.count == 0 { return nil }
        
        let root = Node(element: postorder[postorder.count - 1])
        var stackList = [Node<Int>]()
        stackList.append(root)
        
        var preorder = [Int]()
        var inordere = [Int]()
        postorder.reversed().forEach({ preorder.append($0) })
        inorder.reversed().forEach({ inordere.append($0) })
        
        var inorderIndex = 0
        for i in 1..<preorder.count {
            let preorderVal = preorder[i]
            var node = stackList.last

            if node!.element != inordere[inorderIndex] {
                let right = Node(element: preorderVal)
                node?.right = right
                stackList.append(right)
            } else {
                while !stackList.isEmpty && stackList.last!.element == inordere[inorderIndex] {
                    node = stackList.removeLast()
                    inorderIndex += 1
                }
                let left = Node(element: preorderVal)
                node?.left = left
                stackList.append(left)
            }
        }
        
        return root
    }
    
    /// 最近公共祖先
    func lowestCommonAncestor(lhs: E, rhs: E) -> E? {
        let lhsNode = getNode(lhs)
        let rhsNode = getNode(rhs)
        if lhsNode == nil || rhsNode == nil { return nil }
        
        var first = lhsNode
        var last = rhsNode
        while first != nil {
            while last != nil {
                if first?.element == last?.element {
                    return first?.element
                }
                last = last?.parent
            }
            last = rhsNode
            first = first?.parent
        }
        
        return nil
    }
}
/**
 ┌──12
 │  └──10
┌──11
│  └──8
┌──9
│  │     ┌──6
│  │  ┌──5
│  │  │  │  ┌──3
│  │  │  │  │  └──1
│  │  │  └──2
│  └──4
7

 */

extension BinarySearchTree {
    /// 查找对应node
    fileprivate func getNode(_ element: E) -> Node<E>? {
        var node = root
        
        while node != nil {
            if let tmp = node?.element {
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
    
    /// 删除对应的node
    fileprivate func remove(_ node: Node<E>) {
        var tmpNode = node
        
        if tmpNode.isLeaf() {
            if tmpNode == tmpNode.parent?.left {
                tmpNode.parent?.left = nil
            } else {
                tmpNode.parent?.right = nil
            }
        } else if tmpNode.twoChildren() {
            if let front = frontNode(tmpNode) {
                tmpNode.element = front.element
                tmpNode = front
                
                if tmpNode == tmpNode.parent?.left {
                    tmpNode.parent?.left = nil
                } else {
                    tmpNode.parent?.right = nil
                }
            }
        } else {
            if let left = tmpNode.left {
                tmpNode.element = left.element
                tmpNode.left = nil
            }
            if let right = tmpNode.right {
                tmpNode.element = right.element
                tmpNode.right = nil
            }
        }
        
        size -= 1
    }
    
    /// 前序遍历
    fileprivate func preorderEach(_ node: Node<E>?) -> [E] {
        if node == nil { return [] }
        var array = [E]()
        
        if let item = node?.element  {
            array.append(item)
        }
        
        let leftArr = preorderEach(node?.left)
        leftArr.forEach({ array.append($0) })
        
        let rightArr = preorderEach(node?.right)
        rightArr.forEach({ array.append($0) })
        
        return array
    }
    
    /// 中序遍历
    fileprivate func infixOrderEach(_ node: Node<E>?) -> [E] {
        if node == nil { return [] }
        var array = [E]()
        
        let leftArr = infixOrderEach(node?.left)
        leftArr.forEach({ array.append($0) })
        
        if let item = node?.element  {
            array.append(item)
        }
        
        let rightArr = infixOrderEach(node?.right)
        rightArr.forEach({ array.append($0) })
        
        return array
    }
    
    /// 后序遍历
    fileprivate func epilogueEach(_ node: Node<E>?) -> [E] {
        if node == nil { return [] }
        var array = [E]()
        
        let leftArr = epilogueEach(node?.left)
        leftArr.forEach({ array.append($0) })
        
        let rightArr = epilogueEach(node?.right)
        rightArr.forEach({ array.append($0) })
        
        if let item = node?.element {
            array.append(item)
        }
        
        return array
    }
}


extension BinarySearchTree: BinaryTreeProtocol {
    func getRoot() -> Any? {
        return root as Any
    }
    
    func left(node: Any?) -> Any? {
        if let n = node as? Node<E> {
            return n.left as Any
        }
        return NSObject()
    }
    
    func right(node: Any?) -> Any? {
        if let n = node as? Node<E> {
            return n.right as Any
        }
        return NSObject()
    }
    
    func string(node: Any?) -> String {
        if let n = node as? Node<E>, let element = n.element {
            return String(describing: element)
        }
        return "-"
    }
}
