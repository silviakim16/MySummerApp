//
//  ListItemInfoContentViewController.swift
//  SummerApp
//
//  Created by Silvia  Kim on 7/26/17.
//  Copyright © 2017 Silvia  Kim. All rights reserved.
//

import UIKit

class ListItemInfoContentViewController: UIViewController {

    var selectedItem: Item?
    
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedItem != nil {
            webView.loadHTMLString(selectedItem!.htmlString, baseURL: Bundle.main.url(forResource: "ContentStyle", withExtension: "css"))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
