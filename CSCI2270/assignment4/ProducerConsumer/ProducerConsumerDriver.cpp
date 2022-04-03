/****************************************************************/
/*                Producer Consumer Driver File                 */
/****************************************************************/
/* TODO: Implement menu options as described in the writeup     */
/****************************************************************/

#include "ProducerConsumer.hpp"
#include <iostream>
// you may include more libraries as needed

using namespace std;

/*
 * Purpose: displays a menu with options
 * @param none
 * @return none
 */
void menu()
{
  cout << "*----------------------------------------*\n";
	cout << "Choose an option:" << endl;
  cout << "1. Producer (Produce items into the queue)" << endl;
	cout << "2. Consumer (Consume items from the queue)" << endl;
	cout << "3. Return the queue size and exit" << endl;
  cout << "*----------------------------------------*\n";
}

int main(int argc, char const *argv[])
{
  ProducerConsumer pc;
  std::string uins;
  std::string uins_tmp;
  int uini_tmp;

  while (uins != "3"){
    menu();
    getline(cin, uins);

    if (uins == "1"){
      std::cout << "Enter the number of items to be produced:" << endl;
      std::getline(cin, uins_tmp);
      uini_tmp = std::stoi(uins_tmp);

      for (int i=1; i<=uini_tmp; i++){
        std::cout << "Item" << i << ":\n";
        std::getline(cin, uins_tmp);
        pc.enqueue(uins_tmp);
      }

    }else if (uins == "2"){
      std::cout << "Enter the number of items to be consumed:" << endl;
      std::getline(cin, uins_tmp);
      uini_tmp = std::stoi(uins_tmp);

      for (int i=1; i<=uini_tmp; i++){
        if (pc.isEmpty()){
          std::cout << "No more items to consume from queue\n";
        }else{
          std::cout << "Consumed: " << pc.peek() << "\n";
          pc.dequeue();
        }
      }
    }else{
    }

  }

  std::cout << "Number of items in the queue:" << pc.queueSize() << "\n";
  return(0);
}
