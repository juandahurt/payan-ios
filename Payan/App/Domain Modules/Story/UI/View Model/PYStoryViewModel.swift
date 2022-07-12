//
//  PYStoryViewModel.swift
//  Payan
//
//  Created by Juan Hurtado on 12/07/22.
//

import Foundation

class PYStoryViewModel: ObservableObject {
    @Published var chapters: [PYStoryChapter]
    @Published var currentIndex: Int
    
    init() {
        chapters = [
            .init(title: "El terremoto de 1983", content: "El terremoto tuvo una magnitud de 5,5 (calculada con ondas de cuerpo) e intensidad VIII grados en la escala de Mercalli con un epicentro al sudoeste de Popayán y una profundidad de 12 a 15 kilómetros.", media: "https://cdn.colombia.com/sdi/2019/03/31/a-36-anos-del-terremoto-de-popayan-723989.jpg"),
            .init(title: "El terremoto de 1983", content: "El terremoto tuvo una magnitud de 5,5 (calculada con ondas de cuerpo) e intensidad VIII grados en la escala de Mercalli con un epicentro al sudoeste de Popayán y una profundidad de 12 a 15 kilómetros.", media: "https://live.staticflickr.com/4107/5055403619_7ffd3889c4_b.jpg"),
            .init(title: "El terremoto de 1983", content: "El terremoto tuvo una magnitud de 5,5 (calculada con ondas de cuerpo) e intensidad VIII grados en la escala de Mercalli con un epicentro al sudoeste de Popayán y una profundidad de 12 a 15 kilómetros.", media: "https://pbs.twimg.com/media/EUcUhSzX0AAIC_E?format=jpg&name=900x900")
        ]
        currentIndex = 0
    }
    
    var currentChapter: PYStoryChapter {
        chapters[currentIndex]
    }
    
    func next() {
        guard currentIndex < chapters.count - 1 else { return }
        currentIndex += 1
    }
    
    func back() {
        guard currentIndex > 0 else { return }
        currentIndex -= 1
    }
}
