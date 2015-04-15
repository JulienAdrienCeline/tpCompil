#!bin/bash
llc resultat.ll -o resultat.s
gcc resultat.s -o resultat.native
./resultat.native
