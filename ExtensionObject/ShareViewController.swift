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

class ShareViewController: SLComposeServiceViewController, ColorSelectionViewControllerDelegate {
    let suiteName = "group.deegeu.swift.share.extension"
    let redDefaultKey = "RedColorImage"
    let blueDefaultKey = "BlueColorImage"
    
    var selectedImage: UIImage?
    var selectedColorName = "Default"
    

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var infoTextView: UITextView!
    var dictGlobal =  [String: AnyObject]()
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
                            self.dictGlobal = resultDict as! [String : AnyObject]
                        }
                    })
                }
            }
        }
    }
    
    override func configurationItems() -> [AnyObject]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return [colorConfigurationItem]
    }
    
    // Builds a configuration item when we need it. This one is for the "Color"
    // configuration item.
    lazy var colorConfigurationItem: SLComposeSheetConfigurationItem = {
        let item = SLComposeSheetConfigurationItem()
        item.title = "Color"
        item.value = self.selectedColorName
        item.tapHandler = self.showColorSelection
        return item
    }()
    
    // Shows a view controller when the user selects a configuration item
    func showColorSelection() {
        let controller = ColorSelectionViewController(style: .Plain)
        controller.selectedColorName = colorConfigurationItem.value
        controller.delegate = self
        pushConfigurationViewController(controller)
    }
    
    // One the user selects a configuration item (color), we remember the value and pop
    // the color selection view controller
    func colorSelection(sender: ColorSelectionViewController, selectedValue: String) {
        colorConfigurationItem.value = selectedValue
        selectedColorName = selectedValue
        popConfigurationViewController()
    }
    
    // Saves an image to user defaults.
    func saveImage(color: String, imageData: NSData) {
        if let prefs = NSUserDefaults(suiteName: suiteName) {
            prefs.removeObjectForKey(color)
            prefs.setObject(imageData, forKey: color)
        }
    }
    
    override func loadPreviewView() -> UIView! {
        let data = NSData.init(contentsOfURL: NSURL.init(string: "http://simpleicon.com/wp-content/uploads/pencil.png")!)
        self.iconImageView.image = UIImage.init(data: data!)
        
        return UIView.init()
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
                            self.dictGlobal = resultDict as! [String : AnyObject]
                        }
                    })
                }
            }
        }

    }
    override func didSelectCancel() {
        
    }
}
