#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

// permutation for the 10-bit key
const unsigned char P10[10] = {3, 5, 2, 7, 4, 10, 1, 9, 8, 6};
// permutation for the 8-bit subkeys
const unsigned char P8[8] = {6, 3, 7, 4, 8, 5, 10, 9};
// initial permutation
const unsigned char IP[8] = {2, 6, 3, 1, 4, 8, 5, 7};
// expansion/permutation operation for F
const unsigned char EP[8] = {4, 1, 2, 3, 2, 3, 4, 1};
// S-boxes
const unsigned char S0[4][4] = {{1, 0, 3, 2},
                                {3, 2, 1, 0},
                                {0, 2, 1, 3},
                                {3, 1, 3, 2}};
const unsigned char S1[4][4] = {{0, 1, 2, 3},
                                {2, 0, 1, 3},
                                {3, 0, 1, 0},
                                {2, 1, 0, 3}};
// after S-box permutation
const unsigned char P4[4] = {2, 4, 3, 1};

inline unsigned char sdes_F(unsigned char R, unsigned char SK);
void sdes_subkeys(short unsigned int key, char *K_1, char *K_2);
void sdes_encrypt(const unsigned char *plaintext, unsigned char *ciphertext, size_t blocks, short unsigned int key);
void sdes_decrypt(unsigned char *plaintext, const unsigned char *ciphertext, size_t blocks, short unsigned int key);

inline unsigned char sdes_F(unsigned char R, unsigned char SK)
{
  unsigned char R2, R3, R4;
  int i;
  unsigned char bit;
  unsigned char S0_row, S0_col, S1_row, S1_col;

  printf("R: 0x%02X\n", R);
  // expand/permute the low bit of R into RP
  R2 = 0;
  for(i = 0; i < 8; i++)
  {
    bit = (R & (1 << (EP[i] - 1))) >> (EP[i] - 1);
    R2 |= bit << i;
  }
  printf("R2: 0x%02X\n", R2);

  // apply the subkey
  R2 ^= SK;
  printf("subkey R2: 0x%02X\n", R2);

  // apply the S-boxes
  S0_row = S0_col = S1_row = S1_col = 0;
  S0_row = ((R2 & 1) << 1) | ((R2 & (1 << 3)) >> 3);
  S0_col = (R2 & (1 << 1)) | ((R2 & (1 << 2)) >> 2);
  S1_row = ((R2 & (1 << 4)) >> 3) | ((R2 & (1 << 7)) >> 7);
  S1_col = ((R2 & (1 << 5)) >> 4) | ((R2 & (1 << 6)) >> 6);
  printf("test: 0x%02X\n", ((R2 & (1 << 6)) >> 6));
  printf("S0_row: 0x%02X\n", S0_row);
  printf("S0_col: 0x%02X\n", S0_col);
  printf("S1_row: 0x%02X\n", S1_row);
  printf("S1_col: 0x%02X\n", S1_col);
  R3 = 0;
  R3 |= S0[S0_row][S0_col];
  R3 |= S1[S1_row][S1_col] << 2;
  printf("R3: 0x%02X\n", R3);

  // finally permute with P4
  R4 = 0;
  for(i = 0; i < 4; i++)
  {
    bit = (R3 & (1 << (P4[i] - 1))) >> (P4[i] - 1);
    R4 |= bit << i;
  }
  printf("R4: 0x%02X\n", R4);

  return R4;
}

void sdes_subkeys(short unsigned int key, char *K_1, char *K_2)
{
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
  *K_1 = 0;
  for(i = 0; i < 8; i++)
  {
    bit = (p_key & (1 << (P8[i] - 1))) >> (P8[i] - 1);
    *K_1 |= bit << i;
  }
  printf("permute first subkey\nK_1: 0x%04X\n", *K_1);
  // do another shift of each 5-bit half of the key
  p_key <<= 1;
  p_key |= (p_key & (1 << 5)) >> 5;
  p_key &= ~(1 << 5);
  p_key |= (p_key & (1 << 10)) >> 5;
  printf("second circular shift\np_key: 0x%04X\n", p_key);
  // permute the second 8-bit subkey
  *K_2 = 0;
  for(i = 0; i < 8; i++)
  {
    bit = (p_key & (1 << (P8[i] - 1))) >> (P8[i] - 1);
    *K_2 |= bit << i;
  }
  printf("permute second subkey\n");
  assert(sizeof(short unsigned int) == 2);
  printf("p_key: 0x%04X\n", p_key);
  printf("K_1: 0x%04X\n", *K_1);
  printf("K_2: 0x%04X\n", *K_2);
}

void sdes_encrypt(const unsigned char *plaintext, unsigned char *ciphertext, size_t blocks, short unsigned int key)
{
  unsigned char K_1, K_2;
  unsigned char bit;
  int i, j;
  unsigned char F;
  unsigned char temp;

  // get the subkeys
  sdes_subkeys(key, &K_1, &K_2);

  // encrypt each 8 bit block
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

    // apply the f_k function using K_1
    // apply the mapping F to the lower 4 bits of the current ciphertext
    F = sdes_F(ciphertext[i], K_1);
    // xor the upper 4 bits of the ciphertext with the output of F
    ciphertext[i] ^= F << 4;

    // apply the switch function for the smallest Feistel network ever
    temp = ciphertext[i];
    ciphertext[i] <<= 4;
    ciphertext[i] |= temp >> 4;

    // apply the f_k function again, but this time using K_2
    // apply the mapping F to the lower 4 bits of the current ciphertext
    F = sdes_F(ciphertext[i], K_2);
    // xor the upper 4 bits of the ciphertext with the output of F
    ciphertext[i] ^= F << 4;

    printf("first byte: 0x%02X\n", ciphertext[i]);

    return;
  }
}

int main(int argc, char **argv)
{
  char *buffer;

  buffer = malloc(7);
  sdes_encrypt("orange", buffer, 7, 0x0282);
  free(buffer);

//  printf("sdes_F: %02X", sdes_F(0x0D, 0xAA));

  return 0;
}
