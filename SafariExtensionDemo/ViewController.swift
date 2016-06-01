//
//  ViewController.swift
//  SafariExtensionDemo
//
//  Created by Maheshwari on 12/05/16.
//  Copyright © 2016 Maheshwari. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let content = extensionContext!.inputItems[0] as! NSExtensionItem
        let contentType = kUTTypeImage as String
        
        for attachment in content.attachments as! [NSItemProvider] {
            if attachment.hasItemConformingToTypeIdentifier(contentType) {
                
                attachment.loadItemForTypeIdentifier(contentType, options: nil) { data, error in
                    if error == nil {
                        let url = data as! NSURL
                        if NSData(contentsOfURL: url) != nil {
//                            self.selectedImage = UIImage(data: imageData)
                        }
                    } else {
                        
                        let alert = UIAlertController(title: "Error", message: "Error loading image", preferredStyle: .Alert)
                        
                        let action = UIAlertAction(title: "Error", style: .Cancel) { _ in
                            self.dismissViewControllerAnimated(true, completion: nil)
                        }
                        
                        alert.addAction(action)
                        self.presentViewController(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

