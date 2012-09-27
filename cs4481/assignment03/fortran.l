%{
#include <stdio.h>
#include <assert.h>
#define GROW_TOKENS_DELTA 42

  struct Token {
    int type;
    void *value;
  };


  Token *tokens;
  size_t num_tokens, size_tokens;

  Token_destroy(Token *t);

  void add_token(Token t);
  void grow_tokens();
  void print_tokens();

  /**
   * Adds a token to the singleton stack of tokens. add_token assumes ownership
   * of the token's memory.
   */
  void add_token(Token t)
  {
    if(num_tokens == size_tokens)
      grow_tokens();

    tokens[num_tokens] = t;
  }

  void grow_tokens()
  {
    Token *new_tokens = malloc((size_tokens + GROW_TOKENS_DELTA) * sizeof(Token));
    memcpy(new_tokens, tokens, num_tokens * sizeof(Token));
    free(tokens);
    tokens = new_tokens;
  }

  void print_tokens()
  {
    int i;
    for(i = 0; i < num_tokens; i++)
    {
      printf
    }

  }
%}
IDENTIFIER [a-zA-Z][0-9a-zA-Z]*

INTEGER [0-9]+

REAL {INTEGER}\.{INTEGER}{EXPONENT}?
EXPONENT {EXP_DESIGNATOR}[+-]?{INTEGER}
EXP_DESIGNATOR [eE]

UNARY_OPERATOR [+-]
MULT_OPERATOR ([*/]|div|mod|and)
ADD_OPERATOR ([+-)|or)
RELATION (=|<>|<|>|<=|>=|in)

%%
{IDENTIFIER} { printf("IDENTIFIER"); }
{REAL} { printf("REAL"); }

%%
int main(int argc, char **argv)
{
  tokens = malloc(sizeof(Token) * GROW_TOKENS_DELTA);
  yylex();
  free(tokens);
  return 0;
}
