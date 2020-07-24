//
//  Extensiones.swift
//  FilimoVit
//
//  Created by Ehsan Askari on 7/18/20.
//  Copyright © 2020 Ehsan Askari. All rights reserved.
//

import UIKit

extension UIView {
    
    func forceRTL () {
        self.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
    
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    
    func addBlurEffect(alpha: CGFloat) {
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView.frame = self.bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        visualEffectView.alpha = alpha
        self.insertSubview(visualEffectView, at: 1)
    }
    
}

extension UIViewController {
    func showAlertView(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(alertController, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            alertController.dismiss(animated: true)
        }
    }
}

extension UIImageView {
    
    func setImage(withURL url: String) {
        guard let imageURL = URL(string: url) else {
            return
        }
        
        let urlCacheShared =  URLCache.shared //4 + 20 MB
        let urlRequest = URLRequest(url: imageURL)
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = urlCacheShared.cachedResponse(for: urlRequest)?.data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                URLSession.shared.dataTask(with: urlRequest) { (data, urlResponse, error) in
                    if let urlResponse = urlResponse, let httpURLResponseStatusCode = (urlResponse as? HTTPURLResponse)?.statusCode, httpURLResponseStatusCode == 200, let data = data, let image = UIImage(data: data) {
                        let cachedURLResponse = CachedURLResponse(response: urlResponse, data: data)
                        urlCacheShared.storeCachedResponse(cachedURLResponse, for: urlRequest)
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                }.resume()
            }
        }
    }
    
}
