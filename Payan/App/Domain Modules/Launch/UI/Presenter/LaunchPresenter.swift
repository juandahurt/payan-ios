//
//  LaunchPresenter.swift
//  Payan
//
//  Created by juandahurt on 24/10/21.
//

import Foundation
import RxCocoa
import RxSwift

protocol LaunchViewInput {
    var randomFact: Driver<Fact> { get }
}

protocol LaunchViewOutput {
    func getData()
}

final class LaunchPresenter: BasePresenter {
    var router: LaunchRouter
    var interactor: AnyLaunchInteractor
    private var disposeBag = DisposeBag()
    internal var versionType: AppVersionType?
    internal var randomFactSubject = PublishSubject<Fact>()
    
    init(interactor: AnyLaunchInteractor, router: LaunchRouter) {
        self.interactor = interactor
        self.router = router
    }
}

extension LaunchPresenter: LaunchViewInput {
    var randomFact: Driver<Fact> {
        randomFactSubject.asDriver(onErrorDriveWith: .never())
    }
}

extension LaunchPresenter: LaunchViewOutput {
    func getData() {
        interactor.getRandomFact().asObservable()
            .concatMap { [weak self] fact -> Observable<Int> in
                guard let self = self else {
                    return Observable.just(0)
                }
                
                DispatchQueue.main.async {
                    self.randomFactSubject.onNext(fact)
                }
                return Observable<Int>.timer(.seconds(3), scheduler: MainScheduler.instance).asObservable()
            }.concatMap({ _ -> Observable<AppVersionValidation> in
                self.interactor.checkLatestVersion().asObservable()
            }).map { [weak self] validation in
                guard let self = self else { return }
                
                if validation.shouldUpdate {
                    self.versionType = validation.type
                    DispatchQueue.main.async {
                        self.router.showAppUpdateModule(
                            dataSource: self,
                            delegate: self
                        )
                    }
                } else {
                    DispatchQueue.main.async {
                        self.router.showMainModule()
                    }
                }
            }
            .subscribe()
            .disposed(by: disposeBag)
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
