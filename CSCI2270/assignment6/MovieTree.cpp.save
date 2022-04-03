#include "MovieTree.hpp"
#include <iostream>
#include <string>

namespace hfun { // helper functions
  TreeNode* insIntoTree(TreeNode* node, char firstLetter){
    if (node == NULL){
      TreeNode* newNode = new TreeNode;
      newNode->titleChar = firstLetter;
      newNode->parent = newNode->leftChild = newNode->rightChild = NULL;
      return newNode;
    }

    if (firstLetter > node->titleChar){
      node->leftChild = insIntoTree(node->leftChild, firstLetter);
    }

    node->rightChild = insIntoTree(node->rightChild, firstLetter);
  }

  TreeNode* find_node(TreeNode* currNode, std::string title){
    const char firstLetter = title.at(0);

    if(currNode == NULL){
      return NULL;
    }

    if(currNode->titleChar == firstLetter)
      return currNode;

    if(currNode->titleChar > firstLetter)
      return find_node(currNode->leftChild, title);
    else
      return find_node(currNode->rightChild, title);
  }

  void pLLInOrder(LLMovieNode* head){
    while (head != NULL){
      std::cout << " >> " << head->title << " " << head->rating << "\n";
      head = head->next;
    }
  }

  void pTreeInOrder(TreeNode* currNode){ // Print node recurrsively (personally made)
    if (currNode == NULL)
      return;
    pTreeInOrder(currNode->leftChild);

    std::cout << "Movies starting with letter: " << currNode->titleChar << "\n";
    pLLInOrder(currNode->head);

    pTreeInOrder(currNode->rightChild);
    return;
  }

  TreeNode* find_node_previous(TreeNode* currNode, std::string title){
    const char firstLetter = title.at(0);

    if (currNode == NULL){
      std::cout << "returning a null which should never happen";
      return NULL;
    }

    if(currNode->titleChar > firstLetter){ // fL is to the left
      if (currNode->leftChild == NULL){
        std::cout << currNode->titleChar << " node's LC is null. returning.\n";
        return currNode;
      }else{
        return find_node(currNode->leftChild, title);
      }
    }else{
      if (currNode->rightChild == NULL){
        std::cout << currNode->titleChar << " node's RC is null. returning.\n";
        return currNode;
      }else{
        return find_node(currNode->rightChild, title);
      }
    }
  }

  TreeNode* getMinValueNode(TreeNode* currNode){
      if(currNode->leftChild == NULL){
        return currNode;
      }
      return getMinValueNode(currNode->leftChild);
  }

  TreeNode* deleteTreeNode(TreeNode *currNode, char firstLetter){
    if(currNode == NULL){
      return NULL;
    }
    else if(firstLetter < currNode->titleChar){
      currNode->leftChild = deleteTreeNode(currNode->leftChild, firstLetter);
    }
    else if(firstLetter > currNode->titleChar)
    {
      currNode->rightChild = deleteTreeNode(currNode->rightChild, firstLetter);
    }else{ // currNode is node looking for
      if(currNode->leftChild == NULL && currNode->rightChild == NULL)
      {
        delete currNode; // deallocates memory.. ?
        currNode = NULL;
      }
      else if(currNode->leftChild == NULL){
        TreeNode* tmp = currNode;
        currNode = tmp->rightChild;
        delete tmp; 
      }
      else if(currNode->rightChild == NULL){
        TreeNode* tmp = currNode; // kindof dynamic alloc
        currNode = tmp->leftChild;
        delete tmp;
      }
      else{
        TreeNode* min = hfun::getMinValueNode(currNode->rightChild);
        currNode->titleChar = min->titleChar;
        currNode->head = min->head;
        currNode->rightChild = deleteTreeNode(currNode->rightChild, min->titleChar);
      }
    }
    return currNode; // most important part
  }

  LLMovieNode* deleteFromLL(LLMovieNode* head, std::string title){
    if (head->next == NULL){ // if only the head
      if(head->title == title){ // and if that head is to be deltd
        //std::cout << "deleting head\n";
        // delete head; // delete == dealloc
        return NULL;
      }else{ // otherwise only one element (head) so return head
        std::cout<<"Movie: "<<title<<" not found, cannot delete.\n";
        return head;
      }
    }

    // there is a head and another thing
    LLMovieNode* tmp = head;

    if (head->title == title){ // CASE: deleting head
      delete head;
      //head = tmp->next;
      //return head;
      return tmp->next;
    }

    // now not deleting head ever. so find elem or if it's there
    while (tmp->next != NULL && tmp->next->title != title){//ordrmtrs
      tmp = tmp->next;
    }

    // tmp has to be directly behind whatever to del now
    if (tmp->next == NULL){ // if tmp is last elem, elem DNE, no del
        std::cout<<"Movie: "<<title<<" not found, cannot delete.\n";
        return head;
    }

    LLMovieNode* mntd = tmp->next;
    
    tmp->next = mntd->next;
    delete mntd;
    return head;
  }

  LLMovieNode* insMovieInLL(LLMovieNode* head, LLMovieNode* mnti){
    if (head == NULL)
      head = mnti;

    if (head->title > mnti->title){ // Inserting before head
      mnti->next = head;
      return mnti;
    }

    LLMovieNode* tmp = head; //find where after head toins (poss.head)
    while(tmp->next != NULL && mnti->title > tmp->next->title){
      tmp = tmp->next;
    }

    mnti->next = tmp->next; // Insert and relink
    tmp->next = mnti; 
    return head;
  }

  TreeNode* createTN(TreeNode* leftChild, TreeNode* parent, TreeNode* rightChild, LLMovieNode* head){
    TreeNode* newTN = new TreeNode;
    newTN->leftChild = leftChild;
    newTN->parent = parent;
    newTN->rightChild = rightChild;
    newTN->head = head;
    newTN->titleChar = head->title.at(0);

    // must stitch up with parent, if parent exists
    if (parent != NULL){
      if (newTN->titleChar < parent->titleChar)
        parent->leftChild = newTN;
      else
        parent->rightChild = newTN;
    }

    return newTN;
  }
}

MovieTree::MovieTree(){
  root = NULL;
}

MovieTree::~MovieTree(){
}

void MovieTree::printMovieInventory(){
  hfun::pTreeInOrder(root);
  return;
}

void MovieTree::addMovie(int ranking, std::string title, int year, float rating){
  LLMovieNode* mnti = new LLMovieNode; // "movie node to insert"
  mnti->ranking = ranking;
  mnti->title = title;
  mnti->year = year;
  mnti->rating = rating;
  mnti->next = NULL;

  if (root == NULL){ // empty list case
    std::cout << "watch out, changing root to: " << mnti->title << "\n";
    root = hfun::createTN(NULL, NULL, NULL, mnti);
    return;
  }

  // There is a root
  const char firstLetter = title.at(0);
  TreeNode* tmp = hfun::find_node(root, title);

  if (tmp == NULL){ // it's not in list, so find previous node and create and ins new
    TreeNode* tmp2 = hfun::find_node_previous(root, title);

    if (tmp2 != NULL)
      std::cout << "TN "<< firstLetter<<" DNE, adding with "<< tmp2->titleChar<<" as parent\n";
    else
      std::cout << "TN "<< firstLetter<<" DNE, adding with NULL as parent\n";

    TreeNode* tnti = hfun::createTN(NULL, tmp2, NULL, mnti);
    return;
  }

  tmp->head = hfun::insMovieInLL(tmp->head, mnti);
  return;
}

void MovieTree::deleteMovie(std::string title){
  const char firstLetter = title.at(0);

  TreeNode* tntd = hfun::find_node(root, title);

  if (tntd == NULL){ // there is nothing to delete so STOP
    std::cout<<"Movie: "<<title<<" not found, cannot delete.\n";
    return;
  }else{
    //std::cout<<"Movie: "<<title<<" found, deleting\n";
    tntd->head = hfun::deleteFromLL(tntd->head, title);
    //std::cout<<"Movie: "<<title<<" Deleted; possibly deleting node\n";
  }

  if (tntd->head == NULL){
    //std::cout<<"Movie: "<<title<<" node muust now be deleted\n";
    delete tntd->head;
    root = hfun::deleteTreeNode(tntd, firstLetter);
  }
  return;
}

