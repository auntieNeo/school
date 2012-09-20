#include <stdio.h>

int main(int argc, char **argv)
{
  const char *phrase = "COMPUTERLOGICDESIGN";
  const char *c = phrase;
  while(*c != '\0')
  {
    printf("0x%02X ", *c);
    c++;
  }
  printf("0x%02X", *c);
  printf("\n");
  return 0;
}
