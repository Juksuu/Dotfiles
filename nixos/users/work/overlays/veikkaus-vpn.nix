{ final, prev }:
{
  veikkaus-vpn =
    let
      pulse-cookie = prev.pkgs.python3.pkgs.buildPythonApplication rec {
        pname = "pulse-cookie";
        version = "1.0";
        pyproject = true;

        src = prev.pkgs.fetchPypi {
          inherit pname version;
          sha256 = "sha256-ZURSXfChq2k8ktKO6nc6AuVaAMS3eOcFkiKahpq4ebU=";
        };

        build-system = with prev.pkgs.python3.pkgs; [
          setuptools
          setuptools-scm
        ];

        propagatedBuildInputs = with prev.pkgs.python3.pkgs; [
          pyqt6
          pyqt6-webengine
        ];

        preBuild = ''
          cat > setup.py << EOF
          from setuptools import setup

          setup(
            name='pulse-cookie',
            packages=['pulse_cookie'],
            package_dir={"": 'src'},
            version='1.0',
            author='Raj Magesh Gauthaman',
            description='wrapper around openconnect allowing user to log in through a webkit window for mfa',
            install_requires=[
              'PyQt6-WebEngine',
            ],
            entry_points={
              'console_scripts': ['get-pulse-cookie=pulse_cookie._cli:main']
            },
          )
          EOF
        '';

        doCheck = false;

        meta = with prev.lib; {
          homepage = "https://pypi.org/project/pulse-cookie/";
          description = "wrapper around openconnect allowing user to log in through a webkit window for mfa";
          license = licenses.gpl3;
        };
      };

      pulse-vpn-shell-script = prev.pkgs.writeShellScriptBin "veikkaus-vpn" ''
        HOST=https://partnergate.veikkaus.fi/dika

        echo "Grabbing SAML cookie via PyQt6..."
        DSID=$(QTWEBENGINE_FORCE_USE_GBM=1 ${pulse-cookie}/bin/get-pulse-cookie -n DSID $HOST)

        echo "Cookie acquired! Starting openconnect..."
        sudo ${prev.pkgs.openconnect}/bin/openconnect --protocol nc -C DSID=$DSID $HOST
      '';
    in
    final.buildEnv {
      name = "veikkaus-vpn";
      paths = [
        pulse-cookie
        pulse-vpn-shell-script
      ];
    };
}
