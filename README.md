# Rouge

Dependency Manager for Swift projects in Swift. The reason we chose the name Rouge is twofold. The first and most important is we are going rouge until the Cocoapods team is able to bring support for Swift libraries. The second is Rouge is a X-Men with the power to absorb others' skills and abilities, much like open source projects. 

## Features

- Manage Swift libraries in your project.
- A simple binary you just drop in your path.
- Only does Swift projects.
- Still has a long way to go.

## Installation

Either clone down the project and add the binary to your path or download one of the prebuilt binaries under the Github releases.

### Usage

Rouge is pretty simple in how it works. To add a dependency to your project, simply run:

```bash
rouge add https://github.com/daltoniam/starscream.git
```

To remove a dependency, is pretty much the same as adding:

```bash
rouge remove https://github.com/daltoniam/starscream.git
```

To install those dependencies, just run:

```bash
rouge install
```

That will install the libraries into a libs folder in the root of your project. If you want to add a branch or tag, simply:

```bash
rouge add https://github.com/daltoniam/starscream.git, branch: awesome-branch
```

Also note, that the library repo must include an Xcode project to build the code as framework. I will add some docs on how to do that soon.

## TODOs

- [ ] Unit Tests
- [ ] Docs
- [ ] Create and add projects to workspace.

## License

Rouge is licensed under the Apache v2 License.

## Contact

### Austin Cherry ###
* https://github.com/acmacalister
* http://twitter.com/acmacalister
* http://austincherry.me 