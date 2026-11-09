#ifndef _HEADER_H
#define _HEADER_H

#include <stdio.h>

#define TRUE 1
#define FALSE 0

extern int yylex(void);
extern int yyparse(void);
extern FILE *yyin;
extern int yylineno;
extern char *yytext;

extern void yyerror(const char *msg);
extern int verbosidad;
extern int numErrores;

#endif
