#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

struct my_struct {
  char something;
  unsigned char goats;
  char *substruct;
} blah;

// permutation for the 10-bit key
const unsigned char P10[10] = {3, 5, 2, 7, 4, 10, 1, 9, 8, 6};
const size_t P10_count = 10;
const size_t P10_max = 10;
// permutation for the 8-bit subkeys
const unsigned char P8[8] = {6, 3, 7, 4, 8, 5, 10, 9};
const size_t P8_count = 8;
const size_t P8_max = 10;
// initial permutation and inverse of that
const unsigned char IP[8] = {2, 6, 3, 1, 4, 8, 5, 7};
const size_t IP_count = 8;
const size_t IP_max = 8;
const unsigned char IP_inverse[8] = {4, 1, 3, 5, 7, 2, 8, 6};
const size_t IP_inverse_count = 8;
const size_t IP_inverse_max = 8;
// expansion/permutation operation for F
const unsigned char EP[8] = {4, 1, 2, 3, 2, 3, 4, 1};
const size_t EP_count = 8;
const size_t EP_max = 4;
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
const size_t P4_count = 4;
const size_t P4_max = 4;

inline unsigned char sdes_F(unsigned char R, unsigned char SK);
void sdes_subkeys(short unsigned int key, char *K_1, char *K_2);
void sdes_encrypt(const unsigned char *plaintext, unsigned char *ciphertext, size_t blocks, short unsigned int key);
void sdes_decrypt(unsigned char *plaintext, const unsigned char *ciphertext, size_t blocks, short unsigned int key);
inline unsigned char sdes_permute_char(unsigned char c, const unsigned char *p, size_t count, size_t max);
inline unsigned short sdes_permute_short(unsigned short s, const unsigned char *p, size_t count, size_t max);

inline unsigned char sdes_F(unsigned char R, unsigned char SK)
{
  unsigned char R2, R3, R4;
  int i;
  unsigned char bit;
  unsigned char S0_row, S0_col, S1_row, S1_col;

  printf("R: 0x%02X\n", R);
  // expand/permute the low bit of R into RP
  R = sdes_permute_char(R, EP, EP_count, EP_max);
  printf("after EP: 0x%02X\n", R);

  // apply the subkey
  R ^= SK;
  printf("XOR with key\nR: 0x%02X\n", R);

  // apply the S-boxes
  S0_row = S0_col = S1_row = S1_col = 0;
  S0_row = ((R & (1 << 7)) >> 6) | ((R & (1 << 4)) >> 4);
  S0_col = ((R & (1 << 6)) >> 5) | ((R & (1 << 5)) >> 5);
  S1_row = ((R & (1 << 3)) >> 2) | (R & 1);
  S1_col = ((R & (1 << 2)) >> 1) | ((R & (1 << 1)) >> 1);
  printf("S0_row: 0x%02X\n", S0_row);
  printf("S0_col: 0x%02X\n", S0_col);
  printf("S1_row: 0x%02X\n", S1_row);
  printf("S1_col: 0x%02X\n", S1_col);
  R = 0;
  R |= S0[S0_row][S0_col] << 2;
  R |= S1[S1_row][S1_col];
  printf("apply S-Boxes\nR: 0x%02X\n", R);

  // finally permute with P4
  R = sdes_permute_char(R, P4, P4_count, P4_max);

  return R;
}

inline unsigned char sdes_permute_char(unsigned char c, const unsigned char *p, size_t count, size_t max)
{
  int i;
  unsigned char result = 0;
  for(i = 0; i < count; i++)
  {
    result <<= 1;
    result |= (c >> (max - p[i])) & 1;
  }
  return result;
}

inline unsigned short sdes_permute_short(unsigned short s, const unsigned char *p, size_t count, size_t max)
{
  int i;
  unsigned short result = 0;
  for(i = 0; i < count; i++)
  {
    result <<= 1;
    result |= (s >> (max - p[i])) & 1;
  }
  return result;
}

void sdes_subkeys(short unsigned int key, char *K_1, char *K_2)
{
  short unsigned int p_key;
  unsigned char bit;
  int i;

//  printf("key: 0x%04X\n", key);
  // TODO: put a lot of this stuff in macros
  // permute the 10-bit key
  p_key = sdes_permute_short(key, P10, P10_count, P10_max);
  printf("permute 10-bit key\np_key: 0x%04X\n", p_key);

  // do a circular shift of each 5-bit half of the key
  p_key <<= 1;
  p_key |= (p_key & (1 << 5)) >> 5;
  p_key &= ~(1 << 5);
  p_key |= (p_key & (1 << 10)) >> 5;
  printf("circular shift\np_key: 0x%04X\n", p_key);

  // permute the first 8-bit subkey
  *K_1 = sdes_permute_char(p_key, P8, P8_count, P8_max);

  // do another shift of 2 bits of each 5-bit half of the key
  p_key <<= 2;
  p_key |= (p_key & (0x3 << 5)) >> 5;
  p_key &= ~(0x3 << 5);
  p_key |= (p_key & (0x3 << 10)) >> 5;
  printf("circular shift\np_key: 0x%04X\n", p_key);

  // permute the second 8-bit subkey
  *K_2 = sdes_permute_char(p_key, P8, P8_count, P8_max);
}

void sdes_encrypt(const unsigned char *plaintext, unsigned char *ciphertext, size_t blocks, short unsigned int key)
{
  unsigned char K_1, K_2;
  unsigned char bit;
  int i, j;
  unsigned char F;
  unsigned char temp;

  printf("ENCRYPT\n");

  // get the subkeys
  sdes_subkeys(key, &K_1, &K_2);
  printf("K_1: 0x%02X  K_2: 0x%02X\n", K_1, K_2);

  // encrypt each 8 bit block
  for(i = 0; i < blocks; i++)
  {
    printf("plaintext[%d]: 0x%02X\n", i, plaintext[i]);
    // apply the initial permutation
    ciphertext[i] = sdes_permute_char(plaintext[i], IP, IP_count, IP_max);
    printf("IP\nciphertext[%d]: 0x%02X\n", i, ciphertext[i]);

    // apply the f_k function using K_1
    // apply the mapping F to the lower 4 bits of the current ciphertext
    F = sdes_F(ciphertext[i], K_1);
    printf("F: 0x%02X\n", F);
    // xor the upper 4 bits of the ciphertext with the output of F
    ciphertext[i] ^= F << 4;
    printf("xor F on upper bits\nciphertext[%d]: 0x%02X\n", i, ciphertext[i]);

    // apply the switch function for the smallest Feistel network ever
    temp = ciphertext[i];
    ciphertext[i] <<= 4;
    ciphertext[i] |= temp >> 4;
    printf("switch\nciphertext[%d]: 0x%02X\n", i, ciphertext[i]);

    // apply the f_k function again, but this time using K_2
    // apply the mapping F to the lower 4 bits of the current ciphertext
    F = sdes_F(ciphertext[i], K_2);
    printf("F: 0x%02X\n", F);
    // xor the upper 4 bits of the ciphertext with the output of F
    ciphertext[i] ^= F << 4;
    printf("xor F on upper bits\nciphertext[%d]: 0x%02X\n", i, ciphertext[i]);

    printf("E2: 0x%02X\n", ciphertext[i]);

    // apply the inverse of the initial permutation
    ciphertext[i] = sdes_permute_char(ciphertext[i], IP_inverse, IP_inverse_count, IP_inverse_max);
    printf("first byte: 0x%02X\n", ciphertext[i]);

    return;
  }
}

void sdes_decrypt(unsigned char *plaintext, const unsigned char *ciphertext, size_t blocks, short unsigned int key)
{
  unsigned char K_1, K_2;
  unsigned char bit;
  int i, j;
  unsigned char F;
  unsigned char temp;

  printf("DECRYPT\n");

  // get the subkeys
  sdes_subkeys(key, &K_1, &K_2);

  // decrypt each 8 bit block
  for(i = 0; i < blocks; i++)
  {
    printf("D0: 0x%02X\n", ciphertext[i]);
//    printf("ciphertext[%d]: 0x%02X\n", i, ciphertext[i]);
    // apply the initial permutation
    plaintext[i] = 0;
    for(j = 0; j < 8; j++)
    {
      bit = (ciphertext[i] & (1 << (IP[j] - 1))) >> (IP[j] - 1);
      plaintext[i] |= bit << j;
    }
//    printf("initial permutation\nplaintext[%d]: 0x%02X", i, plaintext[i]);

    printf("D1: 0x%02X\n", plaintext[i]);

    // apply the f_k function using K_2
    // apply the mapping F to the lower 4 bits of the current plaintext
    F = sdes_F(plaintext[i], K_2);
    // xor the upper 4 bits of the plaintext with the output of F
    plaintext[i] ^= F << 4;

    // apply the switch function for the smallest Feistel network ever
    temp = plaintext[i];
    plaintext[i] <<= 4;
    plaintext[i] |= temp >> 4;

    // apply the f_k function again, but this time using K_1
    // apply the mapping F to the lower 4 bits of the current plaintext
    F = sdes_F(plaintext[i], K_2);
    // xor the upper 4 bits of the plaintext with the output of F
    plaintext[i] ^= F << 4;
//    printf("f_k function: 0x%02X\n", plaintext[i]);

    printf("D2: 0x%02X\n", plaintext[i]);

    // apply the inverse of the initial permutation
    temp = plaintext[i];
    plaintext[i] = 0;
    for(j = 0; j < 8; j++)
    {
      bit = (temp & (1 << j)) >> j;
      plaintext[i] |= bit << (IP[j] - 1);
    }
//    printf("first byte: 0x%02X\n", plaintext[i]);

    printf("D3: 0x%02X\n", plaintext[i]);

    return;
  }
}

/*
void test()
{
  unsigned char F;
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
}
*/

int main(int argc, char **argv)
{
  char *ciphertext, *plaintext;

  ciphertext = malloc(7);
  plaintext = malloc(7);
  sdes_encrypt("\x39range", ciphertext, 7, 0x02f2);
  sdes_decrypt(plaintext, ciphertext, 7, 0x0282);
//  printf("decrypted: %c\n", *plaintext);
  free(plaintext);
  free(ciphertext);

//  printf("sdes_F: %02X", sdes_F(0x0D, 0xAA));
  return 0;
}
