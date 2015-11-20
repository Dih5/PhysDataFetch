# PhysDataFetch

[![release v0.1.0](http://img.shields.io/badge/release-v0.1.0-orange.svg)](https://github.com/dih5/PhysDataFetch/releases/latest)
[![Semantic Versioning](https://img.shields.io/badge/SemVer-2.0.0-brightgreen.svg)](http://semver.org/spec/v2.0.0.html)
[![license MIT](https://img.shields.io/badge/license-MIT%20Licencse-blue.svg)](https://github.com/dih5/PhysDataFetch/blob/master/LICENSE.txt)
[![Mathematica 9.0 10.0](https://img.shields.io/badge/Mathematica-9.0_10.0-brightgreen.svg)](#compatibility)


Set of tools to fetch data from some databases of physical data.

* [Features](#features)
* [Usage example](#usage-example)
* [Installation](#installation)
    * [Automatic installation](#automatic-installation)
    * [Manual installation](#manual-installation)
    * [No installation](#no-installation)
* [Documentation](#documentation)
* [Compatibility](#compatibility)
* [Bugs and requests](#bugs-and-requests)
* [Contributing](#contributing)
* [License](#license)
* [Versioning](#versioning)

## Features
The package provides an interface to
* [ESTAR](http://physics.nist.gov/PhysRefData/Star/Text/ESTAR.html),
  [PSTAR](http://physics.nist.gov/PhysRefData/Star/Text/PSTAR.html), and
  [ASTAR](http://physics.nist.gov/PhysRefData/Star/Text/ASTAR.html)
  databases, which provide stopping power, CSDA range and other magnitudes for electrons, positrons and alpha particles in media.
* [Tables of X-Ray Mass Attenuation Coefficients
and Mass Energy-Absorption Coefficients
from 1 keV to 20 MeV for Elements Z = 1 to 92
and 48 Additional Substances of Dosimetric Interest](http://www.nist.gov/pml/data/xraycoef/), which provides Mass Attenuation and Mass Energy-Absorption Coefficients for photons in media.

## Usage example

A brief overview:

![alt tag](https://raw.github.com/dih5/ErrorPlot/master/demo.png)

Et voilà, you are watching the CSDA range of electrons and the mass-attenuation coefficient of photons in tungsten (Z=74).

## Installation


### Automatic installation

To install PhysDataFetch package evaluate:
```Mathematica
Get["https://raw.githubusercontent.com/dih5/PhysDataFetch/master/BootstrapInstall.m"]
```

This method uses [MathematicaBootstrapInstaller](https://github.com/jkuczm/MathematicaBootstrapInstaller) and will also install
[ProjectInstaller](https://github.com/lshifr/ProjectInstaller) package if you don't have it already installed.

To load PhysDataFetch package evaluate: ``Needs["PhysDataFetch`"]``.


### Manual installation

1. Download latest released
   [PhysDataFetch.zip](https://github.com/dih5/PhysDataFetch/releases/download/v0.1.0/PhysDataFetch.zip)
   file.

2. Extract downloaded `PhysDataFetch.zip` to any directory which is on the Mathematica `$Path`,
   e.g. to install for the current user `FileNameJoin[{$UserBaseDirectory,"Applications"}]`,
   for all users `FileNameJoin[{$BaseDirectory,"Applications"}]`.

3. To load the package evaluate: ``Needs["PhysDataFetch`"]``.


### No installation

To use package directly from the Web, without installation, evaluate:
```Mathematica
Get["https://raw.githubusercontent.com/dih5/PhysDataFetch/master/PhysDataFetch/PhysDataFetch.m"]
```

Note that with this method of initialization
package documentation will not be available in Mathematica Documentation Center.


## Documentation

This application comes with documentation integrated with the Mathematica Documentation Center.
After installation search for "PhysDataFetch" in documentation center
or press `F1` key with cursor on name of any of symbols introduced by this application.




## Compatibility

The package has been tested with Mathematica version 9.0 and 10.3 on Windows and Linux.
It will *not work for earlier versions* as it uses function URLFetch, which is 9.0+.



## Bugs and requests

If you find any bugs or have a feature request you may create an
[issue on GitHub](https://github.com/dih5/PhysDataFetch/issues).



## Contributing

Feel free to fork and send pull requests, all contributions are welcome.



## License

This package is released under
[The MIT License](https://github.com/dih5/PhysDataFetch/master/LICENSE).



## Versioning

Releases of this package will be numbered using
[Semantic Versioning guidelines](http://semver.org/).