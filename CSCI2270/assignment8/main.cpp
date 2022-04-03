#include "PriorityQueue.hpp"
#include "PriorityQueue.cpp"
#include <string>
#include <fstream>
#include <iostream>
#include <sstream>
using namespace std;
void pmenu();

int main(int argc, char** argv){
  std::string filename = "";
  std::string uins = "";
  std::string word = "";
  std::string group_name = "";
  int group_size = 0;
  int cooking_time = 0;
  int max_size = std::stoi(argv[1]);
  int totalCookTime = 0;

  PriorityQueue pq(max_size);
  
  pmenu();
  std::getline(std::cin, uins);
  while (uins != "6"){
    if (uins == "1"){
      std::cout << "Enter filename:\n";
      getline(std::cin, uins);
      filename = uins;
      
      ifstream inStream;
      inStream.open(filename);
      while (inStream >> word){
        group_name = word;
        inStream >> word;
        group_size = std::stoi(word);
        inStream >> word;
        cooking_time = std::stoi(word);
        pq.enqueue(group_name, group_size, cooking_time);
      }
          
    }else if (uins == "2"){
      std::cout << "Enter Group Name:\n";
      std::getline(std::cin, uins);
      group_name = uins;
      std::cout << "Enter Group Size:\n";
      std::getline(std::cin, uins);
      group_size = std::stoi(uins);
      std::cout << "Enter Estimated Cooking Time:\n";
      std::getline(std::cin, uins);
      cooking_time = std::stoi(uins);
      
      pq.enqueue(group_name, group_size, cooking_time);
      
    }else if (uins == "3"){
      if (pq.isEmpty()){
          std::cout << "Heap Empty, nothing to peek\n";
      }else{
      std::cout << "Group Name: " << pq.peek().groupName << "\n";
      std::cout << "Group Size: " << pq.peek().groupSize << "\n";
      std::cout << "Group Time: " << pq.peek().cookingTime << "\n";
      }
    
    }else if (uins == "4"){
        totalCookTime = totalCookTime + pq.peek().cookingTime;
        std::cout << "Group Name: " << pq.peek().groupName << " - Total Cook Time for the Group: " << totalCookTime << "\n";
        pq.dequeue();
        
    }else if (uins == "5"){
        while (!pq.isEmpty()){
          totalCookTime = totalCookTime + pq.peek().cookingTime;
          std::cout << "Group Name: " << pq.peek().groupName << " - Total Cook Time for the Group: " << totalCookTime << "\n";
          pq.dequeue();
        }
    }
      
    pmenu();
    std::getline(std::cin, uins);
  }
  
  std::cout << "Goodbye!" << std::endl;
  return 0;
}

void pmenu(){
  cout << "============Main Menu============" << endl;
  cout <<"1. Get group information from file" << endl; 
  cout <<"2. Add a group to Priority Queue" << endl; 
  cout << "3. Show next group in the queue" << endl;
  cout << "4. Serve Next group" << endl;
  cout << "5. Serve Entire Queue" << endl;
  cout << "6. Quit" << endl;
}
