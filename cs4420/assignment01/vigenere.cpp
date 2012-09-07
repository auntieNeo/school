#include <iostream>
#include <string>
using namespace std;

std::string alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

int find_letter_number(char c)
{
  for(int i = 0; i < alphabet.length(); i++)
  {
    if(c == alphabet[i])
      return i;
  }
  return -1;
}

void print_viginere(const string &plain, const string &key)
{
  int key_index = 0;
  for(int i = 0; i < plain.length(); i++)
  {
    int cipher_letter = (find_letter_number(plain[i]) + find_letter_number(key[key_index])) % alphabet.length();
    key_index = (key_index + 1) % key.length();
    cout << alphabet[cipher_letter];
  }
  cout << endl;
}

int main(int argc, char **argv)
{
  print_viginere("EXPLANATION", "LEG");
  return 0;
}
