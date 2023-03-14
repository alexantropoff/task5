//
//  ViewController.swift
//  task5
//
//  Created by Alex Antropoff on 14.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    let myButton = MyButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        myButton.setTitle("Present", for: .normal)
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

class PopoverController: UIViewController{
    let closeButton = UIButton()
    let segmentedControl = UISegmentedControl(items: ["280pt", "150pt"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.tintColor = .gray.withAlphaComponent(0.5)
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
        print(segmentedControl.bounds.height)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: segmentedControl.bounds.height - 4 , weight: .regular, scale: .default)
        closeButton.setImage(UIImage(systemName: "xmark.circle.fill", withConfiguration: largeConfig), for: .normal)

        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -16),
            closeButton.centerYAnchor.constraint(equalTo: segmentedControl.centerYAnchor),
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
class MyButton: UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override func tintColorDidChange(){
        super.tintColorDidChange()
        if(tintAdjustmentMode == .dimmed){
            setTitleColor(.gray, for: .normal)
        }else{
            setTitleColor(.blue, for: .normal)
        }
    }
}

