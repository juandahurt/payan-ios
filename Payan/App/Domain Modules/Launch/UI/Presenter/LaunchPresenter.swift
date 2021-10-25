//
//  LaunchPresenter.swift
//  Payan
//
//  Created by juandahurt on 24/10/21.
//

import Foundation
import RxSwift

protocol LaunchViewOutput {
    func showHomeModule()
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
            .subscribe(onSuccess: { _ in
                // TODO: Show bottom sheet
            }
        ).disposed(by: disposeBag)
    }
    
    func showHomeModule() {
        (router as! LaunchRouter).showMainModule()
    }
}
