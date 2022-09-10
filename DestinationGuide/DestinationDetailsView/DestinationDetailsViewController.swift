import UIKit
import WebKit

final class DestinationDetailsViewController: UIViewController {
    @IBOutlet private var webView: WKWebView!

    var viewModel: DestinationDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebview()
        navigationItem.title = viewModel?.name
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
    func webView(_: WKWebView, didFinish _: WKNavigation!) {
        hideLoader()
    }

    func webView(_: WKWebView, didStartProvisionalNavigation _: WKNavigation!) {
        showLoader()
    }

    func webView(_: WKWebView, didFail _: WKNavigation!, withError _: Error) {
        hideLoader()
    }
}
