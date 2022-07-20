//
//  PYStoryBusinessLogic.swift
//  Payan
//
//  Created by Juan Hurtado on 20/07/22.
//

import Combine

protocol PYStoryBusinessLogic {
    /// Moves to the next chapter.
    ///
    /// If its possible, it will update the current index value.
    /// - Parameters:
    ///     - currentIndex: The current chapter index.
    ///     - numberOfChapters: The total number of chapters.
    func next(currentIndex: inout Int, numberOfChapters: Int)
    
    /// Moves to the previous chapter.
    ///
    /// If its possible, it will update the current index value.
    /// - Parameters:
    ///     - currentIndex: The current chapter index.
    ///     - numberOfChapters: The total number of chapters.
    func back(currentIndex: inout Int, numberOfChapters: Int)
    
    /// Gets the sotry chapters.
    /// - Parameters:
    ///     - id: Story identifier.
    /// - Returns: A publisher that will eventually publish the required chapters.
    func getStory(identifiedBy id: String) -> AnyPublisher<[PYStoryChapter], Error>
}
