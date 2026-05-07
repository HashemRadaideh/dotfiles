if [[ -r "${OPAMROOT:-$XDG_DATA_HOME/opam}/opam-init/init.zsh" ]]; then
  _opam_load() {
    unset -f opam ocaml ocamlfind ocamlopt ocamlc 2>/dev/null
    # shellcheck source=/dev/null
    source "${OPAMROOT:-$XDG_DATA_HOME/opam}/opam-init/init.zsh" >/dev/null 2>&1
  }
  opam() {
    _opam_load
    opam "$@"
  }
  ocaml() {
    _opam_load
    ocaml "$@"
  }
  ocamlc() {
    _opam_load
    ocamlc "$@"
  }
  ocamlopt() {
    _opam_load
    ocamlopt "$@"
  }
  ocamlfind() {
    _opam_load
    ocamlfind "$@"
  }
fi
