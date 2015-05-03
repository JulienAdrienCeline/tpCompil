#!bin/bash
echo "\nCompilation des phis et labels\n"
ocamlbuild -pp pa_ocaml -pkgs decap exec_phis_and_labels.byte
./exec_phis_and_labels.byte < ./tests/exemple.py > ./tests/resultat_phis_and_labels.txt
echo "\nRésultat des phis et labels écrits dans resultat_phis_and_labels.txt\n"

echo "\nCompilation du compiler\n"
ocamlbuild -pp pa_ocaml -pkgs decap exec_compiler.byte
echo "\nRésultat du compiler écrit dans resultat_compiler.ll\n"
./exec_compiler.byte < ./tests/exemple.py > ./tests/resultat_compiler.ll
echo "\nCompilation avec llc de resultat_compiler.ll en assembleur machine resultat_compiler.s\n"
llc -march=x86 ./tests/resultat_compiler.ll -o ./tests/resultat_compiler.s
echo "\nCompilation avec gcc resultat_compiler.s en code exécutable resultat_compiler.native\n"
gcc ./tests/resultat_compiler.s -o ./tests/resultat_compiler.native
echo "\nExécution de resultat_compiler.native\n"
./tests/resultat_compiler.native
echo "\nFin"
