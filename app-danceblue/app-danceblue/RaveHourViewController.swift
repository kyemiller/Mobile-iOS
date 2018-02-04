//
//  RaveHourViewController.swift
//  app-danceblue
//
//  Created by Blake Swaidner on 2/1/18.
//  Copyright © 2018 DanceBlue. All rights reserved.
//

import UIKit

class RaveHourViewController: UIViewController {

    let colors = [Theme.Color.Rave.blue, Theme.Color.Rave.red, Theme.Color.Rave.green]
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        startRave()
    }
    
    func startRave() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(changeColor), userInfo: nil, repeats: true)
    }
     
    func changeColor() {
        let second = Calendar.current.component(.second, from: Date())
        view.backgroundColor = colors[second % 3]
    }
    
}
