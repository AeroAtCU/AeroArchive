#ifndef GRAPH_HPP
#define GRAPH_HPP

#include <vector>
#include <iostream>

using namespace std;
struct vertex;


/*this is the struct for each vertex in the graph. */
struct vertex
{
    int id;
    bool visited;
    int distance_from_v;
    vector<vertex*> Edges; //stores edges to adjacent vertices
};

class Graph
{
    public:
    /*
    class constructor
    Purpose: perform all operations necessary to instantiate a class object
    Parameters: none
    */
    Graph();

    /*
    class destructor
    Purpose: free all resources that the object has acquired
    Parameters: none
    */
    ~Graph();

    /*
    Method Name: addEdge
    Purpose: Creates an edge between two vertices (Add the pointer of vertex v2 to the vector of Edges in v1)
    Param: v1 - vertex at one end of edge
    Param: v2 - vertex at opposite end of edge
    */
    void addEdge(int v1, int v2);

    /*
    Method Name: addVertex
    Purpose: Creates a vertex

    Param: id - id of the vertex
    */
    void addVertex(int id);

    /*
    Method Name: displayEdges
    Purpose: print all edges in graph (see writeup for format)
    Parameters: none
    */
    void displayEdges();

    /*
    Method Name: printDFT
    Purpose: Iterate through the vertices, perform Depth first traversal by calling the
    DFTraversal function
    Parameters: none
    */
   void printDFT();

   /*
    Method Name: printBFT
    Purpose: Iterate through the vertices, perform Breadth first traversal by calling the
    DFTraversal function
    Parameters: none
    */
   void printBFT();

    /*
    Method Name: setAllVerticesUnvisited
    Purpose: Iterate through the vertices, mark them unvisited.
            This function is called prior to calling DFS after BFS
            has been performed so that the nodes can revisited again
            when DFS is called.
    Parameters: None
    */
    void setAllVerticesUnvisited();

   /*
    Method Name: countNodesWithDist
    Purpose: Starting from vertex with id return the count of all the vertices which are 
    exactly dist away from id
    Parameters: int id - The starting vertex id
                int dist - The distance for which one to count
    return: count
    */

    int countNodesWithDist(int id, int dist);

  private:
    std::vector<vertex> vertices; //stores vertices

    /*
    Method Name: findVertex
    Purpose: Find and return the vertex of the specified id
    Param: id - id vertex to be returned
    returns pointer to a vertex
    */
    vertex *findVertex(int id);

    /*
    Method Name: BFTraversal
    Purpose: Call BFTraversal with a starting vertex and print the Breadth First Traversal from that vertex
    Param: v - pointer to the starting vertex for breadth first traversal
    */
    void BFTraversal(vertex *v);

    /*
    Method Name: DFTraversal
    Purpose: For starting vertex, print the Depth First Traversal from that vertex
    Param: v - pointer to the starting vertex for Depth first traversal
    */
    void DFTraversal(vertex *v);

};

#endif // GRAPH_HPP

#include "graphs.hpp"
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <vector>
#include <queue>
using namespace std;

Graph::Graph(){
}

int Graph::countNodesWithDist(int id, int dist){
	vertex *v;
  int num_nodes = 0;
  setAllVerticesUnvisited();
  for (int i=0; i<vertices.size(); i++){
    if (vertices[i].id == id){
      v = &vertices[i];
    }
  }

	v->visited = true;

	std::queue<vertex*> q;
	q.push(v);
	vertex* vtmp;

	//while (!q.empty()){
  for (int i=0; i<dist; i++){
		vtmp = q.front(); // store, print, and remove top
		q.pop();

		for (int i=0; i<vtmp->Edges.size(); i++){ // for every child (in edges)
			if (!vtmp->Edges[i]->visited){ // if CHILD has not been visited
				vtmp->Edges[i]->visited = true; //put it on q, set visited
				q.push(vtmp->Edges[i]);
				//std::cout << vtmp->Edges[i]->id << "\n";
			}
		}
	}
  std::cout << "stopped on node: " << vtmp->id << "\n";
  for (int i=0; i< vtmp->Edges.size(); i++){
    if (vtmp->Edges[i]->id != id){
      num_nodes++;
    }
  }
  //num_nodes = vtmp->Edges.size(); // now count number of unvisited?
  return num_nodes;
}


Graph::~Graph(){
}

void Graph::addEdge(int v1, int v2){
	for (int i=0; i<vertices.size(); i++){
		if (vertices[i].id == v1){
			for (int j=0; j<vertices.size(); j++){
				if (vertices[j].id == v2 && i!=j){
          vertices[i].Edges.push_back(&vertices[j]);
				}
			}
		}
	}
}

void Graph::addVertex(int id){
	bool found = false;

	for (int i=0; i<vertices.size(); i++){
		if (vertices[i].id == id){
			found = true;
		}
	}

	if (!found){
		vertex v;
		v.id = id;
		vertices.push_back(v);
	}
}

void Graph::displayEdges(){
	for (int i=0; i<vertices.size(); i++){
		std::cout << vertices[i].id << "-->";
		for (int e=0; e<vertices[i].Edges.size(); e++){
			std::cout << vertices[i].Edges[e]->id << " (" << vertices[i].distance_from_v << " miles)";
			if (e != vertices[i].Edges.size() - 1){ // if last, don't print ***
				std::cout << "***";
			}
		}
		std::cout << "\n";
	}
}

void Graph::printDFT(){
}

void Graph::printBFT(){
	setAllVerticesUnvisited();
	for (int i=0; i< vertices.size(); i++){
		if(!vertices[i].visited){
			BFTraversal(&vertices[i]);
		}
	}
}

void Graph::setAllVerticesUnvisited(){
	for (int i=0; i< vertices.size(); i++){
		vertices[i].visited = false;
	}
}

vertex* Graph::findVertex(int id){
}

void Graph::BFTraversal(vertex *v){
	std::cout << v->id << "\n";
	v->visited = true;

	std::queue<vertex*> q;
	q.push(v);
	vertex* vtmp;

	while (!q.empty()){
		vtmp = q.front(); // store, print, and remove top
		q.pop();

		for (int i=0; i<vtmp->Edges.size(); i++){ // for every child (in edges)
			if (!vtmp->Edges[i]->visited){ // if CHILD has not been visited
				vtmp->Edges[i]->visited = true; //put it on q, set visited
				q.push(vtmp->Edges[i]);
				std::cout << vtmp->Edges[i]->id << "\n";
			}
		}
	}
}

void Graph::DFTraversal(vertex *v){
}

int main(int argc, char** argv){
  Graph g;

  g.addVertex(1);
  g.addVertex(2);
  g.addVertex(3);
  g.addVertex(4);
  g.addVertex(5);

  g.addEdge(1, 4);

  g.addEdge(2, 4);
  g.addEdge(2, 5);

  g.addEdge(3, 5);

  g.addEdge(4, 1);
  g.addEdge(4, 2);
  g.addEdge(4, 5);

  g.addEdge(5, 2);
  g.addEdge(5, 3);
  g.addEdge(5, 4);

  std::cout << "counting nodes with dist(3, 2)\n";
  int n = g.countNodesWithDist(3, 2);
  std::cout << "num nodes is: " << n << "\n";

  std::cout << "\n\n";
  std::cout << "counting nodes with dist(2, 1)\n";
  n = g.countNodesWithDist(2, 1);
  std::cout << "num nodes is: " << n << "\n";
}
