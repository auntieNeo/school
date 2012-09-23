#include <stdlib.h>
#include <stdio.h>
#include <getopt.h>
#include <ctype.h>
#include <string.h>

struct my_struct {
  char something;
  unsigned char goats;
  char *substruct;
} blah;

const char *hex = "0123456789abcdef";

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

inline unsigned char sdes_permute_char(unsigned char c, const unsigned char *p, size_t count, size_t max);
inline unsigned short sdes_permute_short(unsigned short s, const unsigned char *p, size_t count, size_t max);
void sdes_subkeys(short unsigned int key, char *K_1, char *K_2);
inline unsigned char sdes_F(unsigned char R, unsigned char SK);
inline int sdes_encrypt(FILE *plaintext, FILE *ciphertext, short unsigned int key);
inline int sdes_decrypt(FILE *ciphertext, FILE *plaintext, short unsigned int key);
int sdes_core(FILE *input, FILE *output, short unsigned int key, int decrypt);

int parse_key(const char *str, unsigned short *key);

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

  // permute the 10-bit key
  p_key = sdes_permute_short(key, P10, P10_count, P10_max);

  // do a circular shift of each 5-bit half of the key
  p_key <<= 1;
  p_key |= (p_key & (1 << 5)) >> 5;
  p_key &= ~(1 << 5);
  p_key |= (p_key & (1 << 10)) >> 5;

  // permute the first 8-bit subkey
  *K_1 = sdes_permute_char(p_key, P8, P8_count, P8_max);

  // do another shift of 2 bits of each 5-bit half of the key
  p_key <<= 2;
  p_key |= (p_key & (0x3 << 5)) >> 5;
  p_key &= ~(0x3 << 5);
  p_key |= (p_key & (0x3 << 10)) >> 5;

  // permute the second 8-bit subkey
  *K_2 = sdes_permute_char(p_key, P8, P8_count, P8_max);
}

inline unsigned char sdes_F(unsigned char R, unsigned char SK)
{
  unsigned char R2, R3, R4;
  int i;
  unsigned char bit;
  unsigned char S0_row, S0_col, S1_row, S1_col;

  // expand/permute the low bit of R into RP
  R = sdes_permute_char(R, EP, EP_count, EP_max);

  // apply the subkey
  R ^= SK;

  // apply the S-boxes
  S0_row = S0_col = S1_row = S1_col = 0;
  S0_row = ((R & (1 << 7)) >> 6) | ((R & (1 << 4)) >> 4);
  S0_col = ((R & (1 << 6)) >> 5) | ((R & (1 << 5)) >> 5);
  S1_row = ((R & (1 << 3)) >> 2) | (R & 1);
  S1_col = ((R & (1 << 2)) >> 1) | ((R & (1 << 1)) >> 1);
  R = 0;
  R |= S0[S0_row][S0_col] << 2;
  R |= S1[S1_row][S1_col];

  // finally permute with P4
  R = sdes_permute_char(R, P4, P4_count, P4_max);

  return R;
}

inline int sdes_encrypt(FILE *plaintext, FILE *ciphertext, short unsigned int key)
{
  return sdes_core(plaintext, ciphertext, key, 0);
}

inline int sdes_decrypt(FILE *ciphertext, FILE *plaintext, short unsigned int key)
{
  return sdes_core(ciphertext, plaintext, key, 1);
}

int sdes_core(FILE *input, FILE *output, short unsigned int key, int decrypt)
{
  unsigned char K_1, K_2;
  int i, j;
  unsigned char F;
  unsigned char temp;
  unsigned char in, out;

  // get the subkeys
  if(decrypt)
    sdes_subkeys(key, &K_2, &K_1);
  else
    sdes_subkeys(key, &K_1, &K_2);

  // encrypt each 8 bit block
  while(fread(&in, 1, 1, input))
  {
    // apply the initial permutation
    out = sdes_permute_char(in, IP, IP_count, IP_max);

    // apply the f_k function using K_1
    // apply the mapping F to the lower 4 bits of the current output
    F = sdes_F(out, K_1);
    // xor the upper 4 bits of the output with the output of F
    out ^= F << 4;

    // apply the switch function for the smallest Feistel network ever
    temp = out;
    out <<= 4;
    out |= temp >> 4;

    // apply the f_k function again, but this time using K_2
    // apply the mapping F to the lower 4 bits of the current output
    F = sdes_F(out, K_2);
    // xor the upper 4 bits of the output with the output of F
    out ^= F << 4;

    // apply the inverse of the initial permutation
    out = sdes_permute_char(out, IP_inverse, IP_inverse_count, IP_inverse_max);

    // write the output to the file stream
    if(fwrite(&out, 1, 1, output) != 1)
    {
      fprintf(stderr, "Error writing to file.");
      return 1;
    }
  }
  if(ferror(input))
  {
    fprintf(stderr, "Error reading from file.");
    return 1;
  }
  return 0;
}

void usage(int status)
{
}

int parse_key(const char *str, unsigned short *key)
{
  int i, j;
  char c;

  for(i = 0; str[i] != '\0'; i++)
  {
    switch(i)
    {
      case 0:
        if(str[i] != '0')
          return 1;
        break;
      case 1:
        if(str[i] != 'x')
          return 1;
        break;
      case 2:
        c = tolower(str[i]);
        for(j = 0; j < 16; j++)
          if(c == hex[j])
          {
            *key = j << 4;
            break;
          }
        if(j == 16)
          return 1;
        break;
      case 3:
        c = tolower(str[i]);
        for(j = 0; j < 16; j++)
          if(c == hex[j])
          {
            *key |= j;
            break;
          }
        if(j == 16)
          return 1;
        break;
      default:
        return 1;
    }
  }

  if(i != 4)
    return 1;

  return 0;
}

#define USAGE(status) do { \
  fprintf(stderr, "Usage: sdes [--encrypt|--decrypt] [-o output_file] -k secret_key input_file\n\n"); \
  fprintf(stderr, "   secret_key: 10 bit binary number written in hex. Example: 0x3F\n"); \
  free(output_filename); \
  exit(status); \
  } while (0) \

int main(int argc, char **argv)
{
  char *input_filename, *output_filename;
  FILE *input, *output;
  char opt;
  int encrypt, decrypt;
  unsigned short key;
  int key_provided;
  output_filename = NULL;
  input = stdin;
  output = stdout;
  encrypt = decrypt = 0;
  key_provided = 0;

  while(1)
  {
    static struct option long_options[] = {
      {"encrypt", no_argument, NULL, 'e'},
      {"decrypt", no_argument, NULL, 'd'},
      {"output", required_argument, NULL, 'o'},
      {"key", required_argument, NULL, 'k'},
      {0, 0, 0, 0}
    };

    opt = getopt_long(argc, argv, "edo:k:", long_options, NULL);

    if(opt == -1)
      break;

    switch(opt)
    {
      case 'e':
        encrypt = 1;
        break;
      case 'd':
        decrypt = 1;
        break;
      case 'o':
        if(output_filename != NULL)
          USAGE(EXIT_FAILURE);
        output_filename = malloc(strlen(optarg));
        strcpy(output_filename, optarg);
        break;
      case 'k':
        if(parse_key(optarg, &key))
          USAGE(EXIT_FAILURE);
        key_provided = 1;
        break;
      case '?':
        USAGE(EXIT_FAILURE);
        break;
    }
  }

  if(encrypt && decrypt)
    USAGE(EXIT_FAILURE);

  if(!key_provided)
    USAGE(EXIT_FAILURE);

  if(!encrypt && !decrypt)
    encrypt = 1;

  if(argc - optind > 1)
    USAGE(EXIT_FAILURE);

  if(argc - optind == 1)
  {
    input = fopen(argv[optind], "r");
    if(input == NULL)
    {
      fprintf(stderr, "Error opening input file for reading.");
      free(output_filename);
      exit(EXIT_FAILURE);
    }
  }

  if(output_filename != NULL && strcmp(output_filename, "-") != 0)
  {
    output = fopen(output_filename, "w");
    if(output == NULL)
    {
      fprintf(stderr, "Error opening output file for writing.");
      if(input != stdin)
        fclose(input);
      free(output_filename);
      exit(EXIT_FAILURE);
    }
  }
  free(output_filename);
  output_filename = NULL;


  if(encrypt)
    sdes_encrypt(input, output, key);
  else
    sdes_decrypt(input, output, key);

  if(input != stdin)
    fclose(input);
  if(output != stdout)
    fclose(output);

  exit(EXIT_SUCCESS);
}
