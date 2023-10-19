//
//  UITabBarController.swift
//  Codium
//
//  Created by Gilles Zwijsen on 18/10/2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()


        let fizzBuzzViewController = FizzBuzzViewController()
        let todoListViewController = TodoListViewController()
        let leapYearViewController = LeapYearViewController()
        let primeNumberViewController = PrimeNumberViewController()
        let patternViewController = PatternViewController()

        let targetSize = CGSize(width: 30, height: 30)

        // Resize the images and set the tab bar items
        fizzBuzzViewController.tabBarItem = UITabBarItem(title: "Fizz Buzz", image: UIImage(named: "FIZZBUZZ_Logo")?.resizeImage(targetSize: targetSize)?.withRenderingMode(.alwaysOriginal), tag: 0)
        todoListViewController.tabBarItem = UITabBarItem(title: "To-Do", image: UIImage(named: "todo")?.resizeImage(targetSize: targetSize)?.withRenderingMode(.alwaysOriginal), tag: 1)
        leapYearViewController.tabBarItem = UITabBarItem(title: "Leap Year", image: UIImage(named: "leapyear")?.resizeImage(targetSize: targetSize)?.withRenderingMode(.alwaysOriginal), tag: 2)
        primeNumberViewController.tabBarItem = UITabBarItem(title: "Prime", image: UIImage(named: "prime")?.resizeImage(targetSize: targetSize)?.withRenderingMode(.alwaysOriginal), tag: 3)
        patternViewController.tabBarItem = UITabBarItem(title: "Pattern", image: UIImage(named: "pattern")?.resizeImage(targetSize: targetSize)?.withRenderingMode(.alwaysOriginal), tag: 4)

        let fizzBuzzNavigationController = UINavigationController(rootViewController: fizzBuzzViewController)
        let todoListNavigationController = UINavigationController(rootViewController: todoListViewController)
        let leapYearNavigationController = UINavigationController(rootViewController: leapYearViewController)
        let primeNumberNavigationController = UINavigationController(rootViewController: primeNumberViewController)
        let patternNavigationController = UINavigationController(rootViewController: patternViewController)


        viewControllers = [
            fizzBuzzNavigationController,
            todoListNavigationController,
            leapYearNavigationController,
            primeNumberNavigationController,
            patternNavigationController
        ]

    }

    
  
}

extension UIImage {
    func resizeImage(targetSize: CGSize) -> UIImage? {
        let size = self.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        let newSize = widthRatio > heightRatio ? CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}


