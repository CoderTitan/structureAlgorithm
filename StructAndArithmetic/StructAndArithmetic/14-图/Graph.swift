//
//  Graph.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/7/22.
//

import Cocoa

class Graph<V: Comparable, E: Comparable> {
    
    var weightManager: WeightManager<E>?
    
    init(_ weightManager: WeightManager<E>) {
        self.weightManager = weightManager
    }
    
    /// 边的个数
    func edgesSize() -> Int {
        fatalError("edgesSize mast be init")
    }
    
    /// 定点个数
    func verticesSize() -> Int {
        fatalError("verticesSize mast be init")
    }
    
    /// 添加顶点
    func addVertex(val: V) {}
    
    /// 添加边
    func addEdge(from: V, to: V) {}
    
    /// 添加边(带权重)
    func addEdge(from: V, to: V, weight: E?) {}
    
    /// 删除顶点
    func removeVertex(val: V) {}
    
    /// 删除边
    func removeEdge(from: V, to: V) {}
    
    func bfs(begin: V?, visitor: VertexVisitor<V>) {}
    func dfs(begin: V?, visitor: VertexVisitor<V>) {}
    
//    public abstract Set<> mst() -> hashse
//    public abstract List<V> topologicalSort();
//    public abstract Map<V, E> shortestPath(V begin);
//    public abstract Map<V, PathInfo<V, E>> shortestPath(V begin);
//    public abstract Map<V, Map<V, PathInfo<V, E>>> shortestPath();
}
