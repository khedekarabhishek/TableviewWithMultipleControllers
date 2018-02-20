//
//  SecondViewController.swift
//  TableviewWithMultipleControllers
//
//  Created by Abhishek Khedekar on 10/01/18.
//  Copyright © 2018 Abhishek Khedekar. All rights reserved.
//

import UIKit

//class SecondViewController: UIViewController {
//
//    @IBOutlet weak var myTextView: UITextView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    func setAttributedTextToLabel() {
//
//        myTextView.isUserInteractionEnabled = true
//
//        let text = "By signing up you agree to our Terms & Conditions and Privacy Policy"
//        let underlineAttriString = NSMutableAttributedString(string: text)
//        let range1 = (text as NSString).range(of: "Terms & Conditions")
//        underlineAttriString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: range1)
//        myTextView.attributedText = underlineAttriString
//        myTextView.delegate = self
//    }
//
//}
//
//
//extension SecondViewController : UITextViewDelegate {
//
//    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
//
//    }
//}





class SecondViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var myTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //****textview = Selectable = checked, and Editable = Unchecked
        
        
        let theString = NSMutableAttributedString(string: "Agree to Terms")
        let theRange = theString.mutableString.range(of: "Terms")
        
        theString.addAttribute(NSAttributedStringKey.link, value: "ContactUs://", range: theRange)
        
//        let theAttribute = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.blue, NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue] as! [String : Any]

        myTextView.linkTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue : UIColor.blue, NSAttributedStringKey.underlineStyle.rawValue : NSUnderlineStyle.styleSingle.rawValue]
        
        myTextView.attributedText = theString
        
        theString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: theRange)

//        theString.setAttributes(theAttribute, range: theRange)
        
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if (URL.scheme?.hasPrefix("ContactUs://"))! {
            
            return false //interaction not allowed
        }
        
        //*** Set storyboard id same as VC name
        self.navigationController!.pushViewController((self.storyboard?.instantiateViewController(withIdentifier: "TheLastViewController"))! as UIViewController, animated: true)
        
        return true
    }
    
}




