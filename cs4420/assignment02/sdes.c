#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

// permutation for the 10-bit key
const unsigned char P10[10] = {3, 5, 2, 7, 4, 10, 1, 9, 8, 6};
// permutation for the 8-bit subkeys
const unsigned char P8[8] = {6, 3, 7, 4, 8, 5, 10, 9};
// initial permutation
const unsigned char IP[8] = {2, 6, 3, 1, 4, 8, 5, 7};

void sdes_encrypt(const unsigned char *plaintext, unsigned char *ciphertext, size_t blocks, short unsigned int key);
void sdes_decrypt(unsigned char *plaintext, const unsigned char *ciphertext, size_t blocks, short unsigned int key);

void sdes_encrypt(const unsigned char *plaintext, unsigned char *ciphertext, size_t blocks, short unsigned int key)
{
  char K_1, K_2;
  short unsigned int p_key;
  unsigned char bit;
  int i, j;

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
    bit = (p_key & (1 << (P8[i] - 1))) >> (P8[i] - 1);
    K_2 |= bit << i;
  }
  printf("permute second subkey\n");
  assert(sizeof(short unsigned int) == 2);
  printf("p_key: 0x%04X\n", p_key);
  printf("K_1: 0x%04X\n", K_1);
  printf("K_2: 0x%04X\n", K_2);

  for(i = 0; i < blocks; i++)
  {
    printf("plaintext[%d]: 0x%02X\n", i, plaintext[i]);
    // apply the initial permutation
    ciphertext[i] = 0;
    for(j = 0; j < 8; j++)
    {
      bit = (plaintext[i] & (1 << (IP[j] - 1))) >> (IP[j] - 1);
      ciphertext[i] |= bit << j;
    }
    printf("initial permutation\nciphertext[%d]: 0x%02X", i, ciphertext[i]);

    // the function F_K

    return;
  }
}

int main(int argc, char **argv)
{
  char *buffer;

  buffer = malloc(7);
  sdes_encrypt("orange", buffer, 7, 0x0282);
  free(buffer);
  return 0;
}
