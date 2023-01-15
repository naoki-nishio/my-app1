import Foundation
import SwiftUI
import GoogleMobileAds

struct BannerView: UIViewRepresentable {
    let viewController: UIViewController
    let windowScene: UIWindowScene?
    
    func makeCoordinator() -> Coordinator {
        .init()
    }
    
    func makeUIView(context: Context) -> GADBannerView {
        let bannerView = GADBannerView()
        bannerView.delegate = context.coordinator
        bannerView.rootViewController = viewController
        bannerView.adUnitID = "ca-app-pub-8979621487536159/8271665356"
        let request = GADRequest()
        request.scene = windowScene
        bannerView.load(request)
        return bannerView
    }
    

    
    class Coordinator: NSObject, GADBannerViewDelegate {
        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        }
    }
}
