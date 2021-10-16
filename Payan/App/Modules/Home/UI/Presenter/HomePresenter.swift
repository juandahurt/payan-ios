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
    var router: BaseRouter
    
    // MARK: - Subjects
    var sectionsSubject = BehaviorSubject<[HomeSection]>(value: [])
    
    init(router: HomeRouter) {
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
