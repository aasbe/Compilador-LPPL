/*****************************************************************************/
/* Analizador lexico de MenosC                                               */
/*****************************************************************************/
%{
#include <stdio.h>
#include "header.h"
#include "asin.tab.h"
#define retornar(token) return (token)
%}

%option noinput nounput yylineno noyywrap

delimitador    [ \t\r\n]+
letra          [a-zA-Z]
digito         [0-9]
entero         {digito}+
real           {digito}+([.,]{digito}+)
identificador  {letra}({letra}|{digito}|-)*

%%
{delimitador}   { /* Ignorar separadores */ }
"//"[^\n]*      { /* Ignorar comentarios hasta fin de linea */ }

"true"          { retornar(TRUE_); }
"false"         { retornar(FALSE_); }
"int"           { retornar(INT_); }
"bool"          { retornar(BOOL_); }
"return"        { retornar(RETURN_); }
"read"          { retornar(READ_); }
"print"         { retornar(PRINT_); }
"if"            { retornar(IF_); }
"else"          { retornar(ELSE_); }
"for"           { retornar(FOR_); }
"SWITCH"        { retornar(SWITCH_); }
"LESS"          { retornar(LESS_); }
"EQUAL"         { retornar(EQUAL_); }
"GREATER"       { retornar(GREATER_); }

"&&"            { retornar(AND_); }
"||"            { retornar(OR_); }
"=="            { retornar(IGUAL_); }
"!="            { retornar(DISTINTO_); }
">="            { retornar(MAYORIGUAL_); }
"<="            { retornar(MENORIGUAL_); }
">"             { retornar(MAYOR_); }
"<"             { retornar(MENOR_); }
"="             { retornar(ASIG_); }
"+"             { retornar(MAS_); }
"-"             { retornar(MENOS_); }
"*"             { retornar(POR_); }
"/"             { retornar(DIV_); }
"!"             { retornar(NOT_); }
"("             { retornar(APAR_); }
")"             { retornar(CPAR_); }
"["             { retornar(ACORCH_); }
"]"             { retornar(CCORCH_); }
"{"             { retornar(ALLAVE_); }
"}"             { retornar(CLLAVE_); }
";"             { retornar(PYC_); }
","             { retornar(COMA_); }

{real}          { yyerror("Constante real no permitida en MenosC"); return YYUNDEF; }
{entero}        { retornar(CTE_); }
{identificador} { retornar(ID_); }
.               { yyerror("Caracter desconocido"); return YYUNDEF; }
%%
