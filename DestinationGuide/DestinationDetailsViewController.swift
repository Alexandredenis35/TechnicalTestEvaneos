import UIKit
import WebKit

class DestinationDetailsController: UIViewController {
    let name: String
    let webviewUrl: URL

    init(title: String, webviewUrl: URL) {
        name = title
        self.webviewUrl = webviewUrl

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable) required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.color = UIColor.evaneos(color: .veraneos)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        return spinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        webView.navigationDelegate = self

        addView()

        navigationItem.title = name

        let request = URLRequest(url: webviewUrl)
        webView.load(request)
    }

    // MARK: - Functions

    private func addView() {
        view.addSubview(webView)
        view.addSubview(activityIndicator)
        constraintInit()
    }

    private func constraintInit() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
        ])

        activityIndicator.center = view.center
    }
}

// MARK: - WKNavigationDelegate extension
extension DestinationDetailsController: WKNavigationDelegate {
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
