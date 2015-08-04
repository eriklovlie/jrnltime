# NOTE: requires these packages to be installed:
# opam install atdgen
# opam install core_extended
ocamlbuild -use-ocamlfind -package core_extended -package yojson -package atdgen -tag thread jrnltime.native
