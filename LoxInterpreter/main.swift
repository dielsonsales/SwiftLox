//
//  main.swift
//  LoxInterpreter
//
//  Created by Dielson Sales on 03/06/24.
//

import Foundation

// MARK: - Constants

enum Constants {
    static let dataFormatError: Int32 = 65
    static let homeDirectory = FileManager.default.homeDirectoryForCurrentUser
    static let projectDirectory =  homeDirectory.appending(path: "Workspace/iOS/LoxInterpreter/LoxInterpreter")
}

// MARK: - Lox interpreter

final class Lox {

    private var hadError = false

    func runFile(fileName: String) {
        let filePath = Constants.projectDirectory.appending(path: fileName)
        do {
            let fileContent = try String(contentsOf: filePath, encoding: .utf8)
            run(source: fileContent)
            if hadError {
                exit(Constants.dataFormatError)
            }
        } catch {
            print("Error reading file: \(fileName). Error: \(error.localizedDescription)")
        }
    }

    func runPrompt() {
        print("> ")
        while let line = readLine() {
            run(source: line)
            hadError = false // Resets the error flag in the interactive loop
        }
    }

    func run(source: String) {
        // TODO
        print(source)
    }

    // MARK: - Herror handling

    func error(line: Int, message: String) {
        report(line: line, where: "", message: message)
    }

    func report(line: Int, where: String, message: String) {
        print("[line " + String(line) + "] Error " + `where` + ": " + message)
        hadError = true
    }

}

// MARK: - Entry point

func main() {
    guard CommandLine.arguments.count >= 1 else {
        print("Usage: swiftlox [script]")
        exit(64)
    }
    let lox = Lox()
    switch CommandLine.arguments.count {
    case 2:
        lox.runFile(fileName: CommandLine.arguments[1])
    default:
        lox.runPrompt()
    }
}

main()
