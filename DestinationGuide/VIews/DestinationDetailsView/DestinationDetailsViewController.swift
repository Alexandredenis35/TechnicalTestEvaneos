import UIKit
import WebKit

// MARK: - DestinationDetailsViewController
final class DestinationDetailsViewController: UIViewController {
    // MARK: IBOutlets

    @IBOutlet private var webView: WKWebView!

    // MARK: Properties

    var viewModel: DestinationDetailsViewModel?

    // MARK: View controller lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel?.name
        setupWebview()
    }

    // MARK: Private functions

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
