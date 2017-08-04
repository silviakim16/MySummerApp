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
        
        webView.delegate = self
        
        if selectedItem != nil {
            webView.loadHTMLString(selectedItem!.htmlString, baseURL: Bundle.main.url(forResource: "ContentStyle", withExtension: "css"))
        }
        
        //
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//<a href="https://icons8.com/icon/57007/US-Dollar-Filled">Us dollar filled icon credits</a>
//<a href="https://icons8.com/icon/57007/US-Dollar-Filled">Us dollar filled icon credits</a>  
    
//<a href="https://icons8.com/icon/9482/Law-Filled">Law filled icon credits</a>
//<a href="https://icons8.com/icon/9482/Law-Filled">Law filled icon credits</a>

//    <a href="https://icons8.com/icon/25195/Wise-Mind">Wise mind icon credits</a>
//    
//    <!-- US Dollar icon by Icons8 -->
//    <img src="https://png.icons8.com/us-dollar/ios7/25" title="US Dollar" width="25" height="25">
//    
//    <a href="https://icons8.com/icon/2341/University">University icon credits</a>
}


//Manages the web stuff
extension ListItemInfoContentViewController: UIWebViewDelegate {
    //gets called automatically wen it detects
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        switch navigationType {
        case .linkClicked:
            guard let url = request.url else { return true}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            return false
        default:
            return true
        }
    }
}





