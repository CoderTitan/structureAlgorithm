//
//  ListGraph.swift
//  StructAndArithmetic
//
//  Created by zl on 2021/7/22.
//

import Cocoa

class ListGraph<V: Comparable & Hashable, E: Comparable>: Graph<V, E> {

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
    override func addEdge(from: V, to: V, weight: E?) {
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
        
    }
    
    /// 删除边
    override func removeEdge(from: V, to: V) {}
    
    
    func printString() {
        print("[顶点]-------------------")
        vertices.traversal { val, vertex in
            print(String(describing: val))
            if let ver = vertex {
                print("out-----------")
                print(ver.outEdges)
                print("in-----------")
                print(ver.inEdges)
            }
        }
        
        print("[边]-------------------")
        edges.lists().forEach { edge in
            print(edge)
        }
    }
}
