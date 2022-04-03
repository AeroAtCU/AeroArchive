#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
using namespace std;

struct User {
  string username;
  float gpa;
  int age;
};

string getLine(string fileName, int fileLine);
int countWords(string str);
void addUser(User users[], string _username, float _gpa, int _age, int length);
void printList(const User users[], int length);

int  main(int argc, char** argv){
  // Vars for user IO
  string inFileName = argv[1];
  string outputFileName = argv[2];
  float minGPA = std::stof(argv[3]);

  // Vars for data processing
  string lineText[100];
  string username[100];
  float gpa[100];
  int age[100];
  string tmp;
  User userList[100];
  int length = 0;

  // ----- Get data from file ----- //
  for (int i=0;i<100;i++){ // For filei up to 100 lines long
    lineText[i] = getLine(inFileName, i); //get a single line of text from file
    
    if (lineText[i] != ""){ // If the line data is not void (at end of file)...
      stringstream s(lineText[i]); //  Store line data in a stringstream (?)

      getline(s, tmp, ','); // get the first word
      username[i] = tmp;

      getline(s, tmp, ','); // get the second word (I guess it appends it?)
      gpa[i] = std::stof(tmp);

      getline(s, tmp, ',');
      age[i] = std::stoi(tmp);

      // addUser function
      // if ((lineText[i] != "") && (gpa[i] > minGPA)){
      if (true){
        userList[length].username = username[i];
        userList[length].gpa = gpa[i];
        userList[length].age = age[i];
        length++;
      }
    }
  }
  
  // ----- write to file ----- //
  ofstream outStream;
  outStream.open (outputFileName);

  for (int i=0;i<100;i++){
    if ((lineText[i] != "") && (gpa[i] > minGPA)){
      outStream << username[i] << "," << gpa[i] << "," << age[i] << "\n";
    }
  }
  
  outStream.close();

  // ----- addUser function ----- //
  for (int i=0;i<length;i++){
  //  cout << userList[i].username << "," << userList[i].gpa << "," << userList[i].age << "\n";
  }


  // ----- printList function ----- //
  printList(userList, length);

}

void printList(const User users[], int length){
  for (int i=0;i<length;i++){
    cout << users[i].username<<" [" << users[i].gpa << "] age: " << users[i].age << "\n";
  }
}

void addUser(User users[], string _username, float _gpa, int _age, int length){
  User tmp;
  tmp.username = _username;
  tmp.gpa = _gpa;
  tmp.age = _age;
  users[length] = tmp;
}

string getLine(string fileName, int fileLine){
  string lineString; ifstream inStream; inStream.open(fileName); // Declaring Objects etc

  if(inStream.is_open()){ // If file opened properly...
    for(int i = 0; i<=fileLine; i++){ // Run untill fileLine reached
      if(getline(inStream, lineString)){ // get line data, if it works do nothing
      }else{
       // exit(0); // if it doesn't work, exit program
        return("");
      }
    }
  }else{
  }
  inStream.close();
  return(lineString); // trying to save on memory
}

