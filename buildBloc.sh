#!bin/bash
ocamlbuild -pp pa_ocaml -pkgs decap blocker.byte
./blocker.byte < exemple.py > resBlocker.txt
