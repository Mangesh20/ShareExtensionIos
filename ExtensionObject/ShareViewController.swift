//
//  ShareViewController.swift
//  ExtensionObject
//
//  Created by Maheshwari on 12/05/16.
//  Copyright © 2016 Maheshwari. All rights reserved.
//
//https://developer.apple.com/library/ios/documentation/General/Conceptual/ExtensibilityPG/ExtensionScenarios.html
import UIKit
import MobileCoreServices
import Social

class ShareViewController: SLComposeServiceViewController {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var infoTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        for item: AnyObject in (self.extensionContext?.inputItems)! {
            let inputItem = item as! NSExtensionItem
            for provider: AnyObject in inputItem.attachments! {
                let itemProvider = provider as! NSItemProvider
                
                if itemProvider.hasItemConformingToTypeIdentifier(kUTTypePropertyList as String) {
                    itemProvider.loadItemForTypeIdentifier(kUTTypePropertyList as String, options: nil, completionHandler: { (result: NSSecureCoding?, error: NSError!) -> Void in
                        if let resultDict = result as? NSDictionary {
                            print(resultDict)
                        }
                    })
                }
            }
        }

    }
    

    override func didSelectPost() {
        // Perform the post operation.
        // When the operation is complete (probably asynchronously), the Share extension should notify the success or failure, as well as the items that were actually shared.
        super.didSelectPost()
        
        for item: AnyObject in (self.extensionContext?.inputItems)! {
            let inputItem = item as! NSExtensionItem
            
            for provider: AnyObject in inputItem.attachments! {
                let itemProvider = provider as! NSItemProvider
                
                if itemProvider.hasItemConformingToTypeIdentifier(kUTTypePropertyList as String) {
                    itemProvider.loadItemForTypeIdentifier(kUTTypePropertyList as String, options: nil, completionHandler: { (result: NSSecureCoding?, error: NSError!) -> Void in
                        if let resultDict = result as? NSDictionary {
                            print(resultDict)
                        }
                    })
                }
            }
        }

    }
    override func didSelectCancel() {
        
    }
}
