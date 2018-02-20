//
//  FirstViewController.swift
//  TableviewWithMultipleControllers
//
//  Created by Abhishek Khedekar on 09/01/18.
//  Copyright © 2018 Abhishek Khedekar. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
  
    @IBOutlet weak var firstLabel: UILabel!
    var textContainer: NSTextContainer?
    let layoutManager = NSLayoutManager()
    var linkRange:NSRange?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setAttributedTextToLabel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textContainer?.size = firstLabel.bounds.size
    }
    
    func setAttributedTextToLabel() {
        
        firstLabel.isUserInteractionEnabled = true
        let text = "By signing up you agree to our Terms & Conditions and Privacy Policy"
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range1 = (text as NSString).range(of: "Terms & Conditions")
        underlineAttriString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: range1)
        firstLabel.attributedText = underlineAttriString
        linkRange = range1
        
        let textStorage = NSTextStorage(attributedString: underlineAttriString)
        textContainer = NSTextContainer(size: CGSize.zero)

        if let textContainer = textContainer {
            layoutManager.addTextContainer(textContainer)
            textStorage.addLayoutManager(layoutManager)
            textContainer.lineFragmentPadding = 0.0
            textContainer.lineBreakMode = firstLabel.lineBreakMode
            textContainer.maximumNumberOfLines = firstLabel.numberOfLines
            
            let labelSize = firstLabel.bounds.size
            textContainer.size = labelSize
        }
        
    }
    
   
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        let locationOfTouchInLabel = gesture.location(in: gesture.view)
        let labelSize = gesture.view?.bounds.size

        var textBoundingBox = CGRect.zero
        if let textContainer = textContainer {
             textBoundingBox = layoutManager.usedRect(for: textContainer)
            if let labelSizeWidth = labelSize?.width, let labelSizeHeight = labelSize?.height {
                let textContainerOffset = CGPoint(
                    x: (labelSizeWidth - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                    y: (labelSizeHeight - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y
                )
                let locationOfTouchInTextContainer = CGPoint(x: (locationOfTouchInLabel.x - textContainerOffset.x), y: 0.0)
                
                let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
                
                if let linkRange = linkRange {
                   
                    if NSLocationInRange(indexOfCharacter, linkRange) {
                        print("Finally success")
                    }
                }
            }
        }
        
        

        
//        guard let range = firstLabel.text?.range(of: "Terms & Conditions")?.nsRange else {
//            return
//        }
//
//        if gesture.didTapAttributedTextInLabel(firstLabel, inRange: range) {
//            // Substring tapped
//            print("Tapped terms")
//        }

        
//        let text = (firstLabel.text)!
//        let termsRange = (text as NSString).range(of: "Terms & Conditions")
//        if gesture.didTapAttributedTextInLabel(label: firstLabel, inRange: termsRange) {
//            print("Tapped terms")
//        }
    }
    
    

}

extension UITapGestureRecognizer {
    
//    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
//        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
//        let layoutManager = NSLayoutManager()
//        let textContainer = NSTextContainer(size: CGSize.zero)
//        let textStorage = NSTextStorage(attributedString: label.attributedText!)
//
//        // Configure layoutManager and textStorage
//        layoutManager.addTextContainer(textContainer)
//        textStorage.addLayoutManager(layoutManager)
//
//        // Configure textContainer
//        textContainer.lineFragmentPadding = 0.0
//        textContainer.lineBreakMode = label.lineBreakMode
//        textContainer.maximumNumberOfLines = label.numberOfLines
//        let labelSize = label.bounds.size
//        textContainer.size = labelSize
//
//        // Find the tapped character location and compare it to the specified range
//        let locationOfTouchInLabel = self.location(in: label)
//        let textBoundingBox = layoutManager.usedRect(for: textContainer)
//
//        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
//        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
//
//        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
//        print("index of char is : \(indexOfCharacter)")
//        print("Bool value is : \(NSLocationInRange(indexOfCharacter, targetRange))")
//        return NSLocationInRange(indexOfCharacter, targetRange)
//    }
    
    func didTapAttributedTextInLabel(_ label: UILabel, inRange targetRange: NSRange) -> Bool {
        let layoutManager = NSLayoutManager()
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        let textContainer = NSTextContainer(size: CGSize.zero)
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(
            x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
            y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y
        )
        let locationOfTouchInTextContainer = CGPoint(x: (locationOfTouchInLabel.x - textContainerOffset.x), y: 0.0)
        let lineModifier = Int(ceil(locationOfTouchInLabel.y / label.font.lineHeight)) - 1
        let rightMostFirstLinePoint = CGPoint(x: labelSize.width, y: 0.0)
        let charsPerLine = layoutManager.characterIndex(for: rightMostFirstLinePoint, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        let adjustedRange = indexOfCharacter + (lineModifier * charsPerLine)
        
        return NSLocationInRange(adjustedRange, targetRange)
    }
}

extension Range where Bound == String.Index {
    var nsRange:NSRange {
        return NSRange(location: self.lowerBound.encodedOffset,
                       length: self.upperBound.encodedOffset -
                        self.lowerBound.encodedOffset)
    }
}


extension UILabel {
    
    func onTappingSubstring(substring: String, perform: Selector, ofTarget target: Any) {
        guard let range = self.text?.range(of: substring), let nsrange = self.text?.nsRange(fromRange:range), let rect = boundingRectForCharacterRange(range: nsrange) else {
            return
        }
        let tappeableView = UIView(frame: rect)
        let tapGeture = UITapGestureRecognizer(target: target, action: perform)
        tappeableView.frame.origin.x = tappeableView.frame.origin.x
        tappeableView.backgroundColor = UIColor.cyan
        tappeableView.addGestureRecognizer(tapGeture)
        addSubview(tappeableView)
    }
    
    
    func boundingRectForCharacterRange(range: NSRange) -> CGRect? {
        
        guard let attributedText = attributedText else { return nil }
        
        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()
        
        textStorage.addLayoutManager(layoutManager)
        
        let textContainer = NSTextContainer(size: bounds.size)
        textContainer.lineFragmentPadding = 0.0
        
        layoutManager.addTextContainer(textContainer)
        
        var glyphRange = NSRange()
        
        // Convert the range for glyphs.
        layoutManager.characterRange(forGlyphRange: range, actualGlyphRange: &glyphRange)
        
        return layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
    }
    
}


extension String {
    func nsRange(fromRange range : Range<String.Index>) -> NSRange? {
        let utf16view = self.utf16
        let from = String.UTF16View.Index(range.lowerBound, within: utf16view)
        let to = String.UTF16View.Index(range.upperBound, within: utf16view)
        
        guard let fromIndex = from, let toIndex = to else { return nil }
        
        let location = distance(from: startIndex, to: fromIndex)
        let length = distance(from: fromIndex, to: toIndex)
        
        return NSRange(location: location, length: length)
    }
}

