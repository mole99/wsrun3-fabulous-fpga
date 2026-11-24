{
  nixConfig = {
    extra-substituters = [
      "https://nix-cache.fossi-foundation.org"
    ];
    extra-trusted-public-keys = [
      "nix-cache.fossi-foundation.org:3+K59iFwXqKsL7BNu6Guy0v+uTlwsxYQxjspXzqLYQs="
    ];
  };

  inputs = {
    librelane.url = "github:librelane/librelane/dev";
  };

  outputs =
    {
      self,
      librelane,
      ...
    }:
    let
      nix-eda = librelane.inputs.nix-eda;
      devshell = librelane.inputs.devshell;
      nixpkgs = nix-eda.inputs.nixpkgs;
      lib = nixpkgs.lib;
    in
    {
      # Outputs
      legacyPackages = nix-eda.forAllSystems (
        system:
        import nixpkgs {
          inherit system;
          overlays = [
            nix-eda.overlays.default
            devshell.overlays.default
            librelane.overlays.default
            (nix-eda.composePythonOverlay (
              pkgs': pkgs: pypkgs': pypkgs:
              let
                callPythonPackage = lib.callPackageWith (pkgs' // pypkgs');
              in
              {
                cocotbext-spi = callPythonPackage ./nix/cocotbext-spi.nix { };
              }
            ))
            (final: prev: {
              iverilog = prev.iverilog.overrideAttrs {
                src = prev.fetchFromGitHub {
                  owner = "steveicarus";
                  repo = "iverilog";
                  rev = "9b131db4af34619efe977c4617a7b15c4cc5deb6";
                  hash = "sha256-qLgUFbe+B7Vfpj96OrPvWCgAlKcRefssPLu+OEgEbYo=";
                };
                installCheckPhase = '''';
              };
            })
          ];
        }
      );

      packages = nix-eda.forAllSystems (system: {
        inherit (self.legacyPackages.${system}.python3.pkgs) ;
      });

      devShells = nix-eda.forAllSystems (
        system:
        let
          pkgs = (self.legacyPackages.${system});
          callPackage = lib.callPackageWith pkgs;
        in
        {
          default = pkgs.librelane-shell.override ({
            extra-packages = with pkgs; [
              # Utilities
              gnumake
              gnugrep
              gawk

              # Simulation
              iverilog
              verilator

              # Waveform viewing
              gtkwave
              surfer
            ];

            extra-python-packages =
              ps: with ps; [
                # For logo generation
                pillow
              ] ++ lib.optionals (ps ? cocotb) [
                # Verification
                # (cocotb is only supported on some platforms due to ghdl-bin:
                # https://github.com/fossi-foundation/nix-eda/blob/main/nix/ghdl-bin.toml)
                cocotb
                cocotbext-spi
                pytest
              ];
          });
        }
      );
    };
}
