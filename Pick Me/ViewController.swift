import UIKit
import Foundation

protocol CountdownDelegate {
    func countdownDidUpdate(to time: Int?)
}

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var touchableView: ConcreteTouchableView!
    @IBOutlet weak var countdownLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        touchableView.delegate = self
    }


}

extension ViewController: CountdownDelegate {
    func countdownDidUpdate(to time: Int?) {
        guard let time = time else {
            countdownLabel.text = nil
            return
        }
        countdownLabel.text = "\(time)"
    }
}




