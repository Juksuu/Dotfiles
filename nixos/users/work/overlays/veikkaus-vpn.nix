{ final, prev }: {
  veikkaus-vpn = let
    pulse-cookie = prev.pkgs.python3Packages.buildPythonApplication rec {
      pname = "pulse-cookie";
      version = "1.0";

      src = prev.pkgs.fetchPypi {
        inherit pname version;
        sha256 = "sha256-ZURSXfChq2k8ktKO6nc6AuVaAMS3eOcFkiKahpq4ebU=";
      };

      propagatedBuildInputs = with prev.pkgs.python3Packages; [
        pyqt6
        pyqt6-webengine
        setuptools
        setuptools-scm
      ];

      pyproject = true;
      build-system = with prev.pkgs.python3Packages; [ setuptools ];

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

      meta = with prev.lib; {
        homepage = "https://pypi.org/project/pulse-cookie/";
        description =
          "wrapper around openconnect allowing user to log in through a webkit window for mfa";
        license = licenses.gpl3;
      };
    };

    pulse-cookie-wrapper = prev.pkgs.runCommand "pulse-cookie-wrapper" {
      buildInputs = [ prev.pkgs.makeWrapper ];
    } ''
      makeWrapper ${pulse-cookie}/bin/get-pulse-cookie $out/bin/get-pulse-cookie \
        --set QT_PLUGIN_PATH "${
          prev.pkgs.lib.getLib prev.pkgs.qt6.qtbase
        }/lib/qt-6.2/plugins" \
        --set QML2_IMPORT_PATH "${prev.pkgs.qt6.qtbase}/qml"
    '';

    pulse-vpn-shell-script = prev.pkgs.writeShellScriptBin "veikkaus-vpn" ''
      export QTWEBENGINE_CHROMIUM_FLAGS="--disable-logging"
      HOST=https://partnergate.veikkaus.fi/dika
      DSID=$(${pulse-cookie-wrapper}/bin/get-pulse-cookie -n DSID $HOST)
      sudo ${prev.pkgs.openconnect}/bin/openconnect --protocol nc -C DSID=$DSID $HOST
    '';
  in final.buildEnv {
    name = "veikkaus-vpn";
    paths = [ pulse-cookie-wrapper pulse-vpn-shell-script ];
  };
}
