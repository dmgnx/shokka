# Shokka: Shell script Preprocessor and Library

## Overview

Shokka is an innovative shell script preprocessor and library that simplifies and enhances scripting. It enables the inclusion, packing, and use of various modules and scripts, thereby facilitating modular and maintainable script development.

## Features

* Module Inclusion and Packing: Easily embed and utilize various scripts and modules within your scripts.
* Preprocessing Directives: Use directives like {%+include:%}, {%+pack:%}, and {%+use:%} for dynamic script generation.
* Simplified Scripting: Streamlines the process of creating complex shell scripts with modular components.

## Getting Started

### Prerequisites

Ensure you have Bash/ZSH installed on your system. Shokka development tries to keep in mind support for most shell environment.

### Installation

Just download shokka.sh

### Usage

To use Shokka for preprocessing your scripts:

Name your source scripts with a \<filename>~.sh extension.

Run the Shokka preprocessor as follows:

```bash

shokka.sh <script1> ... <scriptN>
```

Replace <script1>, ..., <scriptN> with your script filenames.
Shokka will process these scripts and generate .sh files as output.

### Preprocessing Instructions

* {%+include:\<file>%}: Include the contents of another file.
* {%+pack:\<file>%}: Embed any file into the script.
* {%+use:\<module>%}: Import and execute a Shokka module.

### Examples

Just check the Makefile, Shokka is generated with Shokka ;)

## License

Shokka is primarily distributed under the terms of both the MIT license and the Apache License (Version 2.0).

See LICENSE-APACHE, LICENSE-MIT for details.