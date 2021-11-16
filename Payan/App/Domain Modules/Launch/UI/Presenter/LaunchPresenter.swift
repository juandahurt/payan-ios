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
    var router: LaunchRouter
    var interactor: AnyLaunchInteractor
    private var disposeBag = DisposeBag()
    internal var versionType: AppVersionType?
    
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
                    self?.versionType = validation.type
                    DispatchQueue.main.async {
                        self?.router.showAppUpdateModule(
                            dataSource: self!,
                            delegate: self!
                        )
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.router.showMainModule()
                    }
                }
            }
        ).disposed(by: disposeBag)
    }
}

// MARK: - App Update Module Delegate
extension LaunchPresenter: AppUpdateModuleDelegate {
    func didDismiss() {
        router.showMainModule()
    }
}

// MARK: - App Update Module Data Source
extension LaunchPresenter: AppUpdateModuleDataSource {
    func latestVersionType() -> AppVersionType {
        versionType ?? .optional
    }
}
