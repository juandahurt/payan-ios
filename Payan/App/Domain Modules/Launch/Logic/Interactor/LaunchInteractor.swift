//
//  LaunchInteractor.swift
//  Payan
//
//  Created by juandahurt on 24/10/21.
//

import Foundation
import RxSwift

protocol AnyLaunchInteractor {
    var dataManager: AnyLaunchDataManager { get set }
    
    func checkLatestVersion() -> Single<AppVersionValidation>
    func getRandomFact() -> Single<Fact>
}

final class LaunchInteractor: AnyLaunchInteractor {
    var dataManager: AnyLaunchDataManager
    private var disposeBag = DisposeBag()
    
    init(dataManager: AnyLaunchDataManager) {
        self.dataManager = dataManager
    }
    
    func checkLatestVersion() -> Single<AppVersionValidation> {
        dataManager.getLatestVersion()
            .map({ version in
                let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                let shouldUpdate = currentVersion != version.number
                let validation = AppVersionValidation(shouldUpdate: shouldUpdate, type: version.type)
                return validation
            })
    }
    
    func getRandomFact() -> Single<Fact> {
        dataManager.getRandomFact()
    }
}
