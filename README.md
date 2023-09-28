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
