import Foundation
import UIKit
import WebKit

class URLViewController: UIViewController {
    
    var url: URL?
    @IBOutlet weak var webView: WKWebView!
    
    fileprivate let activityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.configuration.mediaTypesRequiringUserActionForPlayback = .video
        webView.navigationDelegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.activityIndicatorView)
        activityIndicatorView.startAnimating()
        if let url = url {
            webView.load(URLRequest(url: url))
        }
    }
}

extension URLViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicatorView.stopAnimating()
    }
}
