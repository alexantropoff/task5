//
//  ViewController.swift
//  task5
//
//  Created by Alex Antropoff on 14.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let myButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        myButton.setTitle("Present", for: .normal)
        //   myButton.tintColor = .blue
        myButton.setTitleColor(.blue, for: .normal)
        myButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(myButton)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        myButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 16)
        ])
    }
    @objc func buttonTapped(){
        let vc = PopoverController()
        vc.modalPresentationStyle = .popover
        vc.preferredContentSize = CGSize(width: 300, height: 280)
        
        if let pop = vc.popoverPresentationController {
            pop.permittedArrowDirections = .up
            pop.sourceView = self.view
            pop.sourceRect = myButton.frame
            pop.delegate = self
            present(vc, animated: true)
        }
    }
}

class PopoverController: UIViewController{
    let closeButton = UIButton()
    let segmentedControl = UISegmentedControl(items: ["280pt", "150pt"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        view.addSubview(closeButton)
        segmentedControl.selectedSegmentIndex = 0
        view.addSubview(segmentedControl)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.sizeToFit()
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        ])
        
    }
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            UIView.animate(withDuration: 0.3) {
                self.preferredContentSize = CGSize(width: 300, height: 280)
            }
        case 1:
            UIView.animate(withDuration: 0.3) {
                self.preferredContentSize = CGSize(width: 300, height: 150)
            }
        default:
            break
        }
    }
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}
extension ViewController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return false
    }
}
