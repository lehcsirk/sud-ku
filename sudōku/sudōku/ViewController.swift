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

let startHeight = Int(screenSize.height*0.135869565)
var verifyRows = true
var verifyCols = true
var verify3x3 = true
var verifyStartRows = true
var verifyStartCols = true
var verifyStart3x3 = true
var arrayFull = true


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

//var myArray = [
//    ["4", "3", "5", "2", "6", "9", "7", "8", "1"],
//    ["6", "8", "2", "5", "7", "1", "4", "9", "3"],
//    ["1", "9", "7", "8", "3", "4", "5", "6", "2"],
//    ["8", "2", "6", "1", "9", "5", "3", "4", "7"],
//    ["3", "7", "4", "6", "8", "2", "9", "1", "5"],
//    ["9", "5", "1", "7", "4", "3", "6", "2", "8"],
//    ["5", "1", "9", "3", "2", "6", "8", "7", "4"],
//    ["2", "4", "8", "9", "5", "7", "1", "3", "6"],
//    ["7", "6", "3", "4", "1", "8", "2", "5", "9"]
//]
class ViewController: UIViewController
{
    var buttonsArray = [UIButton]()
    let resetButton = UIButton(frame: CGRect(x: screenSize.width/2, y: CGFloat(startHeight)+screenSize.width, width: screenSize.width/2, height: (screenSize.height-(CGFloat(startHeight)+screenSize.width))/3))
    let solveButton = UIButton(frame: CGRect(x: screenSize.width/2, y: CGFloat(startHeight)+screenSize.width + (screenSize.height-(CGFloat(startHeight)+screenSize.width))/3, width: screenSize.width/2, height: (screenSize.height-(CGFloat(startHeight)+screenSize.width))/3))
    let verifyButton = UIButton(frame: CGRect(x: screenSize.width/2, y: CGFloat(startHeight)+screenSize.width + (screenSize.height-(CGFloat(startHeight)+screenSize.width))*2/3, width: screenSize.width/2, height: (screenSize.height-(CGFloat(startHeight)+screenSize.width))/3))
    let sudoLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Int(screenSize.width), height: startHeight))
    let alertLabel = UILabel(frame: CGRect(x: 0, y: Int(CGFloat(startHeight)+screenSize.width), width: Int(screenSize.width/2), height: Int(screenSize.height - (CGFloat(startHeight)+screenSize.width))))
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("Test")
        print("Width in pixels: " + String(Int(screenSize.width)))
        print("Height in pixels: " + String(Int(screenSize.height)))
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
        // Generates 9x9 grid of buttons
        for i in 0...8
        {
            for j in 0...8
            {
                let button = UIButton(frame: CGRect(x: screenSize.width/9*CGFloat(i)+1, y: screenSize.width/9*CGFloat(j) + CGFloat(startHeight) + 1, width: screenSize.width/9-1, height: screenSize.width/9-1))
                
                button.backgroundColor = UIColor.white
                button.setTitle(myArray[j][i], for: .normal)
                button.setTitleColor(UIColor.black, for: .normal)
                button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                
                self.view.addSubview(button)
                self.buttonsArray.append(button)
            }
        }
        sudoLabel.backgroundColor = UIColor.white
        sudoLabel.text = "sudō"
        sudoLabel.textAlignment = NSTextAlignment.center
        sudoLabel.textColor = UIColor.black
        sudoLabel.backgroundColor = .clear
        sudoLabel.layer.cornerRadius = 5
        sudoLabel.layer.borderWidth = 1
        sudoLabel.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(sudoLabel)
        
        alertLabel.backgroundColor = UIColor.white
        alertLabel.text = ""
        alertLabel.textAlignment = NSTextAlignment.center
        alertLabel.textColor = UIColor.black
        alertLabel.backgroundColor = .clear
        alertLabel.layer.cornerRadius = 5
        alertLabel.layer.borderWidth = 1
        alertLabel.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(alertLabel)
        
        resetButton.backgroundColor = UIColor.white
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(UIColor.black, for: .normal)
        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
        resetButton.titleLabel?.numberOfLines = 0
        resetButton.titleLabel?.adjustsFontSizeToFitWidth = true
        resetButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        resetButton.contentHorizontalAlignment = .center
        resetButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        resetButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.top
        resetButton.titleLabel?.textAlignment = .center
        resetButton.backgroundColor = UIColor.red
        resetButton.backgroundColor = .clear
        resetButton.layer.cornerRadius = 5
        resetButton.layer.borderWidth = 1
        resetButton.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(resetButton)
        
        solveButton.backgroundColor = UIColor.white
        solveButton.setTitle("Solve", for: .normal)
        solveButton.setTitleColor(UIColor.black, for: .normal)
        solveButton.addTarget(self, action: #selector(doSolve), for: .touchUpInside)
        solveButton.titleLabel?.numberOfLines = 0
        solveButton.titleLabel?.adjustsFontSizeToFitWidth = true
        solveButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        solveButton.contentHorizontalAlignment = .center
        solveButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
        solveButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.top
        solveButton.titleLabel?.textAlignment = .center
        solveButton.backgroundColor = UIColor.blue
        solveButton.backgroundColor = .clear
        solveButton.layer.cornerRadius = 5
        solveButton.layer.borderWidth = 1
        solveButton.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(solveButton)
        
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
        verifyButton.backgroundColor = UIColor.green
        verifyButton.backgroundColor = .clear
        verifyButton.layer.cornerRadius = 5
        verifyButton.layer.borderWidth = 1
        verifyButton.layer.borderColor = UIColor.black.cgColor
        self.view.addSubview(verifyButton)
    }
    func display()
    {
        var counter = 0
        for i in 0...8
        {
            for j in 0...8
            {
                buttonsArray[counter].setTitle(myArray[i][j], for: .normal)
                if(buttonsArray[counter].titleLabel?.text == " ")
                {
                    buttonsArray[counter].backgroundColor = UIColor.white
                }
                counter+=1
            }
        }
    }
    @objc func reset()
    {
        for i in 0...8
        {
            for j in 0...8
            {
                // Option to only reset non-green squares
//                if(buttonsArray[i + 9*j].backgroundColor == UIColor.green)
//                {
//
//                }
//                else
//                {
//                    myArray[j][i] = " "
//                }
                myArray[j][i] = " "
            }
        }
        display()
    }
    @objc func doSolve(sender: UIButton!)
    {
        if(validStart())
        {
            solve()
        }
        else
        {
            alertLabel.text = "Invalid Start Conditions"
            print("Invalid Start Conditions")
            verifyStart3x3 = true
            verifyStartRows = true
            verifyStartCols = true
        }
        display()
    }
    @objc func doVerify(sender: UIButton!)
    {
        print("Columns:" + String(verifyStartCols))
        print("Rows:\t" + String(verifyStartRows))
        print("3x3:\t" + String(verifyStart3x3))
        checkStart3x3()
        checkStartRows()
        checkStartCols()
        print("Columns:" + String(verifyStartCols))
        print("Rows:\t" + String(verifyStartRows))
        print("3x3:\t" + String(verifyStart3x3))
        print()
        
        display()
        checkBlank()
        if(arrayFull == true)
        {
            // Thread code version attempt
            let rowThread = Thread
            {
                self.checkRows()
            }
            let colThread = Thread
            {
                self.checkCols()
            }
            let threeThread = Thread
            {
                self.check3x3()
            }
            rowThread.start()
            colThread.start()
            threeThread.start()
            while(!(rowThread.isFinished&&colThread.isFinished&&threeThread.isFinished))
            {
                //wait until finished
                print("Still calculating")
            }
            print("Done Calculating")
            
            print(verify3x3)
            print(verifyRows)
            print(verifyCols)
            if(verifyRows && verifyCols && verify3x3)
            {
                alertLabel.text = "Valid Solution."
            }
            else
            {
                alertLabel.text = "Invalid Solution."
            }
            verifyRows = true
            verifyCols = true
            verify3x3 = true
        }
        else
        {
            alertLabel.text = "Sudoku not filled."
            arrayFull = true
            verifyStartRows = true
            verifyStartCols = true
            verifyStart3x3 = true
        }
    }
    func checkBlank()
    {
        for i in 0...8
        {
            for j in 0...8
            {
                if(myArray[i][j] == " ")
                {
                    arrayFull = false
                }
            }
        }
    }
    func checkRows()
    {
        for j in 0...8
        {
            var tempArray = [0,0,0,0,0,0,0,0,0]
            for i in 0...8
            {
                tempArray[i] = Int(myArray[i][j])!
            }
            tempArray.sort()
            for i in 0...8
            {
                if(tempArray[i] != i+1)
                {
                    verifyRows = false
                }
            }
        }
    }
    func checkCols()
    {
        for j in 0...8
        {
            var tempArray = [0,0,0,0,0,0,0,0,0]
            for i in 0...8
            {
                tempArray[i] = Int(myArray[j][i])!
            }
            tempArray.sort()
            for i in 0...8
            {
                if(tempArray[i] != i+1)
                {
                    verifyCols = false
                }
            }
        }
    }
    func check3x3()
    {
        for m in 0...2
        {
            for j in 0...2
            {
                var tempArray = [0,0,0,0,0,0,0,0,0]
                var count = 0
                for i in 0...2
                {
                    for k in 0...2
                    {
                        tempArray[count] = Int(myArray[k + 3*j][i + 3*m])!
                        count+=1
                    }
                }
                tempArray.sort()
                for f in 0...8
                {
                    if(tempArray[f] != f+1)
                    {
                        verify3x3 = false
                    }
                }
            }
        }
    }
    func removeDuplicateInts(values: [Int]) -> [Int]
    {
        // Convert array into a set to get unique values.
        let uniques = Set<Int>(values)
        // Convert set back into an Array of Ints.
        let result = Array<Int>(uniques)
        return result
    }
    func checkStartRows()
    {
        for j in 0...8
        {
            var tempArray = [Int]()
            var count = 0
            for i in 0...8
            {
                if(buttonsArray[j+i*9].backgroundColor == UIColor.green)
                {
                    tempArray.append(Int(myArray[i][j])!)
                    count+=1
                }
            }
            tempArray.sort()
            // Remove duplicates from these example numbers.
            let uniqueRows = removeDuplicateInts(values: tempArray)
            if(tempArray.count != uniqueRows.count)
            {
                verifyStartRows = false
            }
        }
    }
    func checkStartCols()
    {
        for j in 0...8
        {
            var tempArray = [Int]()
            var count = 0
            for i in 0...8
            {
                if(buttonsArray[i+j*9].backgroundColor == UIColor.green)
                {
                    tempArray.append(Int(myArray[j][i])!)
                    count+=1
                }
            }
            tempArray.sort()
            // Remove duplicates from these example numbers.
            let uniqueCols = removeDuplicateInts(values: tempArray)
            if(tempArray.count != uniqueCols.count)
            {
                verifyStartCols = false
            }
        }
    }
    func checkStart3x3()
    {
        for m in 0...2
        {
            for j in 0...2
            {
                var tempArray = [Int]()
                var count = 0
                for i in 0...2//(0 + 3*m)...(2 + 3*m)
                {
                    for k in 0...2//(0 + 3*j)...(2 + 3*j)
                    {
                        if(buttonsArray[i + 3*m + 9*(k + 3*j)].backgroundColor == UIColor.green)
                        {
                            tempArray.append(Int(myArray[k + 3*j][i + 3*m])!)
                            count+=1
                        }
                        
                    }
                }
                tempArray.sort()
                // Remove duplicates from these example numbers.
                let unique3x3 = removeDuplicateInts(values: tempArray)
                if(tempArray.count != unique3x3.count)
                {
                    verifyStart3x3 = false
                }
            }
        }
    }
    func solve() -> Bool
    {
        if(isFull())
        {
            return true
        }
        var tempArr = getFirstEmpty()
        var row = tempArr.0
        var col = tempArr.1
        
        for i in 1...9
        {
            if(isSafe(row: row, col: col, num: i))
            {
                myArray[row][col] = String(i)
                buttonsArray[col + row*9].backgroundColor = UIColor.yellow
                if(solve())
                {
                    return true
                }
                myArray[row][col] = " "
                print("Row: " + String(row) + ", Col: " + String(col))
            }
        }
        return false
    }
    func validStart() -> Bool
    {
        checkStart3x3()
        checkStartCols()
        checkStartRows()
        if(verifyStart3x3&&verifyStartCols&&verifyStartRows)
        {
            return true
        }
        return false
    }
    func isSafe(row: Int, col: Int, num: Int) -> Bool
    {
        return !usedInRow(row: row, num: num) &&
            !usedInCol(col: col, num: num) &&
            !usedIn3x3(row: row - row % 3, col: col - col % 3, num: num);
    }
    func usedInRow(row: Int, num: Int) -> Bool
    {
        for i in 0...8
        {
            if(myArray[row][i] == String(num))
            {
                return true
            }
        }
        return false
    }
    func usedInCol(col: Int, num: Int) -> Bool
    {
        for i in 0...8
        {
            if(myArray[i][col] == String(num))
            {
                return true
            }
        }
        return false
    }
    func usedIn3x3(row: Int, col: Int, num: Int) -> Bool
    {
     
        for i in 0...2
        {
            for j in 0...2
            {
                if(myArray[row + i][col + j] == String(num))
                {
                    return true
                }
            }
        }
        return false
    }
    func isFull() -> Bool
    {
        for i in 0...8
        {
            for j in 0...8
            {
                if(myArray[j][i] == " ")
                {
                    return false
                }
            }
        }
        return true
    }
    func getFirstEmpty() -> (Int, Int)
    {
        for i in 0...8
        {
            for j in 0...8
            {
                if(myArray[j][i] == " ")
                {
                    return (j, i)
                }
            }
        }
        return (9, 9)
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
        //x: screenSize.width/9*CGFloat(i)+1
        
        //y: screenSize.width/9*CGFloat(j) + CGFloat(startHeight) + 1,
        
        var buttonWidth = sender.frame.maxX - sender.frame.minX
        var xCoord = Int(sender.frame.minX)/Int(buttonWidth)
        var yCoord = (Int(sender.frame.minY)-startHeight)/Int(buttonWidth)
        print("X:" + String(Int(sender.frame.minX)/Int(buttonWidth)))
        print("Y: " + String((Int(sender.frame.minY)-startHeight)/Int(buttonWidth)))
        myArray[xCoord][yCoord] = sender.titleLabel!.text!

//        myArray[Int(sender.frame.minX)%Int(screenSize.width/9 - 1)-1][(Int(sender.frame.minY)-startHeight)%Int(screenSize.width/9 - 1)-1] = sender.titleLabel!.text!
        if(sender.titleLabel!.text == " ")
        {
            sender.backgroundColor = UIColor.white
        }
        else
        {
            sender.backgroundColor = UIColor.green
        }
    }
}

