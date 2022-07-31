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
    @Published var currentPercentage = 0.0
    
    var storyFinshed = PassthroughSubject<Void, Never>()
    
    let timerInterval = 0.4
    
    var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
    
    private var cancellables = Set<AnyCancellable>()
    
    private let interactor: PYStoryBusinessLogic
    
    init(interactor: PYStoryBusinessLogic) {
        self.interactor = interactor
        currentIndex = 0
    }
    
    var currentChapter: PYStoryChapter {
        chapters[currentIndex]
    }
    
    private func starTimer() {
        timer = Timer.publish(every: timerInterval, on: .main, in: .default).autoconnect()
    }
    
    func timerFired() {
        let aux = currentPercentage + 0.1
        currentPercentage = min(1, aux)
        if currentPercentage == 1 {
            next()
        }
    }
    
    func pause() {
        guard !isPaused else { return }
        timer?.upstream.connect().cancel()
        isPaused = true
    }
    
    func resume() {
        timer = Timer.publish(every: timerInterval, on: .main, in: .default).autoconnect()
        isPaused = false
    }
    
    func next() {
        guard currentIndex < chapters.count - 1 else {
            storyFinshed.send()
            return
        }
        currentPercentage = 0
        interactor.next(currentIndex: &currentIndex, numberOfChapters: chapters.count)
    }
    
    func back() {
        currentPercentage = 0
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
                self.starTimer()
            }
            .store(in: &cancellables)
    }
}
