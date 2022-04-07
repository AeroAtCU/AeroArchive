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

