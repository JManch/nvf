{
  rustPlatform,
  fetchFromGitHub,
  writeShellScriptBin,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "blink-cmp";
  version = "1.7.0";

  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    tag = "v${finalAttrs.version}";
    hash = "sha256-eMUOjG2CtedCGVU1Pdp8PCCgGoFbjeVvK7lMS8E+ogg=";
  };

  forceShare = [
    "man"
    "info"
  ];

  postInstall = ''
    cp -r {lua,plugin} "$out"

    mkdir -p "$out/doc"
    cp 'doc/'*'.txt' "$out/doc/"

    mkdir -p "$out/target"
    mv "$out/lib" "$out/target/release"
  '';

  cargoHash = "sha256-zWZHT+Y8ENN/nFEtJnkEUHXRuU6FUQ/ITHo+V4zJ6f8=";

  nativeBuildInputs = [
    (writeShellScriptBin "git" "exit 1")
  ];

  env.RUSTC_BOOTSTRAP = true;
})
