#include <stdio.h>
#include <assert.h>

// permutation for the 10-bit key
const unsigned char P10[10] = {3, 5, 2, 7, 4, 10, 1, 9, 8, 6};
// permutation for the 8-bit subkeys
const unsigned char P8[8] = {6, 3, 7, 4, 8, 5, 10, 9};

void sdes_encrypt(unsigned char *plaintext, size_t plaintext_blocks, short unsigned int key);
void sdes_decrypt(unsigned char *ciphertext, size_t ciphertext_blocks, short unsigned int key);

void sdes_encrypt(unsigned char *plaintext, size_t plaintext_blocks, short unsigned int key)
{
  char K_1, K_2;
  short unsigned int p_key;
  unsigned char bit;
  int i;

  printf("key: 0x%04X\n", key);
  // TODO: put a lot of this stuff in macros
  // permute the 10-bit key
  p_key = 0;
  for(i = 0; i < 10; i++)
  {
    bit = (key & (1 << (P10[i] - 1))) >> (P10[i] - 1);
    p_key |= bit << i;
  }
  printf("permute 10-bit key\np_key: 0x%04X\n", p_key);
  // do a circular shift of each 5-bit half of the key
  p_key <<= 1;
  p_key |= (p_key & (1 << 5)) >> 5;
  p_key &= ~(1 << 5);
  p_key |= (p_key & (1 << 10)) >> 5;
  printf("circular shift\np_key: 0x%04X\n", p_key);
  // permute the first 8-bit subkey
  K_1 = 0;
  for(i = 0; i < 8; i++)
  {
    bit = (p_key & (1 << (P8[i] - 1))) >> (P8[i] - 1);
    K_1 |= bit << i;
  }
  printf("permute first subkey\nK_1: 0x%04X\n", K_1);
  // do another shift of each 5-bit half of the key
  p_key <<= 1;
  p_key |= (p_key & (1 << 5)) >> 5;
  p_key &= ~(1 << 5);
  p_key |= (p_key & (1 << 10)) >> 5;
  printf("second circular shift\np_key: 0x%04X\n", p_key);
  // permute the second 8-bit subkey
  K_2 = 0;
  for(i = 0; i < 8; i++)
  {
    bit = (p_key & (1 << (P8[i]))) >> P8[i];
    K_2 |= bit << i;
  }
  printf("permute second subkey\n");
  assert(sizeof(short unsigned int) == 2);
  printf("p_key: 0x%04X\n", p_key);
  printf("K_1: 0x%04X\n", K_1);
  printf("K_2: 0x%04X\n", K_2);

  for(i = 0; i < plaintext_blocks; i++)
  {
  }
}

int main(int argc, char **argv)
{
  sdes_encrypt(NULL, 0, 0x0282);
  return 0;
}
