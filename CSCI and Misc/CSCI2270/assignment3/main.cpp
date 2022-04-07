/****************************************************************/
/*                   Assignment 3 Driver File                   */
/****************************************************************/
/* TODO: Implement menu options as described in the writeup     */
/****************************************************************/

#include "CountryNetwork.hpp"

using namespace std;

void displayMenu();

int main(int argc, char* argv[]){

  CountryNetwork cn;
  string userInput = "8";

  while(1==1){

  displayMenu();
  std::getline(std::cin, userInput);

  if (userInput == "1"){ // Load Default Setup
    cn.loadDefaultSetup();
    cn.printPath();
  }

  if (userInput == "2"){ // Print Path
    cn.printPath();
  }

  if (userInput == "3"){ // Send Message
    string reciever; string msg;
    cout << "Enter name of the country to receive the message:" << endl;
    std::getline(std::cin, reciever);
    cout << "Enter the message to send:" << endl;
    std::getline(std::cin, msg);

    cn.transmitMsg(reciever, msg);
  }

  if (userInput == "4"){ // Add Country
    string newCountry; string previous;
    cout << "Enter a new country name" << endl;
    std::getline(std::cin, newCountry);
    cout << "Enter the previous country name (or First):" << endl;
    std::getline(std::cin, previous);

    if (previous == "First")
      previous = "NULL";

    if (previous != "NULL"){
      while (cn.searchNetwork(previous) == NULL){
        cout << "INVALID country...Please enter a VALID previous country name:" << endl; 
        std::getline(std::cin, previous);
      }
    }

    cn.insertCountry(cn.searchNetwork(previous), newCountry);
    cn.printPath();
  }

  if (userInput == "5"){ // Delete Country
    string toDelete;

    cout << "Enter a country name:" << endl;
    std::getline(std::cin, toDelete);

    cn.deleteCountry(toDelete);
    cn.printPath();
  }

  if (userInput == "6"){ // Reverse network
    cn.reverseEntireNetwork();
    cn.printPath();
  }

  if (userInput == "7"){ // Clear Network
    cn.deleteEntireNetwork();
  }

  if (userInput == "8"){ // Quit
    cout << "Quitting... cleaning up path: " << endl; 
    cn.printPath();
    cn.deleteEntireNetwork();
    if (cn.isEmpty()){
      cout << "Path cleaned" << endl;
    }else{
      cout << "Error: Path NOT cleaned" << endl; 
    }
    cout << "Goodbye!" << endl;
    return 0; exit(0);
  }
  }
}

/*
 * Purpose: displays a menu with options
 */
void displayMenu()
{
    cout << endl;
    cout << "Select a numerical option:" << endl;
    cout << "+=====Main Menu=========+" << endl;
    cout << " 1. Build Network " << endl;
    cout << " 2. Print Network Path " << endl;
    cout << " 3. Transmit Message " << endl;
    cout << " 4. Add Country " << endl;
    cout << " 5. Delete Country " << endl;
    cout << " 6. Reverse Network" << endl;
    cout << " 7. Clear Network " << endl;
    cout << " 8. Quit " << endl;
    cout << "+-----------------------+" << endl;
    cout << "#> ";
}
