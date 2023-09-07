with import <nixpkgs> { };
stdenv.mkDerivation rec {
  name = "jupyter";
  env = buildEnv { name = name; paths = buildInputs; };
  buildInputs = [
    jupyter
    python310Full
    python310Packages.jupyter
    python310Packages.pandas
    python310Packages.numpy
    python310Packages.matplotlib
    python310Packages.nltk
    python310Packages.spacy
  ];
}
