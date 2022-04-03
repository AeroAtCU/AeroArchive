#include "HashTable.hpp"
#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
using namespace std;

namespace hfun{
    bool isWordInArray(wordItem** arr, std::string word, int length){
    for (int i=0; i<length; i++){
      if (arr[i] != NULL && arr[i]->word == word){
        return true;
      }
    }
    return false;
  }
  
  wordItem* maxOfLL(wordItem* head, wordItem** arr, int length){
    wordItem* tmp_trav = head;
    wordItem* tmp_max = head;

    while (tmp_trav != NULL){
      if (tmp_trav->count >= tmp_max->count && !isWordInArray(arr, tmp_trav->word, length)){
        tmp_max = tmp_trav;
      }
      //std::cout << tmp_trav->word << "\n";
      tmp_trav = tmp_trav->next;
    }

    return tmp_max;
  }

  void bubbleSort(wordItem** arr, int length){
    wordItem* tmp = new wordItem;

    for (int i=0; i<length-1; i++){
      for (int j=0; j<length-i-1; j++){
        if (arr[j] != NULL && arr[j+1] != NULL){
          if (arr[j]->count > arr[j+1]->count)
            tmp = arr[j];
            arr[j] = arr[j+1];
            arr[j+1] = tmp;
        }
      }
    }
  }
}

void HashTable::printTopN(int n){
  wordItem** top_arr = new wordItem*[n];
  float tmp_float;
  const int htSize = hashTableSize;

  for (int i=0; i<n; i++){
      top_arr[i] = NULL;
  }

  wordItem* tmp = new wordItem; // = hashTable[0];
  int num_words = getTotalNumWords();

  for (int arr_pos = 0; arr_pos < n; arr_pos++){ // loop thru n times
    for (int ht_pos = 0; ht_pos < htSize; ht_pos++){ // loop thru hash table

      tmp = hfun::maxOfLL(hashTable[ht_pos], top_arr, n);
      //if (tmp!=NULL){std::cout << tmp->word << "\n";}

      if (tmp == NULL){
      }
      else if (top_arr[arr_pos] == NULL && !hfun::isWordInArray(top_arr, tmp->word, n)){
        top_arr[arr_pos] = tmp;
      }
      else if (tmp->count >= top_arr[arr_pos]->count && !hfun::isWordInArray(top_arr, tmp->word, n)){
        top_arr[arr_pos] = tmp;
      }
      else{
      }

    }
  }

  // top_arr now has a bunch of max values in it. needs to be sorted, apparently
  hfun::bubbleSort(top_arr, n);

  //for (int i=0; i<n; i++){ // print array
  for (int i=n-1; i>=0; i--){
    if (top_arr[i] != NULL){
        //std::cout.precision(3);

        tmp_float = (float)top_arr[i]->count/num_words;
        printf("%.4f", tmp_float);  
        std::cout <<  " - " << top_arr[i]->word << std::endl;
    }else{
      std::cout << "are you trying to print more items than are in the hash table? [HashTable::printTopN\n";
    }
  }

  return;
}


int HashTable::getNumCollisions(){
  return numCollisions;
}

int HashTable::getNumItems(){
  return numItems;
}

HashTable::~HashTable(){
  return;
}

void HashTable::incrementCount(std::string word){
  wordItem* tmp = searchTable(word);
  if (tmp != NULL)
    tmp->count ++;

  return;
}

bool HashTable::isInTable(std::string word){
  wordItem* curr_node = searchTable(word);

  if (curr_node == NULL){
    return false;
  }else{
    return true;
  }
}

wordItem* HashTable::searchTable(std::string word){
  unsigned int word_hash = getHash(word);
  wordItem* tmp = hashTable[word_hash];

  while (tmp != NULL && tmp->word != word){
    tmp = tmp->next;
  }

  return tmp;
}

unsigned int HashTable::getHash(std::string word){
  unsigned int hashValue = 5381;
  int length = word.length();

  for (int i=0; i<length; i++){
    hashValue=((hashValue<<5)+hashValue) + word[i];
  }

  hashValue %= hashTableSize;

  return hashValue;
}

void HashTable::addWord(std::string word){
  unsigned int word_hash = getHash(word);

  wordItem *wi_to_ins = new wordItem;
  wi_to_ins->count = 1;
  wi_to_ins->word = word;
  wi_to_ins->next = NULL;
  
  numItems++; // always inserts a word so always incr
  
  if (hashTable[word_hash] == NULL){
      hashTable[word_hash] = wi_to_ins; // witi already pts 2 NULL
  }else{
      numCollisions++;
      wi_to_ins->next = hashTable[word_hash]; // always ins @ head
      hashTable[word_hash] = wi_to_ins;
  }
  
  return;
}

HashTable::HashTable(int hashTableSize){
  hashTable = new wordItem* [hashTableSize];

  for (int i=0; i< hashTableSize; i++){
    hashTable[i] = NULL;
  }
  numItems = 0;
  numCollisions = 0;
  this->hashTableSize = hashTableSize;

  return;
}

int HashTable::getTotalNumWords(){
  int num_words = 0;
  wordItem* tmp;
  
  for (int i=0; i<hashTableSize; i++){ // for every head
      if (hashTable[i] != NULL){
          tmp = hashTable[i];
          while(tmp != NULL){
              num_words = num_words + tmp->count;
              tmp = tmp->next;
          }
      }
  }
  
  return num_words;
}

void getStopWords(char *ignoreWordFileName, HashTable &stopWordsTable){
  ifstream instream;
  instream.open(ignoreWordFileName);
  std::string curr_line = "";

  for (int i=0; i<50; i++){
    std::getline(instream, curr_line);
    stopWordsTable.addWord(curr_line);
  }

  return;
}

bool isStopWord(std::string word, HashTable &stopWordsTable){
  if (stopWordsTable.isInTable(word))
    return true;
  else
    return false;
}

