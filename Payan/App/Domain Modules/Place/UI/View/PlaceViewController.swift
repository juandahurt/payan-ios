//
//  PlaceViewController.swift
//  Payan
//
//  Created by juandahurt on 15/11/21.
//

import UIKit

class PlaceViewController: UIViewController {
    var input: PlaceViewInput
    
    init(presenter: PlaceViewInput) {
        self.input = presenter
        
        super.init(nibName: String(describing: PlaceViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        Console.log("init(coder:) has not been implemented", level: .error)
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        label.text = input.selectedPlace.name
        label.center = view.center
        view.addSubview(label)
    }

}
