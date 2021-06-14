import Foundation
import UIKit

class TouchSpotView : UIView {
    
    let diameter: Int
    
    init(diameter: Int, center: CGPoint, colour: UIColor = .random()) {
        self.diameter = diameter
        let frame = CGRect(origin: .zero, size: CGSize.zero)
        super.init(frame: frame)
        backgroundColor = colour
        self.center = center
    }
    
    required init?(coder aDecoder: NSCoder) {
        diameter = 100
        super.init(coder: aDecoder)
    }
    
    override var bounds: CGRect {
        get { return super.bounds }
        set(newBounds) {
            super.bounds = newBounds
            layer.cornerRadius = newBounds.size.width / 2.0
        }
    }
    
    func animateEntry() {
        UIView.animate(withDuration: 0.2) {
            self.bounds.size = CGSize(width: self.diameter, height: self.diameter)
        }
    }
}
