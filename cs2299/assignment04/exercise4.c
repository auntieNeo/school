#include <stdio.h>

int main(int argc, char **argv)
{
  printf("0x%08X\n",  (0x55555555 << 4) | 0x12345678);
  printf("0x%08X\n",  (0xBEADFEED << 4) | 0xDEADFADE);
  return 0;
}
