//
//  MKProgressBase.swift
//  MKProgress
//
//  Created by Muhammad Kamran on 3/29/17.
//  Copyright © 2017 Muhammad Kamran. All rights reserved.
//

import UIKit

protocol ProgressViewDataSource {
    func configureView()
}

protocol ProgressViewDataDelegate {
    func stopAnimation()
}

class MKProgressBaseView: UIView, ProgressViewDataSource, ProgressViewDataDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Fatal error occurred while setup!")
    }
    
    func configureView() {
        let config = MKProgress.config
        clipsToBounds = true
        layer.cornerRadius = config.cornerRadius
        backgroundColor = config.hudColor
    }
    
    func stopAnimation() {
        // Implement to provide functionality
    }
}

public extension CALayer {
    static private var persistentHelperKey = "CALayer.LayerPersistentHelper"
    
    func makeAnimationsPersistent() {
        var object = objc_getAssociatedObject(self, &CALayer.persistentHelperKey)
        if object == nil {
            object = LayerPersistentHelper(with: self)
            let nonatomic = objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            objc_setAssociatedObject(self, &CALayer.persistentHelperKey, object, nonatomic)
        }
    }
}

public class LayerPersistentHelper {
    private var persistentAnimations: [String: CAAnimation] = [:]
    private var persistentSpeed: Float = 0.0
    private weak var layer: CALayer?
    
    public init(with layer: CALayer) {
        self.layer = layer
        addNotificationObservers()
    }
    
    deinit {
        removeNotificationObservers()
    }
}

private extension LayerPersistentHelper {
    func addNotificationObservers() {
        let center = NotificationCenter.default
        let enterForeground = UIApplication.willEnterForegroundNotification
        let enterBackground = UIApplication.didEnterBackgroundNotification
        center.addObserver(self, selector: #selector(didBecomeActive), name: enterForeground, object: nil)
        center.addObserver(self, selector: #selector(willResignActive), name: enterBackground, object: nil)
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

@objc extension LayerPersistentHelper {
    func didBecomeActive() {
        guard let layer = self.layer else { return }
        restoreAnimations(with: Array(persistentAnimations.keys))
        persistentAnimations.removeAll()
        if persistentSpeed == 1.0 { // if layer was playing before background, resume it
            layer.resumeAnimations()
        }
    }
    
    func willResignActive() {
        guard let layer = self.layer else { return }
        persistentSpeed = layer.speed
        layer.speed = 1.0 // in case layer was paused from outside, set speed to 1.0 to get all animations
        persistAnimations(with: layer.animationKeys())
        layer.speed = persistentSpeed // restore original speed
        layer.pauseAnimations()
    }
}

public extension CALayer {
    var isAnimationsPaused: Bool {
        return speed == 0.0
    }
    
    func pauseAnimations() {
        if !isAnimationsPaused {
            let currentTime = CACurrentMediaTime()
            let pausedTime = convertTime(currentTime, from: nil)
            speed = 0.0
            timeOffset = pausedTime
        }
    }
    
    func resumeAnimations() {
        let pausedTime = timeOffset
        speed = 1.0
        timeOffset = 0.0
        beginTime = 0.0
        let currentTime = CACurrentMediaTime()
        let timeSincePause = convertTime(currentTime, from: nil) - pausedTime
        beginTime = timeSincePause
    }
}
