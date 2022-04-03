#include "RPNCalculator.hpp"
#include <iostream>

using namespace std;

RPNCalculator::RPNCalculator(){
  stackHead = NULL;
}

RPNCalculator::~RPNCalculator(){
  while (!isEmpty()){
    pop();
  }
}

bool RPNCalculator::isEmpty(){
  if (stackHead == NULL){
    return true; 
  }
  return false;
}

void RPNCalculator::push(float num){
  Operand* toInsert = new Operand;
  toInsert->number = num;

  if (isEmpty()){ // If empty make head new operant
    stackHead = toInsert;
  }else{ // if not empty, make top->next new operant
    toInsert->next = stackHead;
    stackHead = toInsert;
  }
  return;
}

void RPNCalculator::pop(){
  Operand* tmp = new Operand;
  tmp = stackHead;

  if (isEmpty()){
    cout << "Stack empty, cannot pop an item.\n";
    return;
  }

  stackHead = stackHead->next;
  delete tmp;
  return;
}

Operand* RPNCalculator::peek(){
  if (isEmpty()){
    cout << "Stack empty, cannot peek.\n";
    return NULL;
  }

  return stackHead;
}

bool RPNCalculator::compute(std::string symbol){
  float op1;
  float op2;

  if (symbol != "+" && symbol != "*"){
    cout <<  "err: invalid operation\n";
    return false;
  }

  if (!isEmpty()){
    op1 = peek()->number;
    pop();
  }else{
    cout << "err: not enough operands\n";
    return false;
  }

  if (!isEmpty()){
    op2 = peek()->number;
    pop();
  }else{
    push(op1);
    cout << "err: not enough operands\n";
    return false;
  }

  if (symbol == "+")
    push(op1 + op2);
  else
    push(op1 * op2);

  return true;
}
