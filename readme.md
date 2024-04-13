# Bash Manual of Development Metodologies

Bash application for support on learning the different agile and other traditional software development methodologies. Its' a blank manual.

## Getting Started

To use this manual, download the image `amamut_dev_tech_manual`.
```sh
docker pull amamut_dev_tech_manual
```
You can work on the manual for agile development methodologies with the `-a` argument.
```sh
docker run -ti --name=agile-manual amamut_dev_tech_manual -a
```
Or, on the manual for traditional development methodologies with the `-t` argument.
```sh
docker run -ti --name=traditional-manual amamut_dev_tech_manual -t
```
Finally, to restart the manual container:
```sh
docker start -i agile-manual
```

### Prerequisites

- Linux Mint, Ubutu or MacOSX. We haven't tested with another OS.
- Docker

### Installing

To install the project or run your own image, first clone this git repository. You'll find the manual code in `manual.sh`. Make the modifications you want. To build an image from the modified file, assuming you're in the repository folder in the terminal:
```
docker build -t [image_name] .
```
Then execute the commands from the [Getting Started](#getting-started) section but with the new image name.

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Docker](https://www.docker.com/)
* [Shell Script](https://www.shellscript.sh/)

## Versioning

Version 1.0.0

## Authors

* **Adrian Alejandro González Domínguez** - 359834
* **Hector Daniel Medrano Meza** - 361345
* **Manuel Abraham Escudero Moreno** - 355208

## License

This project is licensed under the MIT License - see the [license.md](license.md) file for details

## Acknowledgments

Much of the knowledge used for this project was provided by our professor **Luis Ramírez**.
**ChatGPT** assisted us with the Shell Script syntax.
