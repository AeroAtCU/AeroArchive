#include <iostream>

using namespace std;

struct igr{
  int num;
  igr *next;
};

void insertToEnd(igr** hptr, int n);
void deleteEntireArray(igr** hptr);
igr** splitToEvens(igr** hptr);
igr** splitToOdds(igr** hptr);
void printList_s(igr* head);

int main(){
  igr* head; head = NULL; igr** hptr = &head;
  igr** even_hptr;
  igr** odd_hptr;

  cout << "Printing empty List:\n";
  printList_s(*hptr);

  insertToEnd(hptr, 1);
  cout << "\nPrinting list of 1\n";
  printList_s(*hptr);

  cout << "\nPrinting Even-Split list of 1\n";
  even_hptr = splitToEvens(hptr);
  printList_s(*even_hptr);

  cout << "\nPrinting Odd-Split list of 1\n";
  odd_hptr = splitToOdds(hptr);
  printList_s(*odd_hptr);

  cout << "\nPrinting large list\n";
  insertToEnd(hptr, 1);
  insertToEnd(hptr, 2);
  insertToEnd(hptr, 3);
  insertToEnd(hptr, 4);
  insertToEnd(hptr, 5);
  insertToEnd(hptr, 6);
  insertToEnd(hptr, 7);
  insertToEnd(hptr, 8);
  insertToEnd(hptr, 9);
  insertToEnd(hptr, 10);
  insertToEnd(hptr, -3);
  insertToEnd(hptr, -8);
  printList_s(*hptr);

  cout << "\nPrinting Even-Split large list\n";
  even_hptr = splitToEvens(hptr);
  printList_s(*even_hptr);

  cout << "\nPrinting Odd-Split large list\n";
  odd_hptr = splitToOdds(hptr);
  printList_s(*odd_hptr);
}


void printList_s(igr* head){
  if (head == NULL){
    cout << "head > NULL" << endl;
    return;
  }
  igr* tmp = head;
  cout << "head > ";
  while (tmp != NULL){
    cout << tmp->num << " > ";
    tmp = tmp->next;
  }
  cout << "NULL" << endl;
  return;
}

igr** splitToEvens(igr** hptr){
  igr* even_head = NULL;
  igr** even_hptr = &even_head;
  if (*hptr == NULL){
    cout << "cannot split, head > NULL" << endl;
    return even_hptr;
  }
  igr* tmp = *hptr;
  while (tmp != NULL){
    if (tmp->num % 2 == 0){ // if even
     insertToEnd(even_hptr, tmp->num);
    } 
    tmp = tmp->next;
  }
  return even_hptr;
}

igr** splitToOdds(igr** hptr){
  igr* odd_head = NULL;
  igr** odd_hptr = &odd_head;
  if (*hptr == NULL){
    cout << "cannot split, head > NULL" << endl;
    return odd_hptr;
  }
  igr* tmp = *hptr;
  while (tmp != NULL){
    if (tmp->num % 2 != 0){ // if odd
     insertToEnd(odd_hptr, tmp->num);
    } 
    tmp = tmp->next;
  }
  return odd_hptr;
}

void deleteEntireArray(igr** hptr){
}

void insertToEnd(igr** hptr, int n){
  igr* toIns = new igr;
  toIns->next = NULL;
  toIns->num = n;
  
  if (*hptr == NULL){
    *hptr = toIns;
    return;
  }

  igr* tmp = *hptr;
  while (tmp->next != NULL){
    tmp = tmp->next;
  }

  tmp->next = toIns;
  return;
}
