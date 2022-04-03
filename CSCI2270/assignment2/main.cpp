#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include <cmath>
using namespace std;

struct wordItem {
  string word;
  int count;
};

void checkCommandLineArgs(int argc);
void doubleWordItemArray(wordItem * arrPtr_Orig, int N);
void getStopWords(const char *filename, string ignoreWords[]);
void getBookWords(const char *filename, wordItem * bookWords, string ignoreWords[]);
bool isStopWord(string word, string ignoreWords[]);
int insertIntoWordItemArray(wordItem * arrPtr, string word, int times_doubled);

// ---------------- //
// ----- Main ----- //
// ---------------- //

int main(int argc, char** argv){
  checkCommandLineArgs(argc);

  const int num_to_print = std::stoi(argv[1]);
  const char * book_filename = argv[2];
  const char * stop_words_filename = argv[3]; // Kindof the same as string, but different somehow.
  string ignoreWords[50];
  wordItem * bookWords = new wordItem[100];

  getStopWords(stop_words_filename, ignoreWords);
  // getBookWords(book_filename, bookWords, ignoreWords);
  
  bookWords[99].word = "asdf";
  cout << bookWords << 
  doubleWordItemArray(bookWords, 100);
  bookWords[100].word = "yay";
  
  cout << bookWords[99].word << bookWords[100].word << endl;

//int td = 0;
//td = insertIntoWordItemArray(bookWords, "bad", td);
//td = insertIntoWordItemArray(bookWords, "programmers", td);


  for (int i=0; i<9; i++){
   cout << bookWords[i].word << "::" << bookWords[i].count << endl;
  } 

}

// --------------------- //
// ----- Functions ----- //
// --------------------- //

int insertIntoWordItemArray(wordItem * bookWords, string word, int times_doubled){

  
  int length = 100 *  (pow(2.0, times_doubled));
  cout << length << endl;
  bool addedWord = false;

  for (int i=0; i<length; i++){
    if (!addedWord){ // IF you haven't added the word yet...
      if (bookWords[i].count != 0){ // IF there IS a word...
        if (bookWords[i].word == word){ // IF that word is the same as "word"
          bookWords[i].count = bookWords[i].count + 1;
          addedWord = true;
        }
      } else {
          bookWords[i].word = word;
          bookWords[i].count = bookWords[i].count + 1;
          addedWord = true;
      }
    }
  }

  if (!addedWord){
    cout << "DOUBLING" << endl;
    doubleWordItemArray(bookWords, length);
    bookWords[length].word = word;
    cout << "adf" << endl;
    bookWords[length].count = bookWords[length].count + 1;
    times_doubled  = times_doubled + 1;
    cout << "ADDED WORD AFTER DOULBLING" << endl;
  }
  return times_doubled;
}

void getBookWords(const char *filename, wordItem * bookWords, string ignoreWords[]){ // removes stopwords & incr counter.
  ifstream inStream;
  inStream.open(filename);
  string word;
  bool reachedEOF = false;
  int times_doubled = 0;

  while (!reachedEOF){ // While you haven't reached EOF
    getline(inStream, word, ' '); // Grab a word 

    if (word.find('\n') == std::string::npos){ // if word is not EOF (\n)

      if (!(isStopWord(word, ignoreWords))){ // if word is NOT a stop word
        times_doubled = insertIntoWordItemArray(bookWords, word, times_doubled);
        cout << times_doubled << endl;
      } 
    }else{ // word IS  end of file. special case. 
      cout << "at EOF" << endl;
      if (!(isStopWord(word, ignoreWords))){ // if word is NOT a stop word
        word = word.erase(word.size()-1);
        times_doubled = insertIntoWordItemArray(bookWords, word, times_doubled);
      } 
      reachedEOF = true;
    }
  }
}

bool isStopWord(string word, string ignoreWords[]){
  for (int i=0; i<50; i++){
    if (word == ignoreWords[i])
      return true;
  }
  return false;
}

void getStopWords(const char *filename, string ignoreWords[]){
  ifstream inStream;
  inStream.open(filename);

  for (int i=0; i<50; i++){
    getline(inStream, ignoreWords[i]);
  }
}

void doubleWordItemArray(wordItem * arrPtr_Orig, int N){ //
  wordItem * arrPtr_Doubled = new wordItem[2*N];

  for (int i=0;i<N;i++){
    arrPtr_Doubled[i].word = arrPtr_Orig[i].word;
    arrPtr_Doubled[i].count = arrPtr_Orig[i].count;
  }

//delete [] arrPtr_Orig;
//arrPtr_Orig = arrPtr_Doubled;
//// delete [] arrPtr_Doubled;
  *arrPtr_Orig = *arrPtr_Doubled;
  cout << "DOUBLED SUCCESS" << endl;
}

void checkCommandLineArgs(int argc){
  if (argc != 4){
    std::cout << "Usage: Assignment2Solution <number of words> <inputfilename.txt> <ignoreWordsfilename.txt>"<< std::endl; 
    exit(0);
  }
}

