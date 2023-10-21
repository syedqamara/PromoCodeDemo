//
//  AhmedTest.swift
//  PromoCodeDemo
//
//  Created by Apple on 22/10/2023.
//

import Foundation


// Object Oriented Programming

private class __Container {
    private var dependency: Dependenable
    init(dependency: Dependenable) {
        self.dependency = dependency
    }
    func performContainerTask() -> String {
        self.dependency.performDependencyTask()
    }
}

private class __Dependency: Dependenable {
    func performDependencyTask() -> String {
        return "__Dependency.performDependencyTask"
    }
}

private class __Dependency_2: Dependenable {
    func performDependencyTask() -> String {
        return "__Dependency_2.performDependencyTask"
    }
}

private struct __Dependency_Alien: Dependenable {
    func performDependencyTask() -> String {
        return "__Dependency_Alien.performDependencyTask"
    }
}



struct AhmedTask {
    static func main() {
        var dependency = __Dependency()
        let container = __Container(dependency: dependency)
        let container2 = __Container(dependency: __Dependency_2())
        let container3 = __Container(dependency: __Dependency_Alien())
        //
        print(container3.performContainerTask())
    }
}


protocol Dependenable {
    func performDependencyTask() -> String
}
