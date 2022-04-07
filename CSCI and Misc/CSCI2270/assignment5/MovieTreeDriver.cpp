#include "MovieTree.cpp"
#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include <iomanip>
using namespace std;

void pmenu();

int main(int argc, char** argv){
  MovieTree t;
  std::string uins = argv[1]; 

  std::string cline = "";
  std::string pline = "";
  std::string ranking = "";
  std::string title = "";
  std::string year = "";
  std::string rating = "";

  std::ifstream inStream;
  inStream.open(uins);

  bool reachedEOF = false; 

  while (!reachedEOF){
    std::getline(inStream, cline, '\n');

    if (cline != pline){ // Don't stop until something repeats (given) 
      std::stringstream ss(cline);
      std::getline(ss, ranking, ',');
      std::getline(ss, title, ',');
      std::getline(ss, year, ',');
      std::getline(ss, rating, ',');

      try{ // not sure why this fails at the end but it does
        t.addMovieNode(stoi(ranking), title, stoi(year), stof(rating));
        //std::cout << ranking<<","<<title<<","<<year<<","<<rating<< "\n";
      }catch(...){}

      pline = cline;
    }else{
      reachedEOF = true;
    }
  }

  pmenu();
  std::getline(std::cin, uins);
  while (uins != "5"){
    if (uins == "1"){
      std::cout << "Enter title:" << std::endl;
      std::getline(std::cin, title);
      t.findMovie(title);
    }else if (uins == "2"){
      std::cout << "Enter minimum rating:\n";
      std::getline(std::cin, rating);
      std::cout << "Enter minimum year:\n";
      std::getline(std::cin, year);
      t.queryMovies(stof(rating), stoi(year));
    }else if (uins == "3"){
      t.printMovieInventory();
    }else if (uins == "4"){
      t.averageRating();
    }

    pmenu();
    std::getline(std::cin, uins);
  }

  std::cout << "Goodbye!\n";
  return 0;


}

void pmenu(){
  std::cout << "======Main Menu======" << std::endl;
  std::cout << "1. Find a movie" << std::endl;
  std::cout << "2. Query movies" << std::endl;
  std::cout << "3. Print the inventory" << std::endl;
  std::cout << "4. Average Rating of movies" << std::endl;
  std::cout << "5. Quit" << std::endl;
}
