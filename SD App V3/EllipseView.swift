import UIKit

class EllipseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear // Make background transparent
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.addEllipse(in: rect) // Add an ellipse path to the context
        context.setFillColor(UIColor.blue.cgColor) // Set the fill color
        context.fillPath() // Fill the ellipse
    }
}
