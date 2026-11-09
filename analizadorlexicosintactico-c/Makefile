CC = gcc
FLEX = flex
BISON = bison
SRCDIR = src
INCDIR = include
CFLAGS = -Wall -Wextra -I$(INCDIR) -I.
OBJS = alex.o asin.tab.o principal.o

.PHONY: all clean
all: cmc

cmc: $(OBJS)
	$(CC) $(OBJS) -o $@

principal.o: $(SRCDIR)/principal.c $(INCDIR)/header.h
	$(CC) $(CFLAGS) -c $< -o $@

alex.o: alex.c asin.tab.h $(INCDIR)/header.h
	$(CC) $(CFLAGS) -c alex.c -o $@

asin.tab.o: asin.tab.c asin.tab.h $(INCDIR)/header.h
	$(CC) $(CFLAGS) -c asin.tab.c -o $@

alex.c: $(SRCDIR)/alex.l asin.tab.h
	$(FLEX) -o $@ $<

# Generar parser y cabecera conjuntamente.
asin.tab.c asin.tab.h &: $(SRCDIR)/asin.y
	$(BISON) -d -o asin.tab.c $<

clean:
	rm -f cmc alex.c asin.tab.c asin.tab.h *.o
