#include "RPNCalculator.hpp"
#include <iostream>
#include <iomanip>

using namespace std;

bool isNumber(string s);

int main()
{
  RPNCalculator rpn;

  string uins;
  float result;

  cout << "Enter the operators and operands ('+', '*') in a postfix format" << endl;

  while(uins != "=")
  {
    cout << "#> ";
    getline(cin, uins);

    if (uins != "="){
      if (isNumber(uins)){
        rpn.push(std::stof(uins));
      }else{
        rpn.compute(uins);
      }

    }
  }

  if (rpn.isEmpty()){
    cout << "No operands: Nothing to evaluate\n";
    return 0;
  }

  result = rpn.peek()->number;
  rpn.pop();

  if (rpn.isEmpty()){
    printf("%.4g", result);
    cout << "\n";
  }else{
    cout << "Invalid expression\n";
  }

  return 0;
}

bool isNumber(string s){
    if(s.size() == 1 && s == "-") return false;
    else if(s.size() > 1 && s[0] == '-') s = s.substr(1);

    bool point = false;
    for(int i = 0; i < s.size(); i++)
    {
      if(!isdigit(s[i]) && s[i] != '.') return false;
      if(s[i]=='.' and !point) point = true;
      else if(s[i]=='.' and point) return false;
    }

    return true;
}
