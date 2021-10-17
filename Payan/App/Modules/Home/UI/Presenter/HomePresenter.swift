//
//  HomePresenter.swift
//  Payan
//
//  Created by juandahurt on 3/10/21.
//

import RxSwift
import RxCocoa


protocol HomeViewInput {
    var sectionsDriver: Driver<[HomeSection]> { get }
    
    func sectionType(forIndex index: Int) -> HomeSectionType?
    func titleForSection(atIndex index: Int) -> String?
}

protocol HomeViewOutput {
    func getData()
}

final class HomePresenter: BasePresenter {
    // MARK: - Attributes
    var router: BaseRouter
    var interactor: AnyHomeInteractor
    private var disposeBag = DisposeBag()
    
    // MARK: - Subjects
    var sectionsSubject = BehaviorSubject<[HomeSection]>(value: [])
    
    init(interactor: AnyHomeInteractor, router: HomeRouter) {
        self.interactor = interactor
        self.router = router
    }
}

extension HomePresenter: HomeViewInput {
    func sectionType(forIndex index: Int) -> HomeSectionType? {
        guard let value = try? sectionsSubject.value() else {
            return nil
        }
        guard let section = value.indices.contains(index) ? value[index] : nil else {
            return nil
        }
        return section.type
    }
    
    func titleForSection(atIndex index: Int) -> String? {
        guard let value = try? sectionsSubject.value() else {
            return nil
        }
        guard let section = value.indices.contains(index) ? value[index] : nil else {
            return nil
        }
        return section.title
    }
    
    var sectionsDriver: Driver<[HomeSection]> {
        sectionsSubject.asDriver(onErrorDriveWith: .never())
    }
}

extension HomePresenter: HomeViewOutput {
    func getData() {
        emitLoading()
        interactor.listPlaces().subscribe(
            onSuccess: { [weak self] places in
                guard let self = self else {
                    return
                }
                var items = [HomeSectionItem]()
                for place in places {
                    items.append(
                        HomePlaceItem(place: place)
                    )
                }
                let section = HomeSection(title: "Lugares favoritos", items: items, type: .favoritePlace)
                self.sectionsSubject.onNext([section])
            }
        ).disposed(by: disposeBag)
    }
    
    func emitLoading() {
        var sections = [HomeSection]()
        let items = [
            HomeLoadingItem(),
            HomeLoadingItem(),
            HomeLoadingItem(),
            HomeLoadingItem()
        ]
        let section = HomeSection(title: nil, items: items, type: .favoritePlace)
        sections.append(section)
        for _ in 0..<2 {
            let items = [
                HomeLoadingItem(),
                HomeLoadingItem(),
                HomeLoadingItem(),
                HomeLoadingItem()
            ]
            let section = HomeSection(title: nil, items: items, type: .place)
            sections.append(section)
        }
        sectionsSubject.onNext(sections)
    }
}
