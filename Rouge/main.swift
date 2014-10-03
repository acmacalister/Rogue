//
//  main.swift
//  Rouge
//
//  Created by austin on 10/3/14.
//  Copyright (c) 2014 Vluxe. All rights reserved.
//

import Foundation

func printHelpMenu() {
    println("Rouge Package Manager   - 0.0.1")
    println("add <url/tag/branch>    - Adds dependency to project.")
    println("remove <url/tag/branch> - Removes dependency from project.")
    println("install                 - installs added dependencies.")
}

func readConfig() -> String {
    let fileManager = NSFileManager.defaultManager()
    var error: NSError?
    let config = NSString(contentsOfFile: "/Users/austin/Desktop/rouge", encoding: NSUTF8StringEncoding, error: &error)
    if let e  = error {
        println(e.localizedDescription)
        return ""
    }
    
    if let conf = config {
        return conf
    }
    println("config is blank.")
    return ""
}

func addDependency(url: String) {
    println("adding \(url) as a dependency")
    var config = readConfig()
    config = config.stringByAppendingString("\n \(url)")
}

func removeDependency(url: String) {
    println("removing \(url) as a dependency")
    let config = readConfig()
    var array = config.componentsSeparatedByString("\n") as Array<String>
    array = array.filter{$0 != url}
}

func install() {
    println("installing dependencies")
    // Either use libgit or NSTask to use git to pull download url and stuff.
}

if Process.arguments.count > 3 {
    switch Process.arguments[1] {
    case "add":
       addDependency(Process.arguments[2])
    case "remove":
        removeDependency(Process.arguments[2])
    case "install":
        install()
    default:
        printHelpMenu()
    }
} else {
    printHelpMenu()
}
