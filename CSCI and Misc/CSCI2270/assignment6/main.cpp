#include "MovieTree.cpp"
#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include <iomanip>
using namespace std;

int main(int argc, char** argv){
  MovieTree t;
//t.addMovie(0, "Enron", 1999, 10.0);
//t.addMovie(0, "Dogton", 1999, 10.0);
//t.addMovie(0, "Dancin", 1999, 10.0);
//t.addMovie(0, "Bowling", 1999, 10.0);
//t.addMovie(0, "Taxi to", 1999, 10.0);
//t.addMovie(0, "Man on", 1999, 10.0);
//t.addMovie(0, "Hands on", 1999, 10.0);
//t.addMovie(0, "Jiro dream", 1999, 10.0);
//t.addMovie(0, "Down from", 1999, 10.0);
  t.addMovie(0, "A", 1999, 10.0);
  t.addMovie(0, "B", 1999, 10.0);
  t.addMovie(0, "C", 1999, 10.0);
  t.addMovie(0, "D", 1999, 10.0);
  t.addMovie(0, "E", 1999, 10.0);

  t.printMovieInventory();

//t.addMovie(0, "Bccc", 1999, 10.0);
//t.addMovie(0, "Baaa", 1999, 10.0);
//t.addMovie(0, "Accc", 1999, 10.0);
//t.addMovie(0, "Dccc", 1999, 10.0);
//t.printMovieInventory();
//t.deleteMovie("Bccc");
//t.printMovieInventory();
//t.deleteMovie("Baaa");
//t.printMovieInventory();
//t.deleteMovie("Dccc");
//t.printMovieInventory();
//t.deleteMovie("Accc");


//MovieTree a;
//a.addMovie(0, "apex", 1999, 10.0);
//a.addMovie(0, "asdf", 1999, 10.0);
//a.printMovieInventory();
//std::string ba = "b a";
//std::string bb = "b b";
//if (ba > bb){
//  std::cout << "asdf";
//}else{
//  std::cout << "jkjkfjd";
//}
}
