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
    config = config.stringByAppendingString("\(url)\n")
    var error: NSError?
    config.writeToFile("/Users/austin/Desktop/rouge", atomically: true, encoding: NSUTF8StringEncoding, error: &error)
    if let e = error {
        println(e.localizedDescription)
    }
}

func removeDependency(url: String) {
    println("removing \(url) as a dependency")
    var config = readConfig()
    var error: NSError?
    var array = config.componentsSeparatedByString("\n") as Array<String>
    array = array.filter{$0 != url}
    config = "\n".join(array)
    config.writeToFile("/Users/austin/Desktop/rouge", atomically: true, encoding: NSUTF8StringEncoding, error: &error)
    if let e = error {
        println(e.localizedDescription)
    }
}

func install() {
    println("installing dependencies")
    let config = readConfig()
    var array = config.componentsSeparatedByString("\n") as Array<String>
    
    for s in array {
        let task = NSTask()
        task.launchPath = "/usr/bin/git"
        task.arguments = ["clone", s]
        
        let pipe = NSPipe()
        task.standardOutput = pipe
        
        let file = pipe.fileHandleForReading
        task.launch()
        
        let data = file.readDataToEndOfFile()
        let string = NSString(data: data, encoding: NSUTF8StringEncoding)
        println(string)
    }
}

if Process.arguments.count >= 2 {
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
