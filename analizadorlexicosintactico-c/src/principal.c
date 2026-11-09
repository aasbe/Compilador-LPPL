#include <stdio.h>
#include <string.h>
#include "header.h"

int verbosidad = FALSE;
int numErrores = 0;

void yyerror(const char *msg)
{
    numErrores++;
    fflush(stdout);
    fprintf(stderr, "Error en linea %d: %s (texto: '%s')\n",
            yylineno, msg, yytext ? yytext : "");
}

static void mostrarFuente(FILE *fichero)
{
    int c;
    int linea = 1;
    int alInicio = TRUE;

    rewind(fichero);
    while ((c = fgetc(fichero)) != EOF) {
        if (alInicio) {
            printf("%4d: ", linea);
            alInicio = FALSE;
        }
        putchar(c);
        if (c == '\n') {
            linea++;
            alInicio = TRUE;
        }
    }
    if (!alInicio) putchar('\n');
    rewind(fichero);
}

int main(int argc, char **argv)
{
    const char *nombreFichero = NULL;
    int i, resultado;

    for (i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-v") == 0) {
            verbosidad = TRUE;
        } else if (argv[i][0] == '-' || nombreFichero != NULL) {
            fprintf(stderr, "Uso: %s [-v] fichero\n", argv[0]);
            return 1;
        } else {
            nombreFichero = argv[i];
        }
    }
    if (!nombreFichero) {
        fprintf(stderr, "Uso: %s [-v] fichero\n", argv[0]);
        return 1;
    }
    yyin = fopen(nombreFichero, "r");
    if (!yyin) {
        perror(nombreFichero);
        return 1;
    }
    if (verbosidad) mostrarFuente(yyin);
    resultado = yyparse();
    fclose(yyin);
    return (resultado == 0 && numErrores == 0) ? 0 : 1;
}
