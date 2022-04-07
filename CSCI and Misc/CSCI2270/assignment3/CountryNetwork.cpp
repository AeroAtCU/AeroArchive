/****************************************************************/
/*                CountryNetwork Implementation                 */
/****************************************************************/
/* TODO: Implement the member functions of class CountryNetwork */
/*     This class uses a linked-list of Country structs to      */
/*     represet communication paths between nations             */
/****************************************************************/

#include "CountryNetwork.hpp"

using namespace std;

/*
 * Purpose: Constructer for empty linked list
 * @param none
 * @return none
 */
CountryNetwork::CountryNetwork(){
  head = NULL;
}

bool CountryNetwork::isEmpty()
{
  if (head == NULL){
    return true;
  }
  return false;

}

void CountryNetwork::insertCountry(Country* previous, string countryName){

Country *toInsert = new Country; // Create a new blank country
toInsert->name = countryName; // Fill in some data
toInsert->numberMessages = 0; // Fill in some data

Country *tmp = new Country;

if (previous == NULL){ // insert before head (Or to empty array?)
  cout << "adding: " << countryName << " (HEAD)" << endl;
  toInsert->next = head;
  head = toInsert;
  return;
}

if (previous->next == NULL){ // insert to end
  cout << "adding: " << countryName << " (prev: " << previous->name << ")" << endl;
  previous->next = toInsert;
  toInsert->next = NULL;
  return;
}

// If all the above are false it must be in the middle.
cout << "adding: " << countryName << " (prev: " << previous->name << ")" << endl;
toInsert->next = previous->next;
previous->next = toInsert;
return;
}


/*
 * Purpose: delete the country in the network with the specified name.
 * @param countryName name of the country to delete in the network
 * @return none
 */
void CountryNetwork::deleteCountry(string countryName){
  Country *prev = new Country;
  prev = head;
  
  if (prev->name == countryName){ // deleting head
    head = prev->next;
    return;
  }
  
  while((prev->next) != NULL && (prev->next)->name != countryName){
    prev = prev->next;
  }
  
  if (prev->next == NULL){ // deleting nonexistent element (was not found so points to NULL)
    cout << "Country does not exist." << endl;
    return;
  }
  
  if ((prev->next)->next == NULL){ // deleting nonexistent element (was not found so points to NULL)
    prev->next = NULL;
    return;
  }
  
  // Now must exist in middle
  prev->next = (prev->next)->next;
  
  return;
}

/*
 * Purpose: populates the network with the predetermined countries
 * @param none
 * @return none
 */
void CountryNetwork::loadDefaultSetup(){
    CountryNetwork::deleteEntireNetwork();
    insertCountry(NULL, "United States");
    insertCountry(CountryNetwork::searchNetwork("United States"), "Canada");
    insertCountry(CountryNetwork::searchNetwork("Canada"), "Brazil");
    insertCountry(CountryNetwork::searchNetwork("Brazil"), "India");
    insertCountry(CountryNetwork::searchNetwork("India"), "China");
    insertCountry(CountryNetwork::searchNetwork("China"), "Australia");
}

/*
 * Purpose: Search the network for the specified country and return a pointer to that node
 * @param countryName name of the country to look for in network
 * @return pointer to node of countryName, or NULL if not found
 * @see insertCountry, deletecountry
 */
Country* CountryNetwork::searchNetwork(string countryName){
  Country *prev = new Country;
  prev = head;
  
  if (head==NULL) { // is list exist
    return NULL;
  }
  
  if (prev->name == countryName){ // is head
    return head;
  }

  while (prev->next != NULL) { // Go untill prev.next is null
    if (prev->name == countryName) {
      return prev;
    }
    prev = prev->next;
  }
  
  if (prev->name == countryName) { // see if last prev before null is countryname
    return prev;
  }

  return NULL; // if not all that then it's not in the list 
}

/*
 * Purpose: deletes all countries in the network starting at the head country.
 * @param none
 * @return none
 */
void CountryNetwork::deleteEntireNetwork()
{
  Country *prev = new Country;
  prev = head;
  
  while (head != NULL){
  cout << "deleting: " << head->name << endl;
    deleteCountry(head->name);
  }
  
  cout << "Deleted network" << endl; 
  return;
}


/*
 * Purpose: Transmit a message across the network to the
 *   receiver. Msg should be stored in each country it arrives
 *   at, and should increment that country's count.
 * @param receiver name of the country to receive the message
 * @param message the message to send to the receiver
 * @return none
 */
void CountryNetwork::transmitMsg(string reciever, string msg){
    Country *curr = new Country;
    Country *tmp = new Country;
    tmp = searchNetwork(reciever);
    curr = head;
    
    if ((isEmpty()) || (tmp == NULL)){
        return;
    }
    
    // At this point there is at least one element in array w/ name of receiver
    
    while (curr != NULL){ // should be impossible not to stop so idk
        if (curr->name == reciever){
            curr->message = msg;
            curr->numberMessages++;
            cout << curr->name << " [# messages received: " << curr->numberMessages << "] received: " << curr->message << endl; 
            return;
        } else {
            curr->message = msg;
            curr->numberMessages++;
            cout << curr->name << " [# messages received: " << curr->numberMessages << "] received: " << curr->message << endl; 
            curr = curr->next;
        }
    }
    
    return;
    
}

/*
 * Purpose: prints the current list nicely
 * @param ptr head of list
 */
void CountryNetwork::printPath()
{
  Country *curr = new Country;
  curr = head;

  if (CountryNetwork::isEmpty()){
    cout << "nothing in path" << endl;
    return;
  }

  cout << "== CURRENT PATH ==" << endl;

  for (int i=0;i<20;i++){
    if (curr != NULL){
      cout << curr->name << " -> ";
      curr = curr->next;
    }else{
      cout << " NULL" << endl << "===" << endl;
      return;
    }
  }
  return;

  cout << " NULL" << endl << "===" << endl;
  return;
}


/*
 * Purpose: reverse the entire network t
 * @param ptr head of list
 */
void CountryNetwork::reverseEntireNetwork(){
  Country *curr = head;
  Country *prev = NULL;
  Country *next = NULL;

  while (curr != NULL){ // go until current position is end of orig list
    next = curr->next; // save location of next
    curr->next = prev; // point to one behind

    prev = curr; // go to next position
    curr = next;
  }
  head = prev; // by now you're at end and just have to reset head.
  

}
