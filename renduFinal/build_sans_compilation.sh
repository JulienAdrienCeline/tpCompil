#!bin/bash
echo "\nCompilation du parser\n"
ocamlbuild -pp pa_ocaml -pkgs decap exec_parser.byte
echo "\nRésultat du parser écrit dans resultat_parser.txt\n"
./exec_parser.byte < ./tests/exemple.py > ./tests/resultat_parser.txt
echo "\nCompilation de sémantique\n"
ocamlbuild -pp pa_ocaml -pkgs decap exec_semantique.byte
echo "\nExécution de la sémantique du programme exemple\n"
./exec_semantique.byte < ./tests/exemple.py
