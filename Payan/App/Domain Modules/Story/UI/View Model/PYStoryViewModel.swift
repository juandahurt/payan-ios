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
    @Published var isPaused = false
    @Published var currentPercentage = 0.0
    
    var storyFinshed = PassthroughSubject<Void, Never>()
    
    let timerInterval = 0.2
    
    var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
    
    private var cancellables = Set<AnyCancellable>()
    
    private let interactor: PYStoryBusinessLogic
    
    init(interactor: PYStoryBusinessLogic, chapters: [PYStoryChapter]) {
        self.interactor = interactor
        self.chapters = chapters
        currentIndex = 0
    }
    
    var currentChapter: PYStoryChapter {
        chapters[currentIndex]
    }
    
    private func starTimer() {
        timer = Timer.publish(every: timerInterval, on: .main, in: .default).autoconnect()
    }
    
    private func resetTimer() {
        timer?.upstream.connect().cancel()
        starTimer()
    }
    
    func timerFired() {
        let aux = currentPercentage + 0.05
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
        resetTimer()
    }
    
    func back() {
        currentPercentage = 0
        interactor.back(currentIndex: &currentIndex, numberOfChapters: chapters.count)
    }
}
