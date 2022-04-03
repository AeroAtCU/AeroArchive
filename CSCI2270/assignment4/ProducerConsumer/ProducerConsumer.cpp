#include "ProducerConsumer.hpp"
#include <iostream>
#include <string>

ProducerConsumer::ProducerConsumer(){
  queueFront = -1;
  queueEnd = -1;
}

bool ProducerConsumer::isEmpty(){
  if (queueSize() == 0){
    return true;
  }
  return false;
}

bool ProducerConsumer::isFull(){ // probably wrong?
  if (queueSize() >= SIZE){
    return true;
  }
  return false;
}

void ProducerConsumer::enqueue(std::string player){
  if (isEmpty()){ // adding first item
    queue[0] = player;
    queueFront = 0;
    queueEnd = 0;
    return;
  }

  if (!isFull()){ // There IS a place for the number
    if (queueEnd == (SIZE-1)){ // if queueEnd is the last element,add to front
      queue[0] = player;
      queueEnd = 0;
    }else{
      queue[queueEnd+1] = player;
      queueEnd++;
    }

//  if (queueEnd == (SIZE-1)){ // if queueEnd is the last element,add to front
//    queue[queueFront-1] = player;
//    queueFront--;
//  }else{ // Otherwise there is space on top, add to end
//    queue[queueEnd+1] = player;
//    queueEnd++;
//  }

  }else{ // No space left
    std::cout << "Queue full, cannot add new item\n";
  }
  return;
}

void ProducerConsumer::dequeue(){
  if (isEmpty()){
    std::cout << "Queue empty, cannot dequeue an item\n";
    return;
  } // there is SOMETHING to dequeue

  if (queueFront == queueEnd){ // only one item, reset to empty queue
    queue[queueFront] = "";
    queueFront = -1;
    queueEnd = -1;
    return;
  }

  if (queueFront == (SIZE-1)){ // removing "top" element
    queue[queueFront] = "";
    queueFront = 0;
    return;
  }

  queue[queueFront] = "";
  queueFront++;
  return;
}

int ProducerConsumer::queueSize(){
  int qsize = 0;
  for (int i=0; i<SIZE; i++){
    if (queue[i] != ""){
      qsize++;
    }
  }
  return qsize;
}

std::string ProducerConsumer::peek(){
  if (isEmpty()){
    std::cout << "Queue empty, cannot peek\n";
    return "";
  }
  return queue[queueFront];
}
