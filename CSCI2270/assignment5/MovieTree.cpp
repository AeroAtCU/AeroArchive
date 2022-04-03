#include "MovieTree.hpp"
#include <string>
#include <iostream>

namespace hfun { // Helper Functions
  void pInOrder(MovieNode* tmp){ // Print node recurrsively (personally made)
    if (tmp == nullptr)
      return;
    pInOrder(tmp->leftChild);
    std::cout << "Movie: " << tmp->title << " " << tmp->rating << "\n";
    pInOrder(tmp->rightChild);
    return;
  }

  float sumRatings(MovieNode* tmp){ // Print node recurrsively (personally made)
    if (tmp == nullptr)
      return 0.0;
    float lsum = sumRatings(tmp->leftChild);
    float rsum = sumRatings(tmp->rightChild);
    return lsum + rsum + tmp->rating;
  }
  
  float getNumMovies(MovieNode* tmp){ // Print node recurrsively (personally made)
    if (tmp == nullptr)
      return 0.0;
    float lsum = getNumMovies(tmp->leftChild);
    float rsum = getNumMovies(tmp->rightChild);
    return lsum + rsum + 1;
  }

  void pPreOrder(MovieNode* tmp, float rating, int year){
    if (tmp == nullptr)
      return;
    if (tmp->rating >= rating && tmp->year >= year)
      std::cout << tmp->title << "(" << tmp->year << ") " << tmp->rating << "\n";

    pPreOrder(tmp->leftChild, rating, year);
    pPreOrder(tmp->rightChild, rating, year);
    return;
  }
}

MovieTree::MovieTree(){
  root = nullptr;
}

MovieTree::~MovieTree(){
}

void MovieTree::averageRating(){
  float sum = hfun::sumRatings(root);
  float num = hfun::getNumMovies(root);
  if (sum == 0)
    num = 1;

  std::cout << "Average rating:" << sum/num << "\n";
  return;
}

void MovieTree::queryMovies(float rating, int year){
  std::cout << "Movies that came out after " << year << " with rating at least " << rating << ":\n";
  hfun::pPreOrder(root, rating, year);
}

void MovieTree::printMovieInventory(){
  hfun::pInOrder(root);
}

void MovieTree::addMovieNode(int ranking, std::string title, int year, float rating){
  MovieNode* ti = new MovieNode; // ti "toInsert"
  // Setup ti with defualt and given values
  ti->ranking = ranking;
  ti->title = title;
  ti->year = year;
  ti->rating = rating;
  ti->rightChild = nullptr;
  ti->leftChild = nullptr;
  ti->parent = nullptr;

  if (root == nullptr){
    root = ti;
    return;
  }

  MovieNode* tmp = root;
  bool inserted = false;

  while (!inserted){
    if (ti->title < tmp->title){ // String alphabetically before tmp.
      if (tmp->leftChild == nullptr){ // If left is open, insert
        tmp->leftChild = ti;
        ti->parent = tmp;
        inserted = true;
      }else{ // Left not open (but ti goes to left) so move left
        tmp = tmp->leftChild;
      }
    }else{
      if (tmp->rightChild == nullptr){ // If left open, insert
        tmp->rightChild = ti;
        ti->parent = tmp;
        inserted = true;
      }else{
        tmp = tmp->rightChild;
      }
    }
  }
  return;
}

void MovieTree:: findMovie(std::string title){
  MovieNode* tmp = MovieTree::search(title);
  if (tmp == nullptr){
    std::cout << "Movie not found.\n";
    return;
  }

  std::cout << "Movie Info:" << "\n";
  std::cout << "==================" << "\n";
  std::cout << "Ranking:" << tmp->ranking << "\n";
  std::cout << "Title  :" << tmp->title << "\n";
  std::cout << "Year   :" << tmp->year << "\n";
  std::cout << "rating :" << tmp->rating <<"\n";
  return;
}

MovieNode* MovieTree::search(std::string title){
  // wanted to do this recurrsively but didn't know how at the time. not redoing it.
  MovieNode* tmp = root;
  bool found = false;

  if (tmp == nullptr)
    return nullptr;

  while(!found){
    if (tmp->title == title){ // if you're on the one you're looking for
      found = true;
    }else{ // not found, move tmp to appropriate place
           // or stop search if at bottom
      if (title < tmp->title){ // title on left
        if (tmp->leftChild == nullptr){ // if on bottom and not there, dne
          return nullptr;
        }else{ // not on bottom, keep seraching
          tmp = tmp->leftChild;
        }
      }else{ // tmp on right
        if (tmp->rightChild == nullptr){ // not @ bottm, dne
          return nullptr;
        }else{
          tmp = tmp->rightChild;
        }
      }
    }
  }
  return tmp;
}
