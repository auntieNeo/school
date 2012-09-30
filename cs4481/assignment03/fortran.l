%{
#include <stdio.h>
#include <assert.h>
//#define GROW_TOKENS_DELTA 42
//
//  struct Token {
//    int type;
//    void *value;
//  };
//
//
//  Token *tokens;
//  size_t num_tokens, size_tokens;
//
//  Token_destroy(Token *t);
//
//  void add_token(Token t);
//  void grow_tokens();
//  void print_tokens();
//
//  /**
//   * Adds a token to the singleton stack of tokens. add_token assumes ownership
//   * of the token's memory.
//   */
//  void add_token(Token t)
//  {
//    if(num_tokens == size_tokens)
//      grow_tokens();
//
//    tokens[num_tokens] = t;
//  }
//
//  void grow_tokens()
//  {
//    Token *new_tokens = malloc((size_tokens + GROW_TOKENS_DELTA) * sizeof(Token));
//    memcpy(new_tokens, tokens, num_tokens * sizeof(Token));
//    free(tokens);
//    tokens = new_tokens;
//  }
//
//  void print_tokens()
//  {
//    int i;
//    for(i = 0; i < num_tokens; i++)
//    {
//      printf
//    }
//
//  }
%}
IDENTIFIER [a-zA-Z][0-9a-zA-Z]*

INTEGER [0-9]+

REAL {INTEGER}\.{INTEGER}{EXPONENT}?
EXPONENT {EXP_DESIGNATOR}[+-]?{INTEGER}
EXP_DESIGNATOR [eE]

OPERATOR ([+*/-]|div|mod|and)
RELATION (=|<>|<|>|<=|>=|in)

RESERVED (and|array|begin|case|const|div|do|downto|else|end|file|for|function|goto|if|in|label|mod|nil|not|of|or|packed|procedure|program|record|repeat|set|then|to|type|until|var|while|with)

STRING '[^']*'

LEFT_PAREN \(
RIGHT_PAREN \)

SEPARATOR ;

PROGRAM_END \.

%%
{STRING} { printf("<STRING>"); }
{LEFT_PAREN} { printf("<LEFT_PAREN>"); }
{RIGHT_PAREN} { printf("<RIGHT_PAREN>"); }
{RESERVED} { printf("<RESERVED>"); }
{IDENTIFIER} { printf("<IDENTIFIER>"); }
{REAL} { printf("<REAL>"); }
{OPERATOR} { printf("<OPERATOR>"); }
{RELATION} { printf("<RELATION>"); }
{SEPARATOR} { printf("<SEPARATOR>"); }
{PROGRAM_END} { printf("<PROGRAM_END>"); }
%%
int main(int argc, char **argv)
{
  yylex();
  return 0;
}
