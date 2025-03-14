{ stdenvNoCC, gitignoreSource, texlive }:

let
  tex = texlive.combine {
    inherit (texlive) scheme-small
      biber
      biblatex
      csquotes
      hyphenat
      lastpage
      latexmk
      siunitx
      todonotes
      xpatch;
  };
in stdenvNoCC.mkDerivation {
  pname = "latex-template";
  version = "1.0.0";

  src = gitignoreSource ../.;

  nativeBuildInputs = [
    tex
  ];

  doConfigure = false;

  # Avoid luatex failing due to non-writable cache.
  TEXMFVAR = "/tmp/texlive/";

  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/share/latex-template
    install -m 0644 diplom.pdf $out/share/latex-template/
  '';
}
