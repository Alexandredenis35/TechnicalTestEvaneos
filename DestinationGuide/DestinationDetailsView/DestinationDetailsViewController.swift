import UIKit
import WebKit

class DestinationDetailsViewController: UIViewController {
    @IBOutlet private var webView: WKWebView!
    @IBOutlet private var loaderIndicator: UIActivityIndicatorView!

    var viewModel: DestinationDetailsViewModel?

    let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = UIColor.evaneos(color: .veraneos)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        return spinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoader()
        setupWebview()
        navigationItem.title = viewModel?.name
    }

    private func setupLoader() {
        loaderIndicator.color = UIColor.evaneos(color: .veraneos)
    }

    private func setupWebview() {
        webView.navigationDelegate = self
        guard let url = viewModel?.webviewUrl else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

// MARK: - WKNavigationDelegate extension
extension DestinationDetailsViewController: WKNavigationDelegate {
    func showActivityIndicator(show: Bool) {
        if show {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

    func webView(_: WKWebView, didFinish _: WKNavigation!) {
        showActivityIndicator(show: false)
    }

    func webView(_: WKWebView, didStartProvisionalNavigation _: WKNavigation!) {
        showActivityIndicator(show: true)
    }

    func webView(_: WKWebView, didFail _: WKNavigation!, withError _: Error) {
        showActivityIndicator(show: false)
    }
}
