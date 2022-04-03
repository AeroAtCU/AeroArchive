#include <iostream>
#include <string>
#include <fstream>
using namespace std;

int getLine(string fileName, int fileLine);
int insertIntoSortedArray(int arr[], int numEntries, int valueToAdd);
void customSort(int arr[], int numEntries);

int main(int argc, char** argv)
{
    int lineValue;
    int N = 100;
    int arr[N];
    int numEntries = 0;
    string fileName = argv[1];

    
    for (int i = 0; i<N; i++){
        lineValue = getLine(fileName, i);
        numEntries = insertIntoSortedArray(arr, numEntries, lineValue);
        

            for (int i = 0; i<numEntries; i++){ // display the array
                // need if to keep comma from last collumn from being displayed
                if ((i)==numEntries-1){
                    cout << arr[i];
                }else{
                    cout << arr[i] << ",";
                }
            }
            cout << endl;
    }
}

// -------------------- //
// ---- Functions ----- //
// -------------------- //

int insertIntoSortedArray(int arr[], int numEntries, int valueToAdd){
    arr[numEntries] = valueToAdd;
    customSort(arr, numEntries);
    return numEntries + 1;
}

void customSort(int arr[], int numEntries){
    int tmp;

    for (int i=0; i< numEntries; i++){
        for (int j=0; j<numEntries-i; j++){
            if (arr[j] > arr[j+1]){
                tmp = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = tmp;
            }
        }
    }
}

int getLine(string fileName, int fileLine){
  string lineString;
  ifstream inStream;
  inStream.open(fileName);

  if(inStream.is_open()){ // If file opened properly...
    for(int i = 0; i<=fileLine; i++){ // Run untill fileLine reached
      if(getline(inStream, lineString)){
      }else{
        exit(0);
      }
    }
  }else{
    cout << "Failed to open the file." << endl; exit(0);
  }
  return(std::stoi(lineString)); // trying to save on memory
}
