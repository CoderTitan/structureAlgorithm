//
//  TreeMap.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/5/12.
//

import Cocoa

class TreeMap<K: Comparable, V: Comparable>: Map<K, V> {
    
    /// 元素数量
    fileprivate var size = 0
    /// 根节点
    fileprivate var root: MapNode<K, V>?
    

    /// 元素个数
    override func count() -> Int {
        return size
    }
    
    /// 是否为空
    override func isEmpty() -> Bool {
        return size == 0
    }
    
    /// 清除所有元素
    override func clear() {
        root = nil
        size = 0
    }
    
    /// 添加元素(返回旧值)
    @discardableResult
    override func put(key: K, val: V?) -> V? {
        if root == nil {
            let node = MapNode(key, val)
            root = node
            size += 1
            
            // 添加之后调整节点
            afterPut(node)
            return nil
        }
        
        var node = root
        var parent = root
        var compare = 0
        while node != nil {
            parent = node
            if let tmp = node?.key {
                if tmp > key {
                    node = node?.left
                    compare = 1
                } else if tmp < key {
                    node = node?.right
                    compare = 2
                } else {
                    node?.key = key
                    let oldValue = node?.val
                    node?.val = val
                    return oldValue
                }
            } else {
                return nil
            }
        }
        
        let current = MapNode(key, val, parent: parent)
        if compare == 1 {
            parent?.left = current
        } else {
            parent?.right = current
        }
        size += 1
        
        // 添加之后调整节点
        afterPut(current)
        return nil
    }
    
    /// 根据元素查询value
    override func get(key: K) -> V? {
        if let node = getNode(key) {
            return node.val
        }
        return nil
    }
    
    /// 删除元素
    override func remove(key: K) -> V? {
        if let node = getNode(key) {
            size -= 1
            
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
            return node.val
        }
        return nil
    }
    
    /// 是否包含Key
    override func containsKey(key: K) -> Bool {
        return getNode(key) != nil
    }
    
    /// 是否包含Value
    override func containsValue(val: V) -> Bool {
        if root == nil { return false }
            
        var node = root
        var queueList = [MapNode<K, V>?]()
        queueList.append(node)
        
        while !queueList.isEmpty {
            node = queueList.removeFirst()
            if val == node?.val {
                return true
            }
            
            if node?.left != nil {
                queueList.append(node?.left)
            }
            if node?.right != nil {
                queueList.append(node?.right)
            }
        }
        return false
    }
    
    /// 获取当前节点的前序节点
    func frontNode(_ node: MapNode<K, V>?) -> MapNode<K, V>? {
        if node == nil || node?.left == nil { return nil }
        var tmpNode = node?.left
        while tmpNode?.right != nil {
            tmpNode = tmpNode?.right
        }
        return tmpNode
    }
    
    /// 获取当前节点的后序节点
    func behindRoot(_ node: MapNode<K, V>?) -> MapNode<K, V>? {
        if node == nil || node?.right == nil { return nil }
        var tmpNode = node?.right
        while tmpNode?.left != nil {
            tmpNode = tmpNode?.left
        }
        return tmpNode
    }
    
    /// 中序遍历
    func traversal() -> [String?] {
        if root == nil { return [] }
        return traversal(root).map({ $0?.string() })
    }
}


extension TreeMap {
    /// 根据key查找node
    fileprivate func getNode(_ key: K) -> MapNode<K, V>? {
        var node = root
        while node != nil {
            guard let nodeKey = node?.key else { break }
            if nodeKey > key {
                node = node?.left
            } else if nodeKey < key {
                node = node?.right
            } else {
                return node
            }
        }
        return nil
    }
    
    /// 添加node之后的调整节点
    fileprivate func afterPut(_ node: MapNode<K, V>) {
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
                afterPut(node)
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
    fileprivate func afterRemove(_ node: MapNode<K, V>) {
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
    
    /// 左旋转
    fileprivate func rotateLeft(_ grand: MapNode<K, V>) {
        guard let pNode = grand.right else { return }
        let child = pNode.left
        grand.right = child
        pNode.left = grand
        afterRorate(grand, pNode: pNode, child: child)
    }
    
    /// 右旋转
    fileprivate func rotateRight(_ grand: MapNode<K, V>) {
        guard let pNode = grand.left else { return }
        let child = pNode.right
        grand.left = child
        pNode.right = grand
        afterRorate(grand, pNode: pNode, child: child)
    }
    
    /// 旋转
    fileprivate func afterRorate(_ grand: MapNode<K, V>, pNode: MapNode<K, V>, child: MapNode<K, V>?) {
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
    
    /// 中序遍历
    fileprivate func traversal(_ node: MapNode<K, V>?) -> [MapNode<K, V>?] {
        if node == nil { return [] }
            
        var array = [MapNode<K, V>?]()
        
        let leftArr = traversal(node?.left)
        leftArr.forEach({ array.append($0) })
        
        array.append(node)
        
        let rightArr = traversal(node?.right)
        rightArr.forEach({ array.append($0) })
        
        return array
    }
}
