/*
Starter HPP File for BST.
DISCLAIMER: We recommend everyone to at least have these functions implemented properly.

For the exams the variable type might change form int to char / any other custom type.
You will also have extra functions which will be the main exam problems. These will just be added to this hpp file and it will be given to you during your exam
*/

#ifndef BST_HPP
#define BST_HPP
#include <iostream>
#include <cstdlib>

using namespace std;

// Struct for a tree node
struct Node{
    int key; // data to be stored in the node
    Node* left = NULL; // pointer to the leftchild node
    Node* right = NULL; // pointer to the rightchild node
};

class BST{
    private:
        /*
        Method Name: createNode
        Purpose: Create a node with key as 'data'
        return: pointer to the new node
        */
        Node* createNode(int data);
        Node* root; // pointer to the root of the BST
        int range_sum;

        /** since root is a private member we need helper functions
         to access root for insertion, searching and printing **/

        /*
        Method Name: addNodeHelper
        Purpose: This function will add a node with key as 'data' in the tree rooted at 'currNode'.
        Call this function from addNode().
        return: currNode
        */
        Node* addNodeHelper(Node* currNode, int data);

        /*
        Method Name: deleteNodeHelper
        Purpose: This function deletes the node with 'value' as it's key from the tree rooted at 'currNode'.
        Call this function from deleteNode()
        return: currNode
        */
        Node* deleteNodeHelper(Node *currNode, int value);

        /*
        Method Name: searchKeyHelper
        Purpose: This function will search for a node with "data" as it's key in a tree rooted at 'currNode'.
        Call this function from searchKey()
        return: Node with "data" as it's key if found, otherwise NULL
        */
        Node* searchKeyHelper(Node* currNode, int data);

        /*
        Method Name: printTreeHelper
        Purpose: This function will traverse the tree rooted at "currNode" in an inorder fashion and print out the node elements.
        Call this function from printTree()
        return: none
        */
        void printTreeHelper(Node* currNode);

        /* OPTIONAL : This is just to help you visualize the tree (this function was provided in the recitation exercise)
        Method Name: print2DUtilHelper
        Purpose: This function will print the tree rooted at "currNode" in a 2D fashion.
        Call this function from print2DUtil()
        return: none
        */
        void print2DUtilHelper(Node *currNode, int space);

    public:

        // function to insert a node in the tree. This function calls the addNodeHelper()
        void addNode(int);

        // function to delete a node in the tree. This function calls the deleteNodeHelper()
        void deleteNode(int);

        // function to search a data in the tree. This function calls the searchKeyHelper()
        // returns True if it exists otherwise False
        bool searchKey(int);

        // function to print the tree (in an inorder fashion). This function calls the printTreeHelper()
        void printTree();

        /*
      	constructor
      	Purpose: perform all operations necessary to instantiate a class object
      	return: none
      	*/

        // default constructor
        BST();

        // parameterized constructor. It will create the root and put the 'data' in the root
        BST(int data);

        /*
      	destructor
      	Purpose: free all resources that the object has acquired
      	return: none
      	*/

        // This calls the destroyNode().
        ~BST();

        // Prints the tree in a 2D fashion. This function calls print2DUtilHelper().
        void print2DUtil(int space);

        int sumRange(int min, int max);
        void sumRec(Node* currNode, int min, int max);


};
#endif

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

int main(int argc, char** argv){
  BST large_bst;
  BST small_bst;
  BST empty_bst;

  int large_sum;
  int small_sum;
  int empty_sum;

  large_bst.addNode(9);
  large_bst.addNode(7);
  large_bst.addNode(16);
  large_bst.addNode(4);
  large_bst.addNode(8);
  large_bst.addNode(11);

  small_bst.addNode(2);
  small_bst.addNode(4);
  small_bst.addNode(7);

  std::cout << "=== Printing Large BST (in order) ===\n";
  large_bst.printTree();
  large_sum = large_bst.sumRange(8, 12);
  std::cout << "Sum between 8 and 12 is: " << large_sum << ".\n\n";

  std::cout << "=== Printing small BST (in order) ===\n";
  small_bst.printTree();
  small_sum = small_bst.sumRange(6, 7);
  std::cout << "Sum between 6 and 7 is: " << small_sum << ".\n\n";

  std::cout << "=== Printing empty BST (in order) ===\n";
  empty_bst.printTree();
  empty_sum = empty_bst.sumRange(8, 10);
  std::cout << "Sum between 8 and 10 is: " << empty_sum << ".\n\n";
}
