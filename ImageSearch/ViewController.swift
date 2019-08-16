//
//  ViewController.swift
//  ImageSearch
//
//  Created by Mobile Team 3 on 12/12/17.
//  Copyright © 2017 Mobile Team 3. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? ImagesViewController
        destinationVC?.searchTerm = inputField.text
    }


}

