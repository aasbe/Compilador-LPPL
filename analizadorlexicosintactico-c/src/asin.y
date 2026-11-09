/* Gramatica de MenosC, transcrita de la Figura 1 del enunciado. */
%{
#include "header.h"
%}

%defines
%start programa

%token ID_ CTE_
%token INT_ BOOL_ TRUE_ FALSE_ RETURN_ READ_ PRINT_ IF_ ELSE_ FOR_
%token SWITCH_ LESS_ EQUAL_ GREATER_
%token AND_ OR_ IGUAL_ DISTINTO_ MAYORIGUAL_ MENORIGUAL_ MAYOR_ MENOR_
%token ASIG_ MAS_ MENOS_ POR_ DIV_ NOT_
%token APAR_ CPAR_ ACORCH_ CCORCH_ ALLAVE_ CLLAVE_ PYC_ COMA_

%%
programa       : listDecla ;
listDecla      : decla
               | listDecla decla ;
decla          : declaVar
               | declaFunc ;
declaVar       : tipoSimp ID_ PYC_
               | tipoSimp ID_ ASIG_ constante PYC_
               | tipoSimp ID_ ACORCH_ CTE_ CCORCH_ PYC_ ;
constante      : CTE_
               | TRUE_
               | FALSE_ ;
tipoSimp       : INT_
               | BOOL_ ;
declaFunc      : tipoSimp ID_ APAR_ paramForm CPAR_ bloque ;
paramForm      : /* vacio */
               | listParamForm ;
listParamForm  : tipoSimp ID_
               | tipoSimp ID_ COMA_ listParamForm ;
bloque         : ALLAVE_ declaVarLocal listInst RETURN_ expre PYC_ CLLAVE_ ;
declaVarLocal  : /* vacio */
               | declaVarLocal declaVar ;
listInst       : /* vacio */
               | listInst inst ;
inst           : ALLAVE_ listInst CLLAVE_
               | instExpre
               | instEntSal
               | instSelec
               | instIter
               | instSwitch ;
instSwitch     : SWITCH_ ID_ ALLAVE_ Less Equal Greater CLLAVE_ ;
Less           : LESS_ inst ;
Equal          : EQUAL_ inst ;
Greater        : GREATER_ inst ;
instExpre      : expre PYC_
               | PYC_ ;
instEntSal     : READ_ APAR_ ID_ CPAR_ PYC_
               | PRINT_ APAR_ expre CPAR_ PYC_ ;
instSelec      : IF_ APAR_ expre CPAR_ inst ELSE_ inst ;
instIter       : FOR_ APAR_ expreOP PYC_ expre PYC_ expreOP CPAR_ inst ;
expreOP        : /* vacio */
               | expre ;
expre          : expreLogic
               | ID_ ASIG_ expre
               | ID_ ACORCH_ expre CCORCH_ ASIG_ expre ;
expreLogic     : expreIgual
               | expreLogic opLogic expreIgual ;
expreIgual     : expreRel
               | expreIgual opIgual expreRel ;
expreRel       : expreAd
               | expreRel opRel expreAd ;
expreAd        : expreMul
               | expreAd opAd expreMul ;
expreMul       : expreUna
               | expreMul opMul expreUna ;
expreUna       : expreSufi
               | opUna expreUna ;
expreSufi      : constante
               | APAR_ expre CPAR_
               | ID_
               | ID_ ACORCH_ expre CCORCH_
               | ID_ APAR_ paramAct CPAR_ ;
paramAct       : /* vacio */
               | listParamAct ;
listParamAct   : expre
               | expre COMA_ listParamAct ;
opLogic        : AND_
               | OR_ ;
opIgual        : IGUAL_
               | DISTINTO_ ;
opRel          : MAYOR_
               | MENOR_
               | MAYORIGUAL_
               | MENORIGUAL_ ;
opAd           : MAS_
               | MENOS_ ;
opMul          : POR_
               | DIV_ ;
opUna          : MAS_
               | MENOS_
               | NOT_ ;
%%
