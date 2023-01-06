//
//  SKStoreReviewController+Extension.swift
//  habit
//
//  Created by web_dev on 2023/01/06.
//

import StoreKit
import UIKit


extension SKStoreReviewController {
    public static func requestReviewInCurrentScene() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            DispatchQueue.main.async {
                requestReview(in: scene)
            }
        }
    }
}
