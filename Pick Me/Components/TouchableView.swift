import Foundation
import UIKit

class TouchableView: UIView {
    var touchViews = [UITouch:TouchSpotView]()
    var seconds = 4
    var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isMultipleTouchEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isMultipleTouchEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            createViewForTouch(touch: touch)
        }
        guard let timer = timer else {
            seconds = 4
            self.timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(update), userInfo: nil, repeats: true)
            return }
        if timer.isValid {
            seconds = 4
        } else {
            seconds = 4
            self.timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func update() {
        if(seconds == 0) {
            print("DONE!")
            for touch in touchViews {
                touch.value.removeFromSuperview()
            }
            timer?.invalidate()
        } else {
            seconds -= 1
            print(seconds)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let view = viewForTouch(touch: touch)
            // Move the view to the new location.
            let newLocation = touch.location(in: self)
            view?.center = newLocation
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            removeViewForTouch(touch: touch)
        }
        if touchViews.isEmpty {
            timer?.invalidate()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            removeViewForTouch(touch: touch)
        }
    }
    
    func createViewForTouch( touch : UITouch ) {
        let newView = TouchSpotView()
        newView.bounds = CGRect(x: 0, y: 0, width: 3, height: 3)
        newView.center = touch.location(in: self)
        
        // Add the view and animate it to a new size.
        addSubview(newView)
        UIView.animate(withDuration: 0.2) {
            newView.bounds.size = CGSize(width: 100, height: 100)
        }
        
        // Save the views internally
        touchViews[touch] = newView
    }
    
    func viewForTouch (touch : UITouch) -> TouchSpotView? {
        return touchViews[touch]
    }
    
    func removeViewForTouch (touch : UITouch ) {
        if let view = touchViews[touch] {
            view.removeFromSuperview()
            touchViews.removeValue(forKey: touch)
        }
    }
}
