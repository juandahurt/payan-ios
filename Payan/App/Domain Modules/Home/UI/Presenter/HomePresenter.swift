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
    func showPlace(_ place: Place)
}

final class HomePresenter: BasePresenter {
    // MARK: - Attributes
    var router: HomeRouter
    var interactor: AnyHomeInteractor
    private var disposeBag = DisposeBag()
    internal var selectedPlace: Place?
    
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
    func showPlace(_ place: Place) {
        selectedPlace = place
        router.showPlaceModule(dataSource: self)
    }
    
    func getData() {
        emitLoading()
        
        let favPlacesObservable = interactor.listFavoritePlaces().asObservable()
        let catPlacesObservable = interactor.listPlacesByCategory().asObservable()
        
        Observable.zip(favPlacesObservable, catPlacesObservable)
            .subscribe(onNext: { [weak self] favPlaces, groupOfPlaces in
                guard let self = self else {
                    return
                }
                
                var sections = [HomeSection]()
                var favItems = [HomeSectionItem]()
                
                for place in favPlaces {
                    favItems.append(
                        HomePlaceItem(place: place)
                    )
                }
                let favoritesSection = HomeSection(title: "Los más populares", items: favItems, type: .favoritePlace)
                sections.append(favoritesSection)
                
                for group in groupOfPlaces {
                    if !group.places.isEmpty {
                        var items = [HomeSectionItem]()
                        for place in group.places {
                            items.append(
                                HomePlaceItem(place: place)
                            )
                        }
                        let title: String
                        switch group.category {
                        case .museum:
                            title = "Museos"
                        case .park:
                            title = "Parques"
                        case .bridge:
                            title = "Puentes"
                        case .church:
                            title = "Iglesias"
                        }
                        let section = HomeSection(title: title, items: items, type: .place)
                        sections.append(section)
                    }
                }
                
                self.sectionsSubject.onNext(sections)
            }).disposed(by: disposeBag)
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

// MARK: - Place Module Data Source
extension HomePresenter: PlaceModuleDataSource {
    func providePlace() -> Place {
        selectedPlace!
    }
}
