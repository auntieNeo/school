#include <iostream>
using namespace std;

int main(int argc, char **argv)
{
  int badCount = 0;
  int goodCount = 0;
  for(int a = 0; a <= 25; a++)
    for(int b = 0; b <= 25; b++)
      for(int c = 0; c <= 25; c++)
        for(int d = 0; d <= 25; d++)
        {
          int det = (a * d) - (b * c);
          if(det % 2 == 0)
          {
            badCount++;
            continue;
          }
          if(det % 13 == 0)
          {
            badCount++;
            continue;
          }
          if(det % 26 == 0)
          {
            badCount++;
            continue;
          }
          goodCount++;
        }
  cout << "goodCount: " << goodCount << endl;
  cout << "badCount: " << badCount << endl;
  cout << "total: " << goodCount + badCount << endl;
  return 0;
}
