# Rogue

Framework Manager for Swift projects in Swift. The reason we chose the name rogue is twofold. The first and most important is we are going rogue until the Cocoapods team is able to bring support for Swift libraries. The second is Rogue is a X-Men with the power to absorb others' skills and abilities, much like open source projects.

## Features

- Manage Swift frameworks in your project.
- A simple binary you just drop in your path.
- Only does Swift projects.
- Very simple, doesn't get into the complexities of managing dependencies. 

## Installation

Download the latest release from:
https://github.com/acmacalister/Rogue/releases

The file will not have execute permissions, add this by running on the release you just downloaded:

```bash
chmod +x rogue
```

Lastly copy the file into your PATH. A place that is normally in your path is `/usr/local/bin`

Example:
```bash
mv rogue /usr/local/bin
```

That's it! Enjoy using rogue.

### Usage

Rogue is pretty simple in how it works. First create a file name `rogue`. This can be accomplished by running:

```bash
touch rogue
```

This creates a per project text file named rogue, not to be confused with the binary that exist in your PATH.

 To add a framework to your project, run this from Terminal (in the directory that contains the rouge text file): 

```bash
rogue add https://github.com/daltoniam/starscream
```

To remove a framework, is pretty much the same as running this from Terminal:

```bash
rogue remove https://github.com/daltoniam/starscream
```

To install those frameworks, just run:

```bash
rogue install
```

That will install the libraries into a folder named `libs` in the root of your project (or where you created your rogue file).

If you want to use a branch or tag, simply run:

```bash
rogue add https://github.com/daltoniam/starscream awesome-branch
//notice the space between the url and branch name or tag
//Tag example:
//rogue add https://github.com/daltoniam/starscream 0.9.0
```

Make sure to add the `libs` folder to your `.gitignore` so you aren't checking all the repositories code into your repository.

Also please note, that the library repo must include an Xcode project to build the code as framework. I will add some docs on how to do that soon.

The current repositories can also be listed by running:

```bash
rogue list
```

## TODOs

- [ ] Unit Tests
- [ ] Docs
- [ ] Create and add projects to workspace.

## License

Rogue is licensed under the Apache v2 License.

## Contact

### Austin Cherry ###
* https://github.com/acmacalister
* http://twitter.com/acmacalister
* http://austincherry.me

### Dalton Cherry
* https://github.com/daltoniam
* http://twitter.com/daltoniam
* http://daltoniam.com