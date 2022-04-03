#include<iostream>
using namespace std;


void printArray(int **array, int array_size){
  for (int i=0;i<array_size; i++)
    cout << **array[i]<< endl;
}


int main(){
  int *a = new int[5];
  int array_length = 5;
  for (int i=0;i<5; i++){
    a[i] = i;
  }
  printArray(&a, array_length);
}
