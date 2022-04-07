#include "Graph.hpp"
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <vector>
#include <queue>
using namespace std;

void Graph::displayEdges(){
	for (int i=0; i<vertices.size(); i++){
		std::cout << vertices[i].name << "-->";
		for (int e=0; e<vertices[i].Edges.size(); e++){
			std::cout << vertices[i].Edges[e].v->name << " (" << vertices[i].Edges[e].distance << " miles)";
			if (e != vertices[i].Edges.size() - 1){ // if last, don't print ***
				std::cout << "***";
			}
		}
		std::cout << "\n";
	}
}

void Graph::addVertex(std::string cityName){
	bool found = false;

	for (int i=0; i<vertices.size(); i++){
		if (vertices[i].name == cityName){
			found = true;
		}
	}

	if (!found){
		vertex v;
		v.name = cityName;
		vertices.push_back(v);
	}
}

void Graph::addEdge(std::string city1, std::string city2, int distance){
	for (int i=0; i<vertices.size(); i++){
		if (vertices[i].name == city1){
			for (int j=0; j<vertices.size(); j++){
				if (vertices[j].name == city2 && i!=j){
					Edge efcity1; // edge for vertex 1
					efcity1.v = &vertices[j];
					efcity1.distance = distance;
					vertices[i].Edges.push_back(efcity1);
				}
			}
		}
	}
}


void Graph::printDFT(){
	setAllVerticesUnvisited();
	for (int i=0; i< vertices.size(); i++){
		if (!vertices[i].visited){
			DFT_traversal(&vertices[i]);
		}
	}
}

void Graph::printBFT(){
	setAllVerticesUnvisited();
	for (int i=0; i< vertices.size(); i++){
		if(!vertices[i].visited){
			BFT_traversal(&vertices[i]);
		}
	}
}

void Graph::setAllVerticesUnvisited(){
	for (int i=0; i< vertices.size(); i++){
		vertices[i].visited = false;
	}
}

void Graph::BFT_traversal(vertex *v){
	std::cout << v->name << "\n";
	v->visited = true;

	std::queue<vertex*> q;
	q.push(v);
	vertex* vtmp;

	while (!q.empty()){
		vtmp = q.front(); // store, print, and remove top
		q.pop();

		for (int i=0; i<vtmp->Edges.size(); i++){ // for every child (in edges)
			if (!vtmp->Edges[i].v->visited){ // if CHILD has not been visited
				vtmp->Edges[i].v->visited = true; //put it on q, set visited
				q.push(vtmp->Edges[i].v);
				std::cout << vtmp->Edges[i].v->name << "\n";
			}
		}
	}
}

void Graph::DFT_traversal(vertex *v){
	if (v->visited){
		return;
	}

	std::cout << v->name << "\n";
	v->visited = true;

	for (int i=0; i<v->Edges.size(); i++){
		DFT_traversal(v->Edges[i].v);
	}
}

Graph::Graph(){
}

Graph::~Graph(){
}

