#!bin/bash
llc -march=x86 resultat.ll -o resultat.s
gcc resultat.s -o resultat.native
./resultat.native
