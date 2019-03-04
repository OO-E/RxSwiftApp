//
//  MoreDetailViewController.swift
//  RxSwiftApp
//
//  Created by Gökhan Aydın on 1.03.2019.
//  Copyright © 2019 Gökhan Aydın. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Nuke

final class MoreDetailViewController: ViewController {
    
    var viewModel: MoreDetailViewModel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var cloudinessLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var weatherInfoLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func bindViewModel() {
        
        let input = MoreDetailViewModel.Input(ready: rx.viewWillAppear.asDriver(),
                                              backTrigger: closeButton.rx.tap.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.result
            .drive(onNext: { [weak self] data in
                guard let data = data,
                    let strongSelf = self else { return }
                let urlString = "https://openweathermap.org/img/w/ICON_NAME.png".replacingOccurrences(of: "ICON_NAME", with: "\(data.weather?.first?.icon ?? "")")
                Nuke.loadImage(with: URL(string: urlString)!, into: strongSelf.weatherImageView)
                strongSelf.weatherInfoLabel.text = data.weather?.first?.main
                strongSelf.windLabel.text = "\(String(format: "%.2f", (data.wind?.speed)!)) m/s, direction \(String(format: "%.2f", (data.wind?.deg)!))"
                strongSelf.cloudinessLabel.text = data.weather?.first?.modelDescription
                strongSelf.pressureLabel.text = "\(data.main?.pressure ?? 0) hpa"
                strongSelf.humidityLabel.text = "\(data.main?.humidity ?? 0) %"
            })
            .disposed(by: disposeBag)
        
        output.back
            .drive()
            .disposed(by: disposeBag)
        
    }
}
