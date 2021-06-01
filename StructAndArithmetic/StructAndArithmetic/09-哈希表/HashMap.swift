//
//  HashMap.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/5/15.
//

import Cocoa

/// GNU Step
class HashMap<K: NSObject, V: Comparable> {
    
    fileprivate var size = 0
    fileprivate var tables = [HashNode<K, V>?]()
    
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
                node = node?.left
                compare = 1
            } else if h2 < h1 {
                node = node?.right
                compare = -1
            } else if k1?.isEqual(k2) == true {
                compare = 0
            } else if searched {
                //比较内存地址
                let hash1 = k1?.hash ?? 0
                let hash2 = k2?.hash ?? 0
                compare = hash1 - hash2
            } else {
                
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
        
        return nil
    }
    
    /// 删除元素
    func remove(key: K) -> V? {
        return nil
    }
    
    /// 是否包含Key
    func containsKey(key: K) -> Bool {
        return false
    }
    
    /// 是否包含Value
    func containsValue(val: V) -> Bool {
        return false
    }
}


extension HashMap {
    /// 根据key哈希值计算索引
    func index(_ key: K?) -> Int {
        let hash = hash(key)
        return hash & (tables.count - 1)
    }
    
    /// 根据node哈希值计算索引
    func index(_ node: HashNode<K, V>) -> Int {
        return node.hash & (tables.count - 1)
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
        let result: HashNode<K, V>?
        let com = 0
        
        while node != nil {
            let k2 = node?.key
            let h2 = hash(k2)
            
            if h1 > h2 {
                node = node?.right
            } else if h1 < h2 {
                node = node?.left
            } else if k1?.isEqual(k2) == true {
                return node
            } 
        }
        
        
        return nil
    }
}


extension HashMap {
    /// 添加之后平衡红黑树
    fileprivate func fixAfterPut(_ node: HashNode<K, V>) {
        
    }
    
    /// 删除之后平衡红黑树
    fileprivate func fixAfterRemove(_ node: HashNode<K, V>) {
        
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
