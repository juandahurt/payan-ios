//
//  LaunchPresenter.swift
//  Payan
//
//  Created by juandahurt on 24/10/21.
//

import Foundation
import RxSwift

protocol LaunchViewOutput {
    func checkLatestVersion()
}

final class LaunchPresenter: BasePresenter {
    var router: BaseRouter
    var interactor: AnyLaunchInteractor
    private var disposeBag = DisposeBag()
    
    init(interactor: AnyLaunchInteractor, router: LaunchRouter) {
        self.interactor = interactor
        self.router = router
    }
}

extension LaunchPresenter: LaunchViewOutput {
    func checkLatestVersion() {
        interactor.checkLatestVersion()
            .subscribe(onSuccess: { [weak self] validation in
                if validation.shouldUpdate {
                    DispatchQueue.main.async {
                        (self?.router as! LaunchRouter).showAppUpdateModule()
                    }
                } else {
                    (self?.router as! LaunchRouter).showMainModule()
                }
            }
        ).disposed(by: disposeBag)
    }
}
