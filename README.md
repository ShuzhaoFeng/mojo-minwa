# This Module is Deprecated!

As of 2023-10-05, Modular just released an update to Mojo v0.4.0 with new features, among which a file module for basic I/O support. This repository, which was meant to be a temporary solution, is no longer needed. Please use the Mojo native I/O support because it's much more feature complete and will receive LTS from the Modular team.

For more information, please check the changelog: https://docs.modular.com/mojo/changelog.html#v0.4.0-2023-10-05.


# mojo-minwa
The minimal library you need to write / append file in Mojo

# Prerequisite
[Mojo Language Interpreter](https://docs.modular.com/mojo/manual/get-started/)
# Setup
I decided to keep it simple. Thus you can:
 - Download the `minwa.mojo` file;
 - Put it in your Mojo repository;
 - Add The following line on top of your file:
```mojo
from minwa import appendfile, writefile
```
And you're good to go!
# Usage
```mojo
writefile("First Line\n", "hw.txt") # this writes "First Line" to hw.txt
appendfile("Second Line", "hw.txt") # this appends "Second Line" to hw.txt
```
