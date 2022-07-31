//
//  PYStoryViewModel.swift
//  Payan
//
//  Created by Juan Hurtado on 12/07/22.
//

import Combine
import Foundation

class PYStoryViewModel: ObservableObject {
    @Published var chapters: [PYStoryChapter] = [.empty]
    @Published var currentIndex: Int
    @Published var isLoading = true
    @Published var errorHasOccurred = false
    @Published var isPaused = false
    
    private var cancellables = Set<AnyCancellable>()
    
    private let interactor: PYStoryBusinessLogic
    
    init(interactor: PYStoryBusinessLogic) {
        self.interactor = interactor
        currentIndex = 0
    }
    
    var currentChapter: PYStoryChapter {
        chapters[currentIndex]
    }
    
    func pause() {
        guard !isPaused else { return }
        isPaused = true
    }
    
    func resume() {
        isPaused = false
    }
    
    func next() {
        guard !isPaused else { return }
        interactor.next(currentIndex: &currentIndex, numberOfChapters: chapters.count)
    }
    
    func back() {
        guard !isPaused else { return }
        interactor.back(currentIndex: &currentIndex, numberOfChapters: chapters.count)
    }
    
    func getData(id: String) {
        isLoading = true
        interactor.getStory(identifiedBy: id)
            .receive(on: RunLoop.main)
            .catch { [weak self] _ -> Empty<PYStoryData, Never> in
                let empty = Empty<PYStoryData, Never>()
                guard let self = self else { return empty }
                self.isLoading = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.errorHasOccurred = true
                }
                return empty
            }
            .sink { [weak self] data in
                guard let self = self else { return }
                self.chapters = data.chapters
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
}
