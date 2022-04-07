#include "HashTable.hpp"
#include "HashTable.cpp"
#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
using namespace std;

int main(int argc, char** argv){
  int top_n_to_print = std::stoi(argv[1]);
  char* book_filename = argv[2];
  char* ignore_words_filename = argv[3];
  int hash_table_size = std::stoi(argv[4]);

  HashTable ign_ht(50);
  getStopWords(ignore_words_filename, ign_ht);

  HashTable book_ht(hash_table_size);

  ifstream inStream;
  inStream.open(book_filename);
  string word;
  
  while (inStream >> word){
    if (!ign_ht.isInTable(word)){
      if (!book_ht.isInTable(word)){
          book_ht.addWord(word);
      }else{
          book_ht.incrementCount(word);
      }
    }
  }
  
  book_ht.printTopN(top_n_to_print);
  
  std::cout << "#\nNumber of collisions: " << book_ht.getNumCollisions() << "\n#\nUnique non-stop words: " << book_ht.getNumItems() << "\n#\nTotal non-stop words: " << book_ht.getTotalNumWords() << "\n"; 

  return 0;
}


