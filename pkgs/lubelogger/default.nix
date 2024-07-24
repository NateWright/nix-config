{ fetchFromGitHub, buildDotnetModule, dotnet-sdk_8 }:

buildDotnetModule rec {
  pname = "LubeLogger";
  version = "1.3.5";
  dotnet-sdk = dotnet-sdk_8;
  dotnet-runtime = dotnet-sdk_8;
  src = fetchFromGitHub {
    owner = "hargata";
    repo = "lubelog";
    rev = "6cf733b9c6ed93545383e70f46aad208be008db5";
    hash = "sha256-Og7yDZn6PBkoihApCy/dWxWt/DoBwQDXVAio8nwcI9A=";
  };
  nugetDeps = ./deps.nix;

  projectFile = "CarCareTracker.csproj";

}
