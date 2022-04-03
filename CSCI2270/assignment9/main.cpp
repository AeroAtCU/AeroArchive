#include "Graph.hpp"
#include "Graph.cpp"
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <vector>
#include <queue>
using namespace std;

int main(int argc, char** argv){
    Graph g;
    std::string filename = argv[1]; // automatically assigns char* to string
    
    ifstream inStream;
    inStream.open(filename);
    std::string curr_line = "";
    std::string curr_city = "";
		std::string word;
    std::vector<std::string> city_names;
    int curr_dist = 0;
    bool end_populate = false;
    
    std::getline(inStream, curr_line, '\n');
    std::istringstream ss(curr_line);
		std::getline(ss, word, ','); // ignore "city"

    // push city names into vector
		while(std::getline(ss, word, ',')) {
      g.addVertex(word);
      city_names.push_back(word);
		}

    // print city names
    for (int i=0; i<city_names.size(); i++){
      //std::cout << city_names[i] << "\n";
		}

    //for every line (i stores city source)
    for (int i=0; i<city_names.size(); i++){
      std::getline(inStream, curr_line, '\n'); // get the line
      std::istringstream ss(curr_line); // init for parse
      std::getline(ss, word, ','); // ignore city name
      curr_city = city_names[i];
      // for every number (j stores city destination)
      for (int j=0; j<city_names.size(); j++){
        std::getline(ss, word, ','); // get a word
        if (std::stoi(word) > 0){
          g.addEdge(curr_city, city_names[j], std::stoi(word));
          std::cout << " ... Reading in " << curr_city <<" -- " << city_names[j] << " -- " << std::stoi(word) << "\n";
        }
      }
    }

    std::cout << "------------------------------\n";
    std::cout << "Breadth First Traversal\n";
    std::cout << "------------------------------\n";
    g.printBFT();


    std::cout << "------------------------------\n";
    std::cout << "Depth First Traversal\n";
    std::cout << "------------------------------\n";
    g.printDFT();

    std::cout << "------------------------------\n";
    std::cout << "Display Edges\n";
    std::cout << "------------------------------\n";
    g.displayEdges();
    return 0;
}
