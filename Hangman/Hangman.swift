//
//  Hangman.swift
//  Pods
//
//  Created by Pietro Caselani on 05/05/17.
//
//

public final class Hangman {
	
	public let word: String
	public let attempts: Int
	public var lost = false
	private var attemptsRemaining: Int
	private var attemptedLetters = [Character]()
	
	public init(word: String, attempts: Int) {
		self.word = word
		self.attempts = attempts
		self.attemptsRemaining = attempts
		
		word.characters.forEach {_ in 
			attemptedLetters.append("_")
		}
	}
	
	public func attempt(letter: Character) -> AttemptResult {
		attemptsRemaining -= 1
		
		var hits = 0
		
		word.characters.enumerated().forEach { index, c in
			if c == letter {
				hits += 1
				attemptedLetters[index] = c
			}
		}
		
		let win = attemptedLetters.elementsEqual(word.characters)
		
		lost = attemptsRemaining == 0 && !win
		
		return AttemptResult(hits: hits, win: win, tried: String(letter), attemptsRemaining: attemptsRemaining)
	}
	
}

public struct AttemptResult {
	
	public let valid: Bool
	public let win: Bool
	public let tried: String
	public let attemptsRemaining: Int
	public let hits: Int
	
	internal init(hits: Int, win: Bool, tried: String, attemptsRemaining: Int) {
		self.valid = hits > 0
		self.hits = hits
		self.win = win
		self.tried = tried
		self.attemptsRemaining = attemptsRemaining
	}
	
}
