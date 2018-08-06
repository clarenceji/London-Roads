//
//  DetailViewController.swift
//  London Roads
//
//  Created by Clarence Ji on 8/5/18.
//  Copyright © 2018 Clarence Ji. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var moreDetailsTextView: UITextView!
    
    var road: Road?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = road?.displayName ?? "Road status"
        statusLabel.text = road?.statusSeverity ?? "Unknown"
        moreDetailsTextView.text = road?.statusSeverityDescription ?? "Sorry, we can't display this information right now."
        
        self.navigationController?.navigationBar.tintColor = .white
        
    }

}
