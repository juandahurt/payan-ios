//
//  PYStoryViewModel.swift
//  Payan
//
//  Created by Juan Hurtado on 12/07/22.
//

import Combine
import Foundation

class PYStoryViewModel: ObservableObject {
    @Published var chapters: [PYStoryChapter]
    @Published var currentIndex: Int
    
    private var cancellables = Set<AnyCancellable>()
    
    private let interactor: PYStoryBusinessLogic
    
    init(interactor: PYStoryBusinessLogic) {
        self.interactor = interactor
        let media = PYStoryMedia(type: .image, link: "https://live.staticflickr.com/4107/5055403619_7ffd3889c4_b.jpg")
        chapters = [
            .init(title: "El terremoto de 1983", content: "El terremoto tuvo una magnitud de 5,5 (calculada con ondas de cuerpo) e intensidad VIII grados en la escala de Mercalli con un epicentro al sudoeste de Popayán y una profundidad de 12 a 15 kilómetros.", media: media),
            .init(content: "El terremoto tuvo una magnitud de 5,5 (calculada con ondas de cuerpo) e intensidad VIII grados en la escala de Mercalli con un epicentro al sudoeste de Popayán y una profundidad de 12 a 15 kilómetros.", media: media),
            .init(title: "El terremoto de 1983", content: "El terremoto tuvo una magnitud de 5,5 (calculada con ondas de cuerpo) e intensidad VIII grados en la escala de Mercalli con un epicentro al sudoeste de Popayán y una profundidad de 12 a 15 kilómetros.", media: media),
            .init(title: "El terremoto de 1983", content: "El", media: media),
            .init(media: media)
        ]
        currentIndex = 0
    }
    
    var currentChapter: PYStoryChapter {
        chapters[currentIndex]
    }
    
    func next() {
        interactor.next(currentIndex: &currentIndex, numberOfChapters: chapters.count)
    }
    
    func back() {
        interactor.back(currentIndex: &currentIndex, numberOfChapters: chapters.count)
    }
    
    func getData(id: String) {
        interactor.getStory(identifiedBy: id)
            .catch { _ in Empty<[PYStoryChapter], Never>() }
            .receive(on: RunLoop.main)
            .sink { chapters in
                print(chapters)
            }
            .store(in: &cancellables)
    }
}
