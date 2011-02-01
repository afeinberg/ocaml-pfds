default: test

FILES= \
	heaps.cmi lists.cmi \
	pfds.cma pfds.cmxa pfds.a

BFILES=$(addprefix _build/lib/,$(FILES))

.PHONY: all
all:
	ocamlbuild lib/pfds.cma lib/pfds.cmxa

test: all
	ocamlbuild lib_test/test.native
	./test.native; echo

.PHONY: all
doc:
	ocamlbuild -no-links lib/doc.docdir/index.html

.PHONY: install
install:
	ocamlfind install pfds lib/META $(BFILES)

.PHONY: uninstall
uninstall:
	ocamlfind remove pfds

.PHONY: reinstall
reinstall: all uninstall install

.PHONY: clean
clean:
	ocamlbuild -clean
