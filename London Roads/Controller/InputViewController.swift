//
//  InputViewController.swift
//  London Roads
//
//  Created by Clarence Ji on 8/5/18.
//  Copyright © 2018 Clarence Ji. All rights reserved.
//

import UIKit

private let toDetailSegue = "InputToDetailSegue"

class InputViewController: UIViewController {

    @IBOutlet weak var textFieldWrapperView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var getStatusButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let apiService = APIService()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        textField.delegate = self
        
        makeRoundedCorners()
        addTapToDismissKeyboard()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        resetButton()
    }
    
    private func makeRoundedCorners() {
        textFieldWrapperView.layer.cornerRadius = 8
        getStatusButton.layer.cornerRadius = 8
    }
    
    private func addTapToDismissKeyboard() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func animateActivityIndicator() {
        DispatchQueue.main.async {
            self.getStatusButton.isEnabled = false
            self.getStatusButton.setTitle(nil, for: .normal)
            self.activityIndicator.startAnimating()
        }
    }
    
    private func resetButton() {
        DispatchQueue.main.async {
            self.getStatusButton.isEnabled = true
            self.getStatusButton.setTitle("Get status", for: .normal)
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }
    
    @objc private func dismissKeyboard() {
        DispatchQueue.main.async {
            self.textField.resignFirstResponder()
        }
    }
    
    private func presentError(_ reason: String) {
        
        let alertController = UIAlertController(title: reason, message: "Please try again.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func getStatusButtonTapped(_ sender: Any) {
        
        animateActivityIndicator()
        
        apiService.statusUpdate(forRoadID: textField.text ?? "") { (result, road) in
            
            switch result {
                
            case .failed(error: let error):
                self.resetButton()
                let errorMsg = error?._code == -1009 ? "The internet appears to be offline." : "Sorry, something went wrong."
                self.presentError(errorMsg)
                
            case .successful:
                
                guard road != nil else {
                    // Road is not defined in TfL API.
                    self.resetButton()
                    self.presentError("The road name you entered cannot be found.")
                    return
                }
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: toDetailSegue, sender: road!)
                }
                
            }
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if sender is Road {
            
            let destination = segue.destination as! DetailViewController
            destination.road = sender as? Road
            
        }
        
    }
    
}

extension InputViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        DispatchQueue.main.async {
            textField.resignFirstResponder()
        }
        
        return true
        
    }
    
}
