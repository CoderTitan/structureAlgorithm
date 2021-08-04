


![stract.png](https://titanjun.oss-cn-hangzhou.aliyuncs.com/ios/stract.png?x-oss-process=style/titanjun)


- 主要分享最近学习的数据结构和排序算法
- 文章只涉及每一种数据结构通过代码实现的函数定义
- 涉及的每一种数据结构或者算法基本都通过代码实现了
- GitHub代码地址: [数据结构和算法](https://github.com/CoderTitan/structureAlgorithm)

## 线性表

![linear_list.png](https://titanjun.oss-cn-hangzhou.aliyuncs.com/ios/linear_list.png?x-oss-process=style/titanjun)



### 链表

- 链表是一种链式存储的线性结构, 所有元素的内存地址不一定是连续的
- 下表是为四种链表和[测试项目](https://github.com/CoderTitan/structureAlgorithm)中对应的类名


```swift
class List<E: Comparable> {
    /**
     * 清除所有元素
     */
    func clear() {}

    /**
     * 元素的数量
     * @return
     */
    func size() -> Int { }

    /**
     * 是否为空
     * @return
     */
    func isEmpty() -> Bool { }

    /**
     * 是否包含某个元素
     * @param element
     * @return
     */
    func contains(_ element: E) -> Bool { }

    /**
     * 添加元素到尾部
     * @param element
     */
    func add(_ element: E) {}

    /**
     * 获取index位置的元素
     * @param index
     * @return
     */
    func get(_ index: Int) -> E? { }

    /**
     * 替换index位置的元素
     * @param index
     * @param element
     * @return 原来的元素ֵ
     */
    func set(by index: Int, element: E) -> E? { }

    /**
     * 在index位置插入一个元素
     * @param index
     * @param element
     */
    func add(by index: Int, element: E) {}

    /**
     * 删除index位置的元素
     * @param index
     * @return
     */
    func remove(_ index: Int) -> E? { }

    /**
     * 查看元素的索引
     * @param element
     * @return
     */
    func indexOf(_ element: E) -> Int { }
}
```


链表 | 类名
---|---
单向链表 | SingleLinkList
双向链表 | DoubleLinkList
单向循环链表 | CircleSingleLineList
双向循环链表 | CircleDoubleLinkList


### 栈

- 栈是一种特殊的线性表, 只能在一端进行操作
- 栈遵循后进先出的原则, Last in First out
- [Statck](https://github.com/CoderTitan/structureAlgorithm)


```swift
class Statck<E> {
    /// 元素个数
    func size() -> Int {}
    
    /// 是否为空
    func isEmpty() -> Bool { }
    
    /// 入栈
    func push(_ element: E?) {}
    
    /// 出栈
    @discardableResult
    func pop() -> E? {}
    
    /// 获取栈顶元素
    func peek() -> E? {}
    
    /// 清空
    func clear() {}
}
```

### 队列

- 队列是一种特殊的线性表, 只能在头尾两端进行操作
- 队列遵循后进先出的原则(单端队列), First in First out
- 下表是为队列和[测试项目](https://github.com/CoderTitan/structureAlgorithm)中对应的类名


```swift
class Queue<E: Comparable> {
    /// 元素数量
    func size() -> Int {}
    
    /// 是否为空
    func isEmpty() -> Bool {}
    
    /// 清除所有元素
    func clear() {}
    
    /// 入队
    func enQueue(_ element: E?) {}
    
    /// 出队
    func deQueue() -> E? {}
    
    /// 获取队列的头元素
    func front() -> E? {}
    
    func string() -> String {}
}
```


队列 | 类名
---|---
单端队列 | SingleQueue
双端队列 | SingleDeque
单端循环队列 | CircleQueue
双端循环队列 | CircleDeque


### 哈希表

- 哈希表也称之为散列表, 童年各国数组存储(非单纯的数组)
- 利用哈希函数生成key对应的index值为数组索引存储value值
- 两个不同的key值通过哈希函数可能得到相同的索引, 即哈希冲突
- 解决哈希冲突的常见方法
  - 开放定址法: 按照一定规则向其他地址探测, 知道遇到空桶
  - 再哈希法: 设计多个复杂的哈希函数
  - 链地址法: 通过链表将同一index索引的与元素串起来, [测试项目](https://github.com/CoderTitan/structureAlgorithm)中使用的这种方式


```swift
class Map<K: Hashable, V: Comparable> {
    /// 元素数量
    func count() -> Int {}
    
    /// 是否为空
    func isEmpty() -> Bool {}
    
    /// 清除所有元素
    func clear() {}
    
    /// 添加元素
    @discardableResult
    func put(key: K?, val: V?) -> V? {}
    
    /// 删除元素
    @discardableResult
    func remove(key: K) -> V? {}
    
    /// 根据元素查询value
    func get(key: K) -> V? {}

    /// 是否包含Key
    func containsKey(key: K) -> Bool {}
    
    /// 是否包含Value
    func containsValue(val: V) -> Bool {}

    /// 所有key
    func keys() -> [K] {}

    /// 所有value
    func values() -> [V] {}

    /// 遍历
    func traversal(visitor: ((K?, V?) -> ())) {}
}
```


## 二叉树


- 二叉树是n(n>=0)个结点的有限集合，该集合或者为空集（称为空二叉树），或者由一个根结点和两棵互不相交的、分别称为根结点的左子树和右子树组成


二叉树 | 类名
---|---
二叉树 | BinaryTree
二叉搜索树 | BinarySearchTree


AVL树和红黑树是两种平衡二叉搜索树


平衡二叉搜索树 | 类名
---|---
二叉平衡树 | BinaryBalanceTree
二叉平衡搜索树 | BinaryBalanceSearchTree
红黑树 | RedBlackTree


## 集合

[测试项目](https://github.com/CoderTitan/structureAlgorithm)中分别用链表, 红黑树, 哈希表实现了三种集合


```swift
class Set<E: Comparable & Hashable> {
    /// 元素个数
    func size() -> Int {}
    
    /// 是否为空
    func isEmpty() -> Bool {}
    
    /// 清除所有元素
    func clear() {}
    
    /// 是否包含某元素
    func contains(_ val: E) -> Bool {}
    
    /// 添加元素
    func add(val: E) {}
    
    /// 删除元素
    @discardableResult
    func remove(val: E) -> E? {}
    
    /// 获取所有元素
    func lists() -> [E] {}
}
```

集合 | 类名
---|---
双向链表集合 | ListSet
红黑树集合 | TreeSet
哈希表集合 | HashSet


## 二叉堆

堆是一种树状的数据结构, 二叉堆只是其中一种, 除此之外还有
- 多叉堆
- 索引堆
- 二项堆
- ....

[测试项目](https://github.com/CoderTitan/structureAlgorithm)中是以二叉堆实现了最大堆和最小堆


```swift
class AbstractHeap<E: Comparable> {
    /// 元素的数量
    func count() -> Int {}
    
    /// 是否为空
    func isEmpty() -> Bool {}
    
    /// 清空
    func clear() { }
    
    /// 添加元素
    func add(val: E) { }
    
    /// 添加元素数组
    func addAll(vals: [E]) { }
    
    /// 获得堆顶元素
    func top() -> E? {}
    
    /// 删除堆顶元素
    func remove() -> E? {}
    
    /// 删除堆顶元素的同时插入一个新元素
    func replace(val: E) -> E? {}
}
```


二叉堆 | 类名
---|---
二叉堆 | BinaryHeap
最大堆 | MinHeap
最小堆 | MaxHeap



## 并查集

- 并查集也叫不相交集合, 有查找和合并两个核心操作
- 查找: 查找元素所在的集
- 合并: 将两个元素所在的集合并为一个集


```swift
class UnionFind {
    /// 查找V所属的集合(根节点)
    func find(v: Int) -> Int {}
    
    /// 合并v1, v2所在的集合
    func union(v1: Int, v2: Int) { }
    
    /// 检查v1, v2是否属于同一个集合
    func isSame(v1: Int, v2: Int) -> Bool {}
}
```



并查集 | 类名
---|---
Quick Find | UnionFind_QF
Quick Union | UnionFind_QU
QU基于size优化 | UnionFind_QU_Size
QU基于size优化 | UnionFind_QU_Size
QU基于rank优化 | UnionFind_QU_Rank
QU基于rank的优化, 路径压缩 | UnionFind_QU_Rank_PC
QU基于rank的优化, 路径分裂 | UnionFind_QU_Rank_PS
QU基于rank的优化, 路径减半 | UnionFind_QU_Rank_PH
泛型并查集 | GenericUnionFind


## 图

- 图由顶点和边组成, 分有向图和无向图 ---> `ListGraph`
- `ListGraph`继承自`Graph`


```swift
class Graph<V: Comparable & Hashable, E: Comparable & Hashable> {
    
    /// 边的个数
    func edgesSize() -> Int {}
    
    /// 顶点个数
    func verticesSize() -> Int {}
    
    /// 添加顶点
    func addVertex(val: V) {}
    
    /// 添加边
    func addEdge(from: V, to: V) {}
    
    /// 添加边(带权重)
    func addEdge(from: V, to: V, weight: Double?) {}
    
    /// 删除顶点
    func removeVertex(val: V) {}
    
    /// 删除边
    func removeEdge(from: V, to: V) {}
    
    /// 广度优先搜索(Breadth First Search)
    func breadthFirstSearch(begin: V?, visitor: ((V) -> ())) {}
    
    /// 深度优先搜索(Depth First Search)[非递归]
    func depthFirstSearch(begin: V?, visitor: ((V) -> ())) {}
    
    /// 深度优先搜索(Depth First Search)[递归]
    func depthFirstSearchCircle(begin: V?, visitor: ((V) -> ())) {}
    

    /*
     * 拓扑排序
     * AOV网的遍历, 把AOV的所有活动排成一个序列
     */
    func topologicalSort() -> [V] {}

    /*
     * 最小生成树
     * 最小权值生成树, 最小支撑树
     * 所有生成树中, 权值最小的那颗
     * prim算法方式
     */
    func mstPrim() -> HashSet<EdgeInfo<V, E>>? {}
    
    /*
     * 最小生成树
     * 最小权值生成树, 最小支撑树
     * 所有生成树中, 权值最小的那颗
     * prim算法方式
     */
    func mstKruskal() -> HashSet<EdgeInfo<V, E>>? {}
    
    /*
     * 有向图
     * 从某一点出发的最短路径(权值最小)
     * 返回权值
     */
    func shortestPath(_ begin: V) -> HashMap<V, Double>? {}
    
    /*
     * Dijkstra: 单源最短路径算法,用于计算一个顶点到其他所有顶点的最短路径
     * 不支持有负权边
     */
    func dijkstraShortPath(_ begin: V) -> HashMap<V, PathInfo<V, E>>? {}
    
    /*
     * bellmanFord: 单源最短路径算法,用于计算一个顶点到其他所有顶点的最短路径
     * 支持有负权边
     * 支持检测是否有负权环
     */
    func bellmanFordShortPath(_ begin: V) -> HashMap<V, PathInfo<V, E>>? {}
    
    /*
     * Floyd: 多源最短路径算法,用于计算任意两个顶点的最短路径
     * 支持有负权边
     */
    func floydShortPath() -> HashMap<V, HashMap<V, PathInfo<V, E>>>? {}
    
    /// 输出字符串
    func printString() {}
}
```


## 排序

排序 | 类名
---|---
冒泡排序 | BubbleSorted2
选择排序 | SelectedSorted
插入排序 | InsertionSorted1
归并排序 | MergeSort
希尔排序 | ShellSort
快速排序 | QuickSorted
堆排序   | HeapSorted
计数排序 | CountingSorted
基数排序 | RadixSorted
桶排序   | BucketSorted


```swift
/// 快速排序
let arr = [126, 69, 593, 23, 6, 89, 54, 8]
let quick = QuickSorted<Int>()
print(quick.sorted(by: arr))

/// 桶排序
let sort = BucketSorted()
let array = [0.34, 0.47, 0.29, 0.84, 0.45, 0.38, 0.35, 0.76]
print(sort.sorted(by: array))
```



## 总结

- 数据结构部分除了跳表和串其他的基本都实现了
- 算法部分除了排序, 其他都暂时还没有学习
- 这部分的学习就暂时告一段落, 接下来我要准备11月份的考试
- 个人博客地址: (https://www.titanjun.top/)


----

