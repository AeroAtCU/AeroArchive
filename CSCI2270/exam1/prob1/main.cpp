#include <iostream>

using namespace std;

struct igr{
  int num;
  igr *next;
};

int sumEvens(igr* head);

int main(){
  // I am fully aware of how bad this is and looks. I'm just trying to get the requirements done, and if I have extra time will clean it up.
  igr* head;
  head = NULL;
  cout << "head->NULL: sum is :" << sumEvens(head) << endl;

  igr* tmp1 = new igr;
  head = tmp1;
  tmp1->next = NULL;
  tmp1->num = 7;
  cout << "head->7->NULL: sum is :" << sumEvens(head) << endl;

  tmp1->num = -6;
  cout << "head->-6->NULL: sum is :" << sumEvens(head) << endl;

  igr* tmp2 = new igr;
  igr* tmp3 = new igr;
  igr* tmp4 = new igr;
  igr* tmp5 = new igr;
  tmp2->num = 4;
  tmp3->num = 5;
  tmp4->num = 2;
  tmp5->num = 10;
  tmp1->next = tmp2;
  tmp2->next = tmp3;
  tmp3->next = tmp4;
  tmp4->next = tmp5;
  tmp5->next = NULL;
  cout << "head->-6->4->5->2->10->NULL: sum is :" << sumEvens(head) << endl;
}

int sumEvens(igr* head){
  igr* tmp = head;
  int ans = 0;

  if (tmp == NULL)
    return ans;

  while (tmp != NULL){
    if (tmp->num % 2 == 0) // if even
      ans = ans + tmp->num;

    tmp = tmp->next;
  }
  
  return ans;
} 

