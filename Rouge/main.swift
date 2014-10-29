//
//  main.swift
//  Rogue
//
//  Created by austin on 10/3/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//

import Foundation

let fileName = "rogue"

func printHelpMenu() {
    println("Rogue Package Manager    - 0.0.1")
    println("add url <tag/branch>     - Adds a framework to project.")
    println("remove url <tag/branch>  - Removes a framework from project.")
    println("list                     - List the current frameworks")
    println("install                  - Installs the added frameworks.")
}

//reads the config from disk in the current directory
func readConfig() -> (text: String,error: NSError?) {
    let fileManager = NSFileManager.defaultManager()
    var error: NSError?
    let config = NSString(contentsOfFile: fileName, encoding: NSUTF8StringEncoding, error: &error)
    if let e  = error {
        println(e.localizedDescription)
        return ("", e)
    }
    
    if let conf = config {
        return (conf, nil)
    }
    return ("", NSError(domain: "rogue", code: -2, userInfo: [NSLocalizedDescriptionKey: "the config is blank."]))
}

//adds a framework to the project
func addDependency(url: String, branch: String) {
    removeDependency(url, branch)
    var config = readConfig()
    if config.error != nil {
        return
    }
    if config.text.rangeOfString(url) == nil {
        var appendText = url
        if countElements(branch) > 0 {
            appendText += ",\(branch)"
        }
        var configText = config.text.stringByAppendingString("\(appendText)\n")
        var error: NSError?
        configText.writeToFile(fileName, atomically: true, encoding: NSUTF8StringEncoding, error: &error)
        if let e = error {
            println(e.localizedDescription)
        }
    }
}

//removes a framework from the project
func removeDependency(url: String, branch: String) {
    var config = readConfig()
    if config.error != nil {
        return
    }
    var error: NSError?
    var array = config.text.componentsSeparatedByString("\n") as Array<String>
    array = array.filter{$0 != url && !$0.hasPrefix(url)}
    var configText = "\n".join(array)
    configText.writeToFile(fileName, atomically: true, encoding: NSUTF8StringEncoding, error: &error)
    if let e = error {
        println(e.localizedDescription)
    }
}

//finds git on disk
func findGit() -> String? {
    var env = NSProcessInfo.processInfo().environment as NSDictionary
    let path = env.objectForKey("PATH") as String
    let array = path.componentsSeparatedByString(":")
    let fileManager = NSFileManager.defaultManager()
    var location: String?
    for possiblePath in array {
        let filePath = "\(possiblePath)/git"
        if fileManager.fileExistsAtPath(filePath) {
            if location == nil && filePath.hasPrefix("Applications") {
                location = filePath //we hold out for a better one
            } else {
                location = filePath
                break
            }
        }
    }
    return location
}
//runs the get task of your selection
func runGitTask(gitPath: String,args: Array<String>) {
    let task = NSTask()
    task.launchPath = gitPath
    task.arguments = args
    
    let pipe = NSPipe()
    task.standardOutput = pipe
    
    let file = pipe.fileHandleForReading
    task.launch()
    
    let data = file.readDataToEndOfFile()
    let str = NSString(data: data, encoding: NSUTF8StringEncoding)
    if let s = str {
        if s.length > 0 {
            println("\(s)")
        }
    }
}
//does the git clones and creates the workspace
func install() {
    println("installing frameworks")
    let config = readConfig()
    if config.error != nil {
        return
    }
    let fileManager = NSFileManager.defaultManager()
    let libPath = "libs"
    if !fileManager.fileExistsAtPath(libPath) {
        fileManager.createDirectoryAtPath(libPath, withIntermediateDirectories: false, attributes: nil, error: nil)
    }
    fileManager.changeCurrentDirectoryPath(libPath)
    var array = config.text.componentsSeparatedByString("\n") as Array<String>
    let git = findGit()
    if let gitPath = git {
        var collect = Array<String>()
        for s in array {
            if s != "" {
                var split = s.componentsSeparatedByString(",")
                var branch = "master"
                let gitUrl = split[0]
                if split.count > 1 {
                    branch = split[1]
                }
                let name = gitUrl.lastPathComponent
                collect.append(name)
                if fileManager.fileExistsAtPath(name) {
                    fileManager.changeCurrentDirectoryPath(name)
                    runGitTask(gitPath, ["pull","origin",branch])
                    fileManager.changeCurrentDirectoryPath("..")
                } else {
                    runGitTask(gitPath, ["clone", gitUrl, "-b",branch])
                }
            }
        }
        let enumerator = fileManager.enumeratorAtURL(NSURL(fileURLWithPath: ".")!, includingPropertiesForKeys: nil,
            options: NSDirectoryEnumerationOptions.SkipsHiddenFiles|NSDirectoryEnumerationOptions.SkipsSubdirectoryDescendants, errorHandler: nil)
        let array = enumerator?.allObjects
        for file in array! {
            if let fileUrl = file as? NSURL {
                let name = fileUrl.lastPathComponent
                if find(collect, name) == nil {
                    fileManager.removeItemAtURL(fileUrl, error: nil)
                }
            }
        }
        
    } else {
        println("git does not appear to be installed")
    }
}

func list() {
    var config = readConfig()
    if config.error != nil {
        return
    }
    var array = config.text.componentsSeparatedByString("\n")
    for repo in array {
        println("\(repo)")
    }
}

if Process.arguments.count >= 2 {
    var branch = ""
    if Process.arguments.count >= 4 {
        branch = Process.arguments[3]
    }
    switch Process.arguments[1] {
    case "add":
       addDependency(Process.arguments[2],branch)
    case "remove":
        removeDependency(Process.arguments[2],branch)
    case "install":
        install()
    case "list":
        list()
    default:
        printHelpMenu()
    }
} else {
    printHelpMenu()
}
