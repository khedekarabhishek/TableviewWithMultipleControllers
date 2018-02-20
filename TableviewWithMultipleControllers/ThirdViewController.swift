//
//  ThirdViewController.swift
//  TableviewWithMultipleControllers
//
//  Created by Abhishek Khedekar on 10/01/18.
//  Copyright © 2018 Abhishek Khedekar. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var thirdLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setAttributedTextToLabel()
    }


    func setAttributedTextToLabel() {
        
        thirdLabel.isUserInteractionEnabled = true
        let text = "By signing up you agree to our Terms & Conditions and Privacy Policy"
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: "Terms & Conditions")
        underlineAttriString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: range1)
        thirdLabel.attributedText = underlineAttriString
    }

    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
      
        let text = (thirdLabel.text)!
        let termsRange = (text as NSString).range(of: "Terms & Conditions")
        if gesture.didTapAttributedTextInLabel(label: thirdLabel, inRange: termsRange) {
            print("Tapped terms")
        } else {
            print("not on range")
        }
        
        
//        let text = (thirdLabel.text)!
//        let range = (text as NSString).range(of: "Terms & Conditions")
//
//        let index = thirdLabel.indexOfAttributedTextCharacterAtPoint(point: gesture.location(in: thirdLabel))
//        print("index of character is : \(index)")
//        if index > range.location && index < range.location + range.length {
//
//            print("Type character is in range")
//        }


    }
}


extension UILabel {
    
    func indexOfAttributedTextCharacterAtPoint(point: CGPoint) -> Int {
        let textStorage = NSTextStorage(attributedString: self.attributedText!)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer(size: self.frame.size)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = self.numberOfLines
        textContainer.lineBreakMode = self.lineBreakMode
        layoutManager.addTextContainer(textContainer)
        
        let index = layoutManager.characterIndex(for: point, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return index
    }
    
}


extension UITapGestureRecognizer {
    
        func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
            // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
            let layoutManager = NSLayoutManager()
            let textContainer = NSTextContainer(size: CGSize.zero)
            let textStorage = NSTextStorage(attributedString: label.attributedText!)
    
            // Configure textContainer
            textContainer.lineFragmentPadding = 0.0
            textContainer.lineBreakMode = label.lineBreakMode
            textContainer.maximumNumberOfLines = label.numberOfLines
            let labelSize = label.bounds.size
            textContainer.size = labelSize
    
            print("textcontainer size \(textContainer.size)")
            // Configure layoutManager and textStorage
            layoutManager.addTextContainer(textContainer)
            textStorage.addLayoutManager(layoutManager)

            // Find the tapped character location and compare it to the specified range
            let locationOfTouchInLabel = self.location(in: label)
            let textBoundingBox = layoutManager.usedRect(for: textContainer)
    
            print("label width \(labelSize.width)")
            print("textboundingbox width \(textBoundingBox.size.width)")
            print("label height \(labelSize.height)")
            print("textboundingbox height \(textBoundingBox.size.height)")
            print("textboundingbox x \(textBoundingBox.origin.x)")
            print("textboundingbox y \(textBoundingBox.origin.y)")
            print("textcontaineroffset x \((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x)")
            print("textcontaineroffset y \((labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y))")
            
            let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
//            let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
//
            
            print("location touch in label x \(locationOfTouchInLabel.x)")
            print("location touch in label y \(locationOfTouchInLabel.y)")
            
            
            let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
            
            let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
            print("index of char is : \(indexOfCharacter)")
            print("Bool value is : \(NSLocationInRange(indexOfCharacter, targetRange))")
            
            return NSLocationInRange(indexOfCharacter, targetRange)
        }
    
}



