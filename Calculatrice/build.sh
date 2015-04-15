#!/bin/sh

ocamlbuild -pp pa_ocaml -cflags -I,+decap -lflags -I,+decap,str.cma,unix.cma,decap.cma calc_main.byte
