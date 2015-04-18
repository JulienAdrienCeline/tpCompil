#!bin/bash
ocamlbuild -pp pa_ocaml -pkgs decap compiler.byte
./compiler.byte < exemple.py > resultat.ll
llc -march=x86 resultat.ll -o resultat.s
gcc resultat.s -o resultat.native
./resultat.native
