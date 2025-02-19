//  Created by Kim Young Hee

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var helloLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        helloLabel.text = "button pressed!"
        
    }
    

}

