//
//  DetailViewController.swift
//  TwitterSearches
//
//  Created by Admin on 4/25/16.
//  Copyright © 2016 Morra. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var webView: UIWebView! // display search results
    var detailItem: NSURL? // URL that will be displayed

    /* var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    } */

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.valueForKey("timeStamp")!.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        //self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // after view appears, load search result into web view
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if let url = self.detailItem {
            webView.loadRequest(NSURLRequest(URL: url))
        }
        
    }
    
    // stop page load and hide network activity indicator when returning to MasterViewController
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        webView.stopLoading()
        
    }
    
    
    // when loading starts, show network activity indicator
    func webViewDidStartLoad(webView: UIWebView) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
    }
    
    
    // hide network activity indicator when page finishes loading
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    
    // display static web page if error occurs
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
        webView.loadHTMLString("<html><body><p>An error occured when performing the Twitter search: \(error?.description) </body></html>", baseURL: nil)
        
    }


}

