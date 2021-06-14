import Foundation
import UIKit

class TouchableView: UIView {
    
    private let countdownLength = 4
    private var touchViews = [UITouch:TouchSpotView]()
    private var seconds = 0
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
            createView(for: touch)
        }
        
        seconds = countdownLength
        
        guard let timer = timer, timer.isValid else {
            self.timer = Timer.scheduledTimer(timeInterval: 0.4,
                                              target: self,
                                              selector: #selector(update),
                                              userInfo: nil,
                                              repeats: true)
            return }
    }
    
    @objc
    private func update() {
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
    
    private func createView(for touch: UITouch) {
        let newView = TouchSpotView(diameter: 100,
                                    center: touch.location(in: self))
        
        addSubview(newView)
        newView.animateEntry()
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
