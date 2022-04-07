#include "BST.hpp"
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <vector>
#include <queue>
using namespace std;


namespace hfun{
  int pTreeInOrder(Node* currNode){ // Print node recurrsively (personally made)
    if (currNode == NULL)
      return 0;
    pTreeInOrder(currNode->left);

    std::cout << "" << currNode->key << "\n";

    pTreeInOrder(currNode->right);
    return currNode->key;
  }
}
void BST::sumRec(Node* currNode, int min, int max){ 
  if (currNode == NULL)
    return;
  sumRec(currNode->left, min, max);

  if (currNode->key <= max && currNode->key >= min){
    range_sum = range_sum + currNode->key;
  }else{
  }

  sumRec(currNode->right, min, max);
  return;
}

int BST::sumRange(int min, int max){
  sumRec(root, min, max);
  return range_sum;
}

void BST::addNode(int data){
  Node* ti = new Node;
  ti->key = data;
  ti->left = NULL;
  ti->right = NULL;
  
  if (root == NULL){ // empty list case
    root = ti; 
    return;
  }

  Node* tmp = root;
  bool inserted = false;

  while (!inserted){
    if (ti->key < tmp->key){ // ti smaller than tmp 
      if (tmp->left == NULL){ // left is open, insert
        tmp->left = ti;
        // ti->parent = tmp; // no parents?
        inserted = true;
      }else{ // left not open, go left
        tmp = tmp->left;
      }
    }else{ // ti is bigger
      if (tmp->right == NULL){
        tmp->right = ti;
        // ti->parent = tmp;
        inserted = true;
      }else{
        tmp = tmp->right;
      }
    }
  }

  return;
}


void BST::printTree(){
  hfun::pTreeInOrder(root);
}

BST::BST(){
  root = NULL;
  range_sum = 0;
}

BST::~BST(){
  root = NULL;
  range_sum = 0;
}
