#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include <cstring>
using namespace std;

namespace hfun{

  // tested good
  bool toSwapParentChild(GroupNode parent, GroupNode child){
    if (parent.groupName == child.groupName){
      return false; // should be impossible but??
    }
    if (child.groupSize < parent.groupSize){
      return true;
    }else if (child.groupSize == parent.groupSize){
      if (child.cookingTime < parent.cookingTime){
        return true;
      }else{
        return false; //
      }
    }else{
      return false;
    }
  }

	bool isFirstHigherPriority(GroupNode child, GroupNode parent){
    if (parent.groupName == child.groupName){
      return false; // should be impossible but??
    }
    if (child.groupSize < parent.groupSize){
      return true;
    }else if (child.groupSize == parent.groupSize){
      if (child.cookingTime < parent.cookingTime){
        return true;
      }else{
        return false; //
      }
    }else{
      return false;
    }
  }
}

PriorityQueue::~PriorityQueue(){
}

GroupNode PriorityQueue::peek(){
	return priorityQueue[currentQueueSize-1];
}

bool PriorityQueue::isFull(){ // THIS IS LIKELY WRONG
  if (maxQueueSize == currentQueueSize)
    return true;
  return false;
}

bool PriorityQueue::isEmpty(){ // THIS IS WRONG
  if (currentQueueSize == 0)
    return true;
  return false;
}

// likely good
PriorityQueue::PriorityQueue(int queueSize){
  maxQueueSize = queueSize;
  currentQueueSize = 0;
  priorityQueue = new GroupNode[queueSize]; // questionable
}

// tested good
void PriorityQueue::enqueue(std::string _groupName, int _groupSize, int _cookingTime){
  if (PriorityQueue::isFull()){
    std::cout << "Heap full, cannot enqueue\n";
    return;
  }

  GroupNode* gn_ti = new GroupNode;
  gn_ti->groupName = _groupName;
  gn_ti->groupSize = _groupSize;
  gn_ti->cookingTime = _cookingTime;

  priorityQueue[currentQueueSize] = *gn_ti; // very questionable
  PriorityQueue::repairUpward(currentQueueSize);
  currentQueueSize++;

  return;
}

// tested good
void PriorityQueue::repairUpward(int nodeIndex){
  int parent_idx = (nodeIndex-1)/2;

  if (parent_idx == nodeIndex || parent_idx < 0){
      return;
  }

  if (hfun::toSwapParentChild(priorityQueue[parent_idx], priorityQueue[nodeIndex])){
    GroupNode tmp = priorityQueue[parent_idx];
    priorityQueue[parent_idx] = priorityQueue[nodeIndex];
    priorityQueue[nodeIndex] = tmp;

    PriorityQueue::repairUpward(parent_idx);
  }

  return;
}


void PriorityQueue::dequeue(){
  if (PriorityQueue::isEmpty()){
      std::cout << "Heap empty, cannot dequeue\n";
      return;
  }
  
  priorityQueue[0] = priorityQueue[currentQueueSize - 1];
  currentQueueSize--;
  //delete *priorityQueue[currentQueueSize - 1]; // How am I supposed to get rid of this struct?
  PriorityQueue::repairDownward(0);
}

void PriorityQueue::repairDownward(int nodeIndex){
  int left_child_idx = nodeIndex*2 + 1;
  int right_child_idx = nodeIndex*2 + 2;
  
  bool can_check_left = true;
  bool can_check_right = true;
  bool can_check_nodeIndex = true;
  bool am_i_swapping = false;
  
  if (nodeIndex > currentQueueSize){
    return;
  }
  if (left_child_idx > currentQueueSize){
    can_check_left = false;
  }
  if (right_child_idx > currentQueueSize){
    can_check_right = false;
  }
  
  // if left is more important than nodeIndex
  if (can_check_left && hfun::isFirstHigherPriority(priorityQueue[left_child_idx], priorityQueue[nodeIndex])){
    am_i_swapping = true;
  }
  
  // if right is more important than nodeIndex
  if (can_check_right && hfun::isFirstHigherPriority(priorityQueue[right_child_idx], priorityQueue[nodeIndex])){
    am_i_swapping = true;
  }
  
  // something is getting swapped
  if (am_i_swapping){
    GroupNode tmp = priorityQueue[nodeIndex];
    if (can_check_left && can_check_right){ // can check both so check both
			if (hfun::isFirstHigherPriority(priorityQueue[left_child_idx], priorityQueue[right_child_idx])){
				priorityQueue[nodeIndex] = priorityQueue[left_child_idx];
				priorityQueue[left_child_idx] = tmp;
				PriorityQueue::repairDownward(left_child_idx);
			}else{
				priorityQueue[nodeIndex] = priorityQueue[right_child_idx];
				priorityQueue[right_child_idx] = tmp;
				PriorityQueue::repairDownward(right_child_idx);
			}
    }
    else if (can_check_right){ // cannot check left, must be right.
			priorityQueue[nodeIndex] = priorityQueue[right_child_idx];
			priorityQueue[right_child_idx] = tmp;
			PriorityQueue::repairDownward(right_child_idx);
    }else if (can_check_left){ // cannot check right, must be left.
			priorityQueue[nodeIndex] = priorityQueue[left_child_idx];
			priorityQueue[left_child_idx] = tmp;
			PriorityQueue::repairDownward(left_child_idx);
    }else { // must check both
    }
  }
  
  return;
}
