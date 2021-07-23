//
//  HashMap.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/5/15.
//

import Cocoa


typealias Visitor = ((Hashable, Comparable) -> ())

/// GNU Step
class HashMap<K: Hashable, V: Comparable> {
    
    
    fileprivate let capacity = 1 << 4
    fileprivate let loadFactor = 0.75
    fileprivate var size = 0
    fileprivate var tables = [HashNode<K, V>?]()
    
    init() {
        tables = Array(repeating: nil, count: capacity)
    }
    
    /// 元素个数
    func count() -> Int {
        return size
    }
    
    /// 是否为空
    func isEmpty() -> Bool {
        return size == 0
    }
    
    /// 清除所有元素
    func clear() {
        if size == 0 { return }
        size = 0
        tables.removeAll()
    }
    
    /// 添加元素
    @discardableResult
    func put(key: K?, val: V?) -> V? {
        resertSize()
        
        // 获取key对应的索引
        let index = index(key)
        // 找到index位置的红黑树节点
        var root: HashNode<K, V>?
        if index < tables.count {
            root = tables[index]
        }
        
        // 没有哈希冲突
        if root == nil {
            let node = HashNode(key, val)
            root = node
            tables[index] = root
            size += 1
            fixAfterPut(node)
        }
        
        // 出现哈希冲突, 添加新的节点到红黑树上
        var node = root
        var parent = root
        var compare = 0
        let k1 = key
        let h1 = hash(k1)
        
        // 是否已经能搜索过这个key
        var searched = false
        while node != nil {
            parent = node
            let k2 = node?.key
            let h2 = node?.hash ?? 0
            
            if h2 > h1 {
                compare = 1
            } else if h2 < h1 {
                compare = -1
            } else if k1 == k2 {
                compare = 0
            } else if let kk1 = k1, let kk2 = k2 {
                compare = kk1.hashValue - kk2.hashValue
            } else if searched {
                //比较内存地址
                let hash1 = k1?.hashValue ?? 0
                let hash2 = k2?.hashValue ?? 0
                compare = hash1 - hash2
            } else {
                if node?.left != nil && getNode(node?.left, k1: k1) != nil {
                    node = getNode(node?.left, k1: k1)
                    compare = 0
                } else if node?.right != nil && getNode(node?.right, k1: k1) != nil {
                    node = getNode(node?.right, k1: k1)
                    compare = 0
                } else {
                    searched = true
                    let hash1 = k1?.hashValue ?? 0
                    let hash2 = k2?.hashValue ?? 0
                    compare = hash1 - hash2
                }
            }
            
            if compare > 0 {
                node = node?.right
            } else if compare < 0 {
                node = node?.left
            } else {
                let oldVal = node?.val
                node?.key = key
                node?.val = val
                node?.hash = h1
                return oldVal
            }
        }
        
        let current = HashNode(key, val, parent: parent)
        if compare > 0 {
            parent?.left = current
        } else {
            parent?.right = current
        }
        size += 1
        
        // 添加之后调整节点
        fixAfterPut(current)
        return nil
    }
    
    /// 根据元素查询value
    func get(key: K) -> V? {
        let node = node(key)
        return node?.val
    }
    
    /// 删除元素
    func remove(key: K) -> V? {
        return removeNode(node(key))
    }
    
    /// 是否包含Key
    func containsKey(key: K) -> Bool {
        return node(key) != nil
    }
    
    /// 是否包含Value
    func containsValue(val: V) -> Bool {
        if size == 0 { return false }
        let queue = SingleQueue<HashNode<K, V>>()
        for i in 0..<tables.count {
            if tables[i] == nil { continue }
            
            queue.enQueue(tables[i])
            while !queue.isEmpty() {
                let node = queue.deQueue()
                if node?.val == val {
                    return true
                }
                if let left = node?.left {
                    queue.enQueue(left)
                }
                if let right = node?.right {
                    queue.enQueue(right)
                }
            }
        }
        return false
    }
    
    /// 遍历
    func traversal(visitor: ((K?, V?) -> ())) {
        if size == 0 { return }
        
        let queue = SingleQueue<HashNode<K, V>>()
        for i in 0..<tables.count {
            if tables[i] == nil { continue }
            
            queue.enQueue(tables[i])
            while !queue.isEmpty() {
                if let node = queue.deQueue() {
                    visitor(node.key, node.val)
                    
                    if let left = node.left {
                        queue.enQueue(left)
                    }
                    if let right = node.right {
                        queue.enQueue(right)
                    }
                }
            }
        }
    }
}


extension HashMap {
    /// 根据key哈希值计算索引
    fileprivate func index(_ key: K?) -> Int {
        let hash = hash(key)
        return hash & (tables.count - 1)
    }
    
    /// 根据node哈希值计算索引
    fileprivate func index(_ node: HashNode<K, V>?) -> Int {
        let hash = node?.hash ?? 0
        return hash & (tables.count - 1)
    }
    
    /// 计算哈希值
    fileprivate func hash(_ key: K?) -> Int {
        guard let key = key else { return 0 }
        let hash = key.hashValue
        
        // 向右偏移32位, 做异或操作
        return hash ^ (hash >> 32)
    }
    
    /// 根据key获取根节点root
    fileprivate func node(_ key: K?) -> HashNode<K, V>? {
        let index = index(key)
        
        var node: HashNode<K, V>?
        if index < tables.count {
            node = tables[index]
            if let root = node {
                return getNode(root, k1: key)
            }
            return nil
        }
        return node
    }
    
    /// 根据root获取对应的node
    fileprivate func getNode(_ root: HashNode<K, V>?, k1: K?) -> HashNode<K, V>? {
        var node = root
        let h1 = hash(k1)
        
        while node != nil {
            let k2 = node?.key
            let h2 = hash(k2)
            
            if h1 > h2 {
                node = node?.right
            } else if h1 < h2 {
                node = node?.left
            } else if k1 == k2 {
                return node
            } else if let kk1 = k1, let kk2 = k2 {
                node = kk1.hashValue > kk2.hashValue ? node?.right : node?.left
            } else if node?.right != nil && getNode(node?.right, k1: k1) != nil {
                return node?.right
            } else {
                node = node?.left
            }
        }
        
        return nil
    }
    
    /// 删除对应的node
    fileprivate func removeNode(_ node: HashNode<K, V>?) -> V? {
        if node == nil { return nil }
        
        var curNode = node
        size -= 1
        
        let oldVal = curNode?.val
        if curNode?.twoChildren() == true {
            // 度为2的节点, 找后继节点
            let s = successor(curNode)
            node?.key = s?.key
            node?.val = s?.val
            node?.hash = s?.hash ?? 0
            curNode = s
        }
        
        // 删除node节点, 节点的度必然是0或者1
        let replacement = curNode?.left != nil ? curNode?.left : curNode?.right
        let index = index(curNode)
        
        if replacement != nil {
            replacement?.parent = curNode?.parent
            if curNode?.parent == nil {
                tables[index] = replacement
            } else if curNode == curNode?.parent?.left {
                curNode?.parent?.left = replacement
            } else {
                node?.parent?.right = replacement
            }
            
            // 删除之后
            fixAfterRemove(replacement)
        } else if curNode?.parent == nil {
            // 是椰子节点病切是根节点
            tables[index] = nil
        } else {
            // 是椰子节点
            if curNode == curNode?.parent?.left {
                curNode?.parent?.left = nil
            } else {
                curNode?.parent?.right = nil
            }
            
            fixAfterRemove(curNode)
        }
        
        return oldVal
    }
    
    /// 重置数组容量
    fileprivate func resertSize() {
        // 装填因子 <= 0.75
        if size / tables.count <= capacity { return }
        
        let oldTable = tables
        tables = Array(repeating: nil, count: oldTable.count << 1)
        let queue = SingleQueue<HashNode<K, V>>()
        
        for i in 0..<tables.count {
            if oldTable[i] == nil { continue }
            
            queue.enQueue(oldTable[i])
            while !queue.isEmpty() {
                let node = queue.deQueue()
                if let left = node?.left {
                    queue.enQueue(left)
                }
                if let right = node?.right {
                    queue.enQueue(right)
                }
                
             moveNode(node)
            }
        }
    }
    
    /// 挪动代码得放到最后面
    fileprivate func moveNode(_ newNode: HashNode<K, V>?) {
        newNode?.parent = nil
        newNode?.left = nil
        newNode?.right = nil
        newNode?.isRed = true
        
        let index = index(newNode)
        var root = tables[index]
        if root == nil {
            root = newNode
            tables[index] = root
            fixAfterPut(root)
            return
        }
        
        // 添加新的节点到红黑树
        var parent = root
        var node = root
        var cmp = 0
        let h1 = newNode?.hash ?? 0
        while node != nil {
            parent = node
            let h2 = node?.hash ?? 0
            cmp = h1 - h2
            if cmp > 0 {
                node = node?.right
            } else if cmp < 0 {
                node = node?.left
            }
        }
        
        newNode?.parent = parent
        if cmp > 0 {
            parent?.right = newNode
        } else {
            parent?.left = newNode
        }
        
        fixAfterPut(newNode)
    }
}


extension HashMap {
    /// 后继节点
    fileprivate func successor(_ node: HashNode<K, V>?) -> HashNode<K, V>? {
        if node == nil { return nil }
        
        var p = node?.right
        if p != nil {
            while p?.left != nil {
                p = p?.left
            }
            return p
        }
        
        var curNode = node
        while curNode?.parent != nil && curNode == curNode?.parent?.right {
            curNode = curNode?.parent
        }
        return curNode?.parent
    }
    
    /// 添加之后平衡红黑树
    fileprivate func fixAfterPut(_ node: HashNode<K, V>?) {
        let parent = node?.parent
        
        // 添加的是根节点, 或者上益到达了根节点
        if parent == nil {
            node?.isRed = false
            return
        }
        
        // 父节点是黑色
        if parent?.isRed == false {
            return
        }
        
        // 叔父节点
        let uncle = parent?.sibling()
        // 祖父节点
        let grand = parent?.parent
        grand?.isRed = true
        
        if uncle?.isRed == true {
            parent?.isRed = false
            uncle?.isRed = false
            fixAfterPut(grand)
            return
        }
        
        // 叔父节点不是红色
        if parent?.isLeftChild() == true {
            if node?.isLeftChild() == true {
                parent?.isRed = false
            } else {
                node?.isRed = false
                if let p = parent {
                    rotateLeft(p)
                }
            }
            if let p = grand {
                rotateRight(p)
            }
        } else {
            if node?.isLeftChild() == true {
                node?.isRed = false
                if let p = parent {
                    rotateRight(p)
                }
            } else {
                parent?.isRed = false
            }
            if let p = grand {
                rotateRight(p)
            }
        }
    }
    
    /// 删除之后平衡红黑树
    fileprivate func fixAfterRemove(_ node: HashNode<K, V>?) {
        if node?.isRed == true {
            node?.isRed = false
            return
        }
        
        guard let parent = node?.parent else { return }
        let isLeft = parent.left == nil || node?.isLeftChild() ?? false
        var sibling = isLeft ? parent.right : parent.left
        
        if isLeft {
            if sibling?.isRed == true {
                sibling?.isRed = false
                parent.isRed = true
                rotateLeft(parent)
                sibling = parent.right
            }
            if sibling?.left?.isRed == false && sibling?.right?.isRed == false {
                let pRed = parent.isRed
                parent.isRed = false
                sibling?.isRed = true
                if pRed == false {
                    fixAfterRemove(parent)
                }
            } else {
                if sibling?.right?.isRed == false, let s = sibling {
                    rotateRight(s)
                    sibling = parent.right
                }
                sibling?.isRed = parent.isRed
                sibling?.right?.isRed = false
                parent.isRed = false
                rotateLeft(parent)
            }
        } else {
            if sibling?.isRed == true {
                sibling?.isRed = false
                parent.isRed = true
                rotateLeft(parent)
                sibling = parent.left
            }
            
            if sibling?.left?.isRed == false && sibling?.right?.isRed == false {
                let pRed = parent.isRed
                parent.isRed = false
                sibling?.isRed = true
                if pRed == false {
                    fixAfterRemove(parent)
                }
            } else {
                if sibling?.left?.isRed == false, let s = sibling {
                    rotateLeft(s)
                    sibling = parent.left
                }
                sibling?.isRed = parent.isRed
                sibling?.left?.isRed = false
                parent.isRed = false
                rotateRight(parent)
            }
        }
    }
    
    /// 左旋转
    fileprivate func rotateLeft(_ grand: HashNode<K, V>) {
        guard let pNode = grand.right else { return }
        let child = pNode.left
        grand.right = child
        pNode.left = grand
        afterRorate(grand, pNode: pNode, child: child)
    }
    
    /// 右旋转
    fileprivate func rotateRight(_ grand: HashNode<K, V>) {
        guard let pNode = grand.left else { return }
        let child = pNode.right
        grand.left = child
        pNode.right = grand
        afterRorate(grand, pNode: pNode, child: child)
    }
    
    /// 旋转
    fileprivate func afterRorate(_ grand: HashNode<K, V>, pNode: HashNode<K, V>, child: HashNode<K, V>?) {
        // 设置根节点
        pNode.parent = grand.parent
        if grand.isLeftChild() {
            grand.parent?.left = pNode
        } else if grand.isRightChild() {
            grand.parent?.right = pNode
        } else {
            let index = index(grand)
            tables[index] = pNode
        }
        
        // 设置父节点
        child?.parent = grand
        grand.parent = pNode
    }
}
