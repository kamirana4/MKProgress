//
//  MKLayerAnimationPersistence.swift
//  MKProgress
//
//  Created by mac on 11/25/18.
//  Copyright © 2018 Muhammad Kamran. All rights reserved.
//

import UIKit

public class MKLayerAnimationPersistence {
    private var persistentAnimations: [String: CAAnimation] = [:]
    private var persistentSpeed: Float = 0.0
    private weak var layer: CALayer?
    
    /// MARK: - Initialization
    public init(with layer: CALayer) {
        self.layer = layer
        addNotificationObservers()
    }
    
    deinit {
        removeNotificationObservers()
    }
}

private extension MKLayerAnimationPersistence {
    func addNotificationObservers() {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(willResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        center.addObserver(self, selector: #selector(didBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    func removeNotificationObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func persistAnimations(with keys: [String]?) {
        guard let layer = self.layer else { return }
        keys?.forEach { (key) in
            if let animation = layer.animation(forKey: key) {
                persistentAnimations[key] = animation
            }
        }
    }
    
    func restoreAnimations(with keys: [String]?) {
        guard let layer = self.layer else { return }
        keys?.forEach { (key) in
            if let animation = persistentAnimations[key] {
                layer.add(animation, forKey: key)
            }
        }
    }
}

@objc extension MKLayerAnimationPersistence {
    func didBecomeActive() {
        guard let layer = self.layer else { return }
        restoreAnimations(with: Array(persistentAnimations.keys))
        persistentAnimations.removeAll()
        /// if layer was playing before background, resume it
        if persistentSpeed == 1.0 {
            layer.resumeAnimations()
        }
    }
    
    func willResignActive() {
        guard let layer = self.layer else { return }
        persistentSpeed = layer.speed
        /// in case layer was paused from outside, set speed to 1.0 to get all animations
        layer.speed = 1.0
        persistAnimations(with: layer.animationKeys())
        /// restore original speed
        layer.speed = persistentSpeed
        layer.pauseAnimations()
    }
}
