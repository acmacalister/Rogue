# Rouge

Framework Manager for Swift projects in Swift. The reason we chose the name Rouge is twofold. The first and most important is we are going rouge until the Cocoapods team is able to bring support for Swift libraries. The second is Rouge is a X-Men with the power to absorb others' skills and abilities, much like open source projects. 

## Features

- Manage Swift frameworks in your project.
- A simple binary you just drop in your path.
- Only does Swift projects.
- Still has a long way to go.

## Installation

Either clone down the project and add the binary to your path or download one of the prebuilt binaries under the Github releases. 

### Usage

Rouge is pretty simple in how it works. First create a file name `rouge`. This can be accomplished by running:

```bash
touch rouge
```

 To add a framework to your project, run:

```bash
rouge add https://github.com/daltoniam/starscream.git
```

To remove a framework, is pretty much the same as adding:

```bash
rouge remove https://github.com/daltoniam/starscream.git
```

To install those frameworks, just run:

```bash
rouge install
```

That will install the libraries into a folder named `libs` in the root of your project (or where you created your rouge file). 

If you want to use a branch or tag, simply run:

```bash
rouge add https://github.com/daltoniam/starscream.git awesome-branch
//notice the space between the url and branch name or tag
```

Make sure to add the `libs` folder to your `.gitignore` so you aren't checking all the repositories code into your repository.

Also please note, that the library repo must include an Xcode project to build the code as framework. I will add some docs on how to do that soon.

The current repositories can also be listed by running:

```bash
rouge list
```

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

### Dalton Cherry
* https://github.com/daltoniam
* http://twitter.com/daltoniam
* http://daltoniam.com