//
//  ListGraph.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/7/22.
//

import Cocoa

class ListGraph<V: Comparable & Hashable, E: Comparable & Hashable>: Graph<V, E> {

    fileprivate var vertices = HashMap<V, Vertex<V, E>>()
    fileprivate var edges = HashSet<Edge<V, E>>()
    
    
    /// 边的个数
    override func edgesSize() -> Int {
        return edges.size()
    }
    
    /// 定点个数
    override func verticesSize() -> Int {
        return vertices.count()
    }
    
    /// 添加顶点
    override func addVertex(val: V) {
        if vertices.containsKey(key: val) { return }
        let ver = Vertex<V, E>(val: val)
        vertices.put(key: val, val: ver)
    }
    
    /// 添加边
    override func addEdge(from: V, to: V) {
        addEdge(from: from, to: to, weight: nil)
    }
    
    /// 添加边(带权重)
    override func addEdge(from: V, to: V, weight: Double?) {
        var fromVertex = vertices.get(key: from)
        if fromVertex == nil {
            fromVertex = Vertex(val: from)
            vertices.put(key: from, val: fromVertex)
        }
        var toVertex = vertices.get(key: to)
        if toVertex == nil {
            toVertex = Vertex(val: to)
            vertices.put(key: to, val: toVertex)
        }
        
        var edge = Edge(from: fromVertex, to: toVertex)
        edge.weight = weight
        if fromVertex?.outEdges.remove(val: edge) != nil {
            fromVertex?.inEdges.add(val: edge)
            edges.remove(val: edge)
        }
        fromVertex?.outEdges.add(val: edge)
        toVertex?.inEdges.add(val: edge)
        edges.add(val: edge)
    }
    
    /// 删除顶点
    override func removeVertex(val: V) {
        let vertex = vertices.remove(key: val)
        if vertex == nil { return }
        
        vertex?.outEdges.lists().forEach({ edge in
            edge.to?.inEdges.remove(val: edge)
            edges.remove(val: edge)
        })
        vertex?.inEdges.lists().forEach({ edge in
            edge.from?.outEdges.remove(val: edge)
            edges.remove(val: edge)
        })
        vertex?.outEdges.clear()
        vertex?.inEdges.clear()
    }
    
    /// 删除边
    override func removeEdge(from: V, to: V) {
        let fromVertex = vertices.get(key: from)
        if fromVertex == nil { return }
        let toVertex = vertices.get(key: to)
        if toVertex == nil { return }
        
        let edge = Edge(from: fromVertex, to: toVertex)
        if fromVertex?.outEdges.remove(val: edge) != nil {
            toVertex?.inEdges.remove(val: edge)
            edges.remove(val: edge)
        }
    }
    
    /// 广度优先搜索(Breadth First Search)
    override func breadthFirstSearch(begin: V?, visitor: ((V) -> ())) {
        guard let key = begin else { return }
        guard let beginVertex = vertices.get(key: key) else { return }
        
        let vertexSet = HashSet<Vertex<V, E>>()
        let queue = SingleQueue<Vertex<V, E>>()
        queue.enQueue(beginVertex)
        vertexSet.add(val: beginVertex)
        
        while !queue.isEmpty() {
            if let vertex = queue.deQueue() {
                if let val = vertex.value {
                    visitor(val)
                }
                
                for edge in vertex.outEdges.lists() {
                    if let toVertex = edge.to {
                        if vertexSet.contains(toVertex) { continue }
                        queue.enQueue(toVertex)
                        vertexSet.add(val: toVertex)
                    }
                }
            }
        }
    }
    
    /// 深度优先搜索(Depth First Search)[非递归]
    override func depthFirstSearch(begin: V?, visitor: ((V) -> ())) {
        guard let key = begin else { return }
        guard let beginVertex = vertices.get(key: key) else { return }
        
        let vertexSet = HashSet<Vertex<V, E>>()
        let statck = Statck<Vertex<V, E>>()
        statck.push(beginVertex)
        vertexSet.add(val: beginVertex)

        
        while !statck.isEmpty() {
            if let vertex = statck.pop() {
                if let val = vertex.value {
                    visitor(val)
                }
                
                for edge in vertex.outEdges.lists() {
                    if let toVertex = edge.to {
                        if vertexSet.contains(toVertex) { continue }
                        statck.push(toVertex)
                        vertexSet.add(val: toVertex)
                    }
                }
            }
        }
    }
    
    /// 深度优先搜索(Depth First Search)[递归]
    override func depthFirstSearchCircle(begin: V?, visitor: ((V) -> ())) {
        guard let key = begin else { return }
        guard let beginVertex = vertices.get(key: key) else { return }
        
        let vertexSet = HashSet<Vertex<V, E>>()
        depthSearch(beginVertex, set: vertexSet, visitor: visitor)
    }
    
    /*
     * 拓扑排序
     * AOV网的遍历, 把AOV的所有活动排成一个序列
     */
    override func topologicalSort() -> [V] {
        let map = HashMap<Vertex<V, E>, Int>()
        let queue = SingleQueue<Vertex<V, E>>()
        vertices.traversal { val, vertex in
            if let count = vertex?.inEdges.size() {
                if count == 0 {
                    queue.enQueue(vertex)
                } else {
                    map.put(key: vertex, val: count)
                }
            }
        }
        
        var valueArray = [V]()
        while !queue.isEmpty() {
            let vertex = queue.deQueue()
            if let val = vertex?.value {
                valueArray.append(val)
            }
            
            vertex?.outEdges.lists().forEach({ edge in
                if let vertex = edge.to, let count = map.get(key: vertex) {
                    if count == 1 {
                        queue.enQueue(vertex)
                    } else {
                        map.put(key: vertex, val: count - 1)
                    }
                }
            })
        }
        
        return valueArray
    }
    
    /*
     * 最小生成树
     * 最小权值生成树, 最小支撑树
     * 所有生成树中, 权值最小的那颗
     * prim算法方式
     */
    override func mstPrim() -> HashSet<EdgeInfo<V, E>>? {
        let verArr = vertices.values()
        guard let vertex = verArr.first else { return nil }
        
        let edgeInfos = HashSet<EdgeInfo<V, E>>()
        let addedVertexs = HashSet<Vertex<V, E>>()
        addedVertexs.add(val: vertex)
        let minHeap = MinHeap(vals: vertex.outEdges.lists())
        let vertexSize = vertices.count()
        while !minHeap.isEmpty() && addedVertexs.size() < vertexSize {
            guard let edge = minHeap.remove() else { continue }
            if let toVertex = edge.to {
                if addedVertexs.contains(toVertex) { continue }
                addedVertexs.add(val: toVertex)
            }
            edgeInfos.add(val: edge.edgeInfo())
            if let edges = edge.to?.outEdges.lists() {
                minHeap.addAll(vals: edges)
            }
        }
        return edgeInfos
    }
    
    /*
     * 最小生成树
     * 最小权值生成树, 最小支撑树
     * 所有生成树中, 权值最小的那颗
     * prim算法方式
     */
    override func mstKruskal() -> HashSet<EdgeInfo<V, E>>? {
        let edgeCount = vertices.count() - 1
        if edgeCount < 0 { return nil }
        
        // 并查集
        let uf = GenericUnionFind<Vertex<V, E>>()
        vertices.values().forEach { vertex in
            uf.makeSet(vertex)
        }
        
        let minHeap = MinHeap(vals: edges.lists())
        let edgeInfos = HashSet<EdgeInfo<V, E>>()
        
        while !minHeap.isEmpty() && edgeInfos.size() < edgeCount {
            if let edge = minHeap.remove() {
                if uf.isSame(v1: edge.from, v2: edge.to) { continue }
                uf.union(v1: edge.from, v2: edge.to)
                edgeInfos.add(val: edge.edgeInfo())
            }
        }
        return edgeInfos
    }
    
    /*
     * 有向图
     * 从某一点出发的最短路径(权值最小)
     * 返回权值
     */
    override func shortestPath(_ begin: V) -> HashMap<V, Double>? {
        guard let beginVertex = vertices.get(key: begin) else { return nil }
        
        let waitPaths = HashMap<Vertex<V, E>, Double>()
        beginVertex.outEdges.lists().forEach { edge in
            if let toVertex = edge.to, let weight = edge.weight {
                waitPaths.put(key: toVertex, val: weight)
            }
        }
        
        let finishPaths = HashMap<V, Double>()
        finishPaths.put(key: begin, val: 0)
        while !waitPaths.isEmpty() {
            let minData = minWeightPath(waitPaths)
            if let minVertex = minData.0 {
                finishPaths.put(key: minVertex.value, val: minData.1)
                waitPaths.remove(key: minVertex)
                
                // 对minVertex的所有outEdges进行松弛操作
                for edge in minVertex.outEdges.lists() {
                    // 如果edge.to已经完成, 就不在执行松弛操作
                    if let key = edge.to?.value {
                        if finishPaths.containsKey(key: key) {
                            continue
                        }
                        
                        // 新的可选的最短路径
                        let newWeight = minData.1 + (edge.weight ?? 0)
                        // 以前的最短路径
                        if let oldWeight = waitPaths.get(key: minVertex) {
                            if oldWeight > newWeight {
                                waitPaths.put(key: edge.to, val: newWeight)
                            }
                        } else {
                            waitPaths.put(key: edge.to, val: newWeight)
                        }
                    }
                }
            }
        }
        
        finishPaths.remove(key: begin)
        return finishPaths
    }
    
    /*
     * Dijkstra: 单源最短路径算法,用于计算一个顶点到其他所有顶点的最短路径
     * 不支持有负权边
     */
    override func dijkstraShortPath(_ begin: V) -> HashMap<V, PathInfo<V, E>>? {
        guard let beginVertex = vertices.get(key: begin) else { return nil }
        
        let waitPaths = HashMap<Vertex<V, E>, PathInfo<V, E>>()
        waitPaths.put(key: beginVertex, val: PathInfo())
        
        let finishPaths = HashMap<V, PathInfo<V, E>>()
        while !waitPaths.isEmpty() {
            let minData = minPathInfo(waitPaths)
            if let minVertex = minData.0, let minPath = minData.1 {
                finishPaths.put(key: minVertex.value, val: minPath)
                waitPaths.remove(key: minVertex)
                    
                // 对minVertex进行松弛操作
                for edge in minVertex.outEdges.lists() {
                    if let toVal = edge.to?.value {
                        if finishPaths.containsKey(key: toVal) {
                            continue
                        }
                        
                        // 新的可选的最短路径
                        let newWeight = minPath.weight + (edge.weight ?? 0)
                        // 以前的最短路径
                        var oldPath = waitPaths.get(key: minVertex)
                        if oldPath == nil {
                            oldPath = PathInfo()
                            waitPaths.put(key: edge.to, val: oldPath)
                        } else {
                            if newWeight >= oldPath?.weight ?? 0 { continue }
                            oldPath?.edgeInfos.removeAll()
                        }
                        
                        oldPath?.weight = newWeight
                        oldPath?.edgeInfos.append(edge.edgeInfo())
                        for edge in minPath.edgeInfos {
                            oldPath?.edgeInfos.append(edge)
                        }
                    }
                }
            }
        }
        
        finishPaths.remove(key: begin)
        return finishPaths
    }
    
    /*
     * bellmanFord: 单源最短路径算法,用于计算一个顶点到其他所有顶点的最短路径
     * 支持有负权边
     * 支持检测是否有负权环
     */
    override func bellmanFordShortPath(_ begin: V) -> HashMap<V, PathInfo<V, E>>? {
        guard vertices.get(key: begin) != nil else { return nil }
        
        let finishPaths = HashMap<V, PathInfo<V, E>>()
        finishPaths.put(key: begin, val: PathInfo())
        
        for _ in 0..<vertices.count() - 1 {
            for edge in edges.lists() {
                if let fromVal = edge.from?.value {
                    guard let fromPath = finishPaths.get(key: fromVal) else { continue }
                    relax(edge, fromPath: fromPath, paths: finishPaths)
                }
            }
        }
        
        for edge in edges.lists() {
            if let fromVal = edge.from?.value {
                guard let fromPath = finishPaths.get(key: fromVal) else { continue }
                if relax(edge, fromPath: fromPath, paths: finishPaths) {
                    print("图中包含负权环")
                    return nil
                }
            }
        }
        
        finishPaths.remove(key: begin)
        return finishPaths
    }
    
    /*
     * Floyd: 多源最短路径算法,用于计算任意两个顶点的最短路径
     * 支持有负权边
     */
    override func floydShortPath() -> HashMap<V, HashMap<V, PathInfo<V, E>>>? {
        let finishPaths = HashMap<V, HashMap<V, PathInfo<V, E>>>()
        
        for edge in edges.lists() {
            if let fromVal = edge.from?.value {
                var map = finishPaths.get(key: fromVal)
                if map == nil {
                    map = HashMap()
                    finishPaths.put(key: fromVal, val: map)
                }
                let pathInfo = PathInfo<V, E>()
                pathInfo.edgeInfos.append(edge.edgeInfo())
                map?.put(key: edge.to?.value, val: pathInfo)
            }
        }
        
        vertices.keys().forEach { v2 in
            vertices.keys().forEach { v1 in
                vertices.keys().forEach { v3 in
                    if v1 == v2 || v1 == v3 || v3 == v2 { return }
                    
                    // v1 -> v2
                    guard let path12 = getPathInfo(finishPaths, from: v1, to: v2) else { return }
                    // v2 -> v3
                    guard let path23 = getPathInfo(finishPaths, from: v2, to: v3) else { return }
                    
                    // v1 -> v3
                    var path13 = getPathInfo(finishPaths, from: v1, to: v3)
                    
                    let newWeight = path12.weight + path23.weight
                    if path13 == nil {
                        path13 = PathInfo()
                        finishPaths.get(key: v1)?.put(key: v3, val: path13)
                    } else {
                        if newWeight >= path13?.weight ?? 0 { return }
                        path13?.edgeInfos.removeAll()
                    }
                    
                    path13?.weight = newWeight
                    for edge in path12.edgeInfos {
                        path13?.edgeInfos.append(edge)
                    }
                    for edge in path23.edgeInfos {
                        path13?.edgeInfos.append(edge)
                    }
                }
            }
        }
        
        return finishPaths
    }
    
    override func printString() {
        print("[顶点]-------------------")
        vertices.traversal { val, vertex in
            print(String(describing: val))
            if let ver = vertex {
                print("out-----------")
                print(ver.outEdgesString())
                print("in-----------")
                print(ver.inEdgesString())
            }
        }
        
        print("[边]-------------------")
        edges.lists().forEach { edge in
            print(edge.toString())
        }
    }
}

extension ListGraph {
    /// 深度优先搜索, 递归
    fileprivate func depthSearch(_ vertex: Vertex<V, E>, set: HashSet<Vertex<V, E>>, visitor: ((V) -> ())) {
        if let val = vertex.value {
            visitor(val)
        }
        
        set.add(val: vertex)
        for edge in vertex.outEdges.lists() {
            if let toVertex = edge.to {
                if set.contains(toVertex) { continue }
                depthSearch(toVertex, set: set, visitor: visitor)
            }
        }
    }
    
    /// 根据权值, 筛选权值最小的路径
    fileprivate func minWeightPath(_ paths: HashMap<Vertex<V, E>, Double>) -> (Vertex<V, E>?, Double) {
        var verterx: Vertex<V, E>?
        var weight: Double = 0
        
        paths.keys().forEach { ver in
            if verterx == nil {
                verterx = ver
                weight = paths.get(key: ver) ?? 0
            } else {
                let tmpWeight = paths.get(key: ver) ?? 0
                if weight > tmpWeight {
                    verterx = ver
                    weight = tmpWeight
                }
            }
        }
        
        return (verterx, weight)
    }
    
    /// 根据边信息, 筛选权值最小的路径
    fileprivate func minPathInfo(_ paths: HashMap<Vertex<V, E>, PathInfo<V, E>>) -> (Vertex<V, E>?, PathInfo<V, E>?) {
        var verterx: Vertex<V, E>?
        var pathInfo: PathInfo<V, E>?
        
        paths.keys().forEach { ver in
            if verterx == nil {
                verterx = ver
                pathInfo = paths.get(key: ver)
            } else {
                let path = paths.get(key: ver)
                if let w1 = pathInfo?.weight, let w2 = path?.weight {
                    if w1 > w2 {
                        verterx = ver
                        pathInfo = path
                    }
                } else {
                    verterx = ver
                    pathInfo = path
                }
            }
        }
        
        return (verterx, pathInfo)
    }
    
    /// 获取edge的边信息
    fileprivate func getPathInfo(_ paths: HashMap<V, HashMap<V, PathInfo<V, E>>>, from: V, to: V) -> PathInfo<V, E>? {
        let fromMap = paths.get(key: from)
        return fromMap == nil ? nil : fromMap?.get(key: to)
    }
    
    /// 需要进行松弛的边
    @discardableResult
    fileprivate func relax(_ edge: Edge<V, E>, fromPath: PathInfo<V, E>, paths: HashMap<V, PathInfo<V, E>>) -> Bool {
        // 新的可选的最短路径
        let newWeight = fromPath.weight + (edge.weight ?? 0)
        // 以前的最短路径
        guard let toVal = edge.to?.value else { return false }
            
        var oldPath = paths.get(key: toVal)
        if oldPath == nil {
            oldPath = PathInfo()
            paths.put(key: toVal, val: oldPath)
        } else {
            if newWeight >= oldPath?.weight ?? 0 { return false }
            oldPath?.edgeInfos.removeAll()
        }
        
        oldPath?.weight = newWeight
        oldPath?.edgeInfos.append(edge.edgeInfo())
        for edgeInfo in fromPath.edgeInfos {
            oldPath?.edgeInfos.append(edgeInfo)
        }
        
        return true
    }
}
