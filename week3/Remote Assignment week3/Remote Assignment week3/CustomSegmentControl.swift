import UIKit
import Foundation

class CustomSegmentControl: UISegmentedControl {
    let segementTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.black]
    let segementTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.white]
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        selectedSegmentIndex = 0
        self.selectedSegmentTintColor = .black
        
        self.setTitleTextAttributes(segementTextAttribute, for:.normal)
        self.setTitleTextAttributes(segementTextAttributes1, for:.selected)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
    }
}
    
    
    

