//
//  Graph.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/7/22.
//

import Cocoa

class Graph<V: Comparable & Hashable, E: Comparable & Hashable> {
    
    
    /// 边的个数
    func edgesSize() -> Int {
        fatalError("edgesSize mast be init")
    }
    
    /// 顶点个数
    func verticesSize() -> Int {
        fatalError("verticesSize mast be init")
    }
    
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
    func topologicalSort() -> [V] {
        fatalError("topologicalSort")
    }
    
    /*
     * 最小生成树
     * 最小权值生成树, 最小支撑树
     * 所有生成树中, 权值最小的那颗
     * prim算法方式
     */
    func mstPrim() -> HashSet<EdgeInfo<V, E>>? {
        fatalError("mstPrim")
    }
    
    /*
     * 最小生成树
     * 最小权值生成树, 最小支撑树
     * 所有生成树中, 权值最小的那颗
     * prim算法方式
     */
    func mstKruskal() -> HashSet<EdgeInfo<V, E>>? {
        fatalError("mstKruskal")
    }
    
    /*
     * 有向图
     * 从某一点出发的最短路径(权值最小)
     * 返回权值
     */
    func shortestPath(_ begin: V) -> HashMap<V, Double>? {
        fatalError("shortestPath")
    }
    
    /*
     * Dijkstra: 单源最短路径算法,用于计算一个顶点到其他所有顶点的最短路径
     * 不支持有负权边
     */
    func dijkstraShortPath(_ begin: V) -> HashMap<V, PathInfo<V, E>>? {
        fatalError("dijkstraShortPath")
    }
    
    /*
     * bellmanFord: 单源最短路径算法,用于计算一个顶点到其他所有顶点的最短路径
     * 支持有负权边
     * 支持检测是否有负权环
     */
    func bellmanFordShortPath(_ begin: V) -> HashMap<V, PathInfo<V, E>>? {
        fatalError("bellmanFordShortPath")
    }
    
    /*
     * Floyd: 多源最短路径算法,用于计算任意两个顶点的最短路径
     * 支持有负权边
     */
    func floydShortPath() -> HashMap<V, HashMap<V, PathInfo<V, E>>>? {
        fatalError("bellmanFordShortPath")
    }
    
    /// 输出字符串
    func printString() {}
}
