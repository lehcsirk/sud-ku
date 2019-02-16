//
//  ViewController.swift
//  poke
//
//  Created by Cameron Krischel on 2/13/19.
//  Copyright © 2019 Cameron Krischel. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

let defaults = UserDefaults.standard

let screenSize: CGRect = UIScreen.main.bounds
//var counter = [10]
//let copyCounter = defaults.array(forKey: "savedCounter")  as? [Int] ?? [Int]()
//let copyX = defaults.array(forKey: "savedX")  as? [Int] ?? [Int]()
//let copyY = defaults.array(forKey: "savedY")  as? [Int] ?? [Int]()
//let copyColor = defaults.array(forKey: "savedColor")  as? [CGFloat] ?? [CGFloat]()
//let copyWin = defaults.array(forKey: "savedWin")  as? [Int] ?? [Int]()

let setWidth = Int(screenSize.width)
let setHeight = Int(screenSize.width)

let startHeight = 50

var myArray = [
    [" ", " ", " ", " ", " ", " ", " ", " ", " "],
    [" ", " ", " ", " ", " ", " ", " ", " ", " "],
    [" ", " ", " ", " ", " ", " ", " ", " ", " "],
    [" ", " ", " ", " ", " ", " ", " ", " ", " "],
    [" ", " ", " ", " ", " ", " ", " ", " ", " "],
    [" ", " ", " ", " ", " ", " ", " ", " ", " "],
    [" ", " ", " ", " ", " ", " ", " ", " ", " "],
    [" ", " ", " ", " ", " ", " ", " ", " ", " "],
    [" ", " ", " ", " ", " ", " ", " ", " ", " "]
]

class ViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        for i in 0...9
        {
            let layer = CAShapeLayer()
            // Gray Horizontal Lines
            layer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: CGFloat(startHeight) + screenSize.width/9*CGFloat(i), width: screenSize.width, height: 1), cornerRadius: 0).cgPath
            layer.fillColor = UIColor.lightGray.cgColor
            view.layer.addSublayer(layer)
        }
        for i in 0...9
        {
            let layer = CAShapeLayer()
            // Gray Vertical Lines
            layer.path = UIBezierPath(roundedRect: CGRect(x: screenSize.width/9*CGFloat(i), y: CGFloat(startHeight), width: 1, height: screenSize.width), cornerRadius: 0).cgPath
            layer.fillColor = UIColor.lightGray.cgColor
            view.layer.addSublayer(layer)
        }
        for i in 0...3
        {
            let layer = CAShapeLayer()
            // Black Horizontal Lines
            layer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: CGFloat(startHeight) + screenSize.width/3*CGFloat(i), width: screenSize.width, height: 1), cornerRadius: 0).cgPath
            layer.fillColor = UIColor.black.cgColor
            view.layer.addSublayer(layer)
        }
        for i in 1...2
        {
            let layer = CAShapeLayer()
            // Black Vertical Lines
            layer.path = UIBezierPath(roundedRect: CGRect(x: screenSize.width/3*CGFloat(i), y: CGFloat(startHeight), width: 1, height: screenSize.width), cornerRadius: 0).cgPath
            layer.fillColor = UIColor.black.cgColor
            view.layer.addSublayer(layer)
        }
        for i in 0...8
        {
            for j in 0...8
            {
                let button = UIButton(frame: CGRect(x: screenSize.width/9*CGFloat(i)+1, y: screenSize.width/9*CGFloat(j) + CGFloat(startHeight) + 1, width: screenSize.width/9-2, height: screenSize.width/9-2))
                
                button.backgroundColor = UIColor.white
                button.setTitle(" ", for: .normal)
                button.setTitleColor(UIColor.black, for: .normal)
                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                
                self.view.addSubview(button)
            }
        }
        let verifyButton = UIButton(frame: CGRect(x: 0, y: screenSize.height*3/4, width: screenSize.width, height: screenSize.width/4))
        
        verifyButton.backgroundColor = UIColor.white
        verifyButton.setTitle("Verify", for: .normal)
        verifyButton.setTitleColor(UIColor.black, for: .normal)
        verifyButton.addTarget(self, action: #selector(doVerify), for: .touchUpInside)
        verifyButton.titleLabel?.numberOfLines = 0
        verifyButton.titleLabel?.adjustsFontSizeToFitWidth = true
        verifyButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        verifyButton.contentHorizontalAlignment = .center
        verifyButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        verifyButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.top
        verifyButton.titleLabel?.textAlignment = .center
        self.view.addSubview(verifyButton)
    }
    @objc func doVerify(sender: UIButton!)
    {
        if(true)
        {
            sender.setTitle("Verify\n\nValid Solution.", for: .normal)
        }
        else
        {
            sender.setTitle("Verify\n\nValid Solution.", for: .normal)
        }
        for i in 0...8
        {
            for j in 0...8
            {
                print(myArray[j][i] + ", ", terminator:"")
            }
            print("\n")
            
        }
    }
    func checkRows()
    {
        for i in 0...8
        {
            
        }
    }
    func checkCols()
    {
        
    }
    func check3x3()
    {
        
    }
    @objc func buttonAction(sender: UIButton!)
    {
        
        if(sender.titleLabel!.text == " ")
        {
            sender.setTitle("1", for: .normal)
        }
        else
        {
            if(Int((sender.titleLabel?.text)!)! < 9)
            {
                sender.setTitle(String(Int((sender.titleLabel?.text)!)!+1), for: .normal)
            }
            else
            {
                sender.setTitle(" ", for: .normal)
            }
        }
        myArray[Int(sender.frame.minX)%Int(screenSize.width/9 - 1)-1][(Int(sender.frame.minY)-startHeight)%Int(screenSize.width/9 - 1)-1] = sender.titleLabel!.text!
        print("Button Pressed.\n")
        print("X Coord: " + String(Int(sender.frame.minX)%Int(screenSize.width/9 - 1)))
        print("Y Coord: " + String((Int(sender.frame.minY)-startHeight)%Int(screenSize.width/9 - 1)))
//        print(String(Int(screenSize.width/45)))
//        print(String(Int(screenSize.width/9 - 1)))
    }
}

