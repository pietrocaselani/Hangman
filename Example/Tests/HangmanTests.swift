//
//  HangmanTests.swift
//  Hangman
//
//  Created by Pietro Caselani on 05/05/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest

@testable import Hangman

class HangmanTests: XCTestCase {
    
	func testCreateHangman() throws {
		let hangman = Hangman(word: "Swift", attempts: 3)
		
		XCTAssertNotNil(hangman, "Could not create a Hangman with word 'Swift' and 3 attempts")
	}
	
	func testRetriveOriginalWord() throws {
		let hangman = Hangman(word: "Swift", attempts: 3)
		
		XCTAssert(hangman.word == "Swift", "Original word isn't 'Swift'")
		XCTAssert(hangman.attempts == 3, "Attempts isn't 3")
	}
	
	func testAttemptLetter() throws {
		let hangman = Hangman(word: "Swift", attempts: 3)
		
		let result = hangman.attempt(letter: "f")
		
		XCTAssertNotNil(result, "Attempt letter can't return nil")
		
		XCTAssertTrue(result.valid, "'Swift' contains letter 'f'")
		
		XCTAssert(result.tried == "f", "Attempt letter should be 'f'")
		
		XCTAssert(result.attemptsRemaining == 2, "Attempts remaining should be 2")
		
		XCTAssertFalse(result.win, "Should not win")
	}
	
	func testAttemptLetterAndWin() throws {
		let hangman = Hangman(word: "ft", attempts: 3)
		
		var result = hangman.attempt(letter: "t")
		
		XCTAssertNotNil(result, "Attempt letter can't return nil")
		
		XCTAssertTrue(result.valid, "'ft' contains letter 't'")
		
		XCTAssert(result.tried == "t", "Attempt letter should be 't'")
		
		XCTAssert(result.attemptsRemaining == 2, "Attempts remaining should be 2")
		
		XCTAssertFalse(result.win, "Should not win")
		
		result = hangman.attempt(letter: "f")
		
		XCTAssertNotNil(result, "Attempt letter can't return nil")
		
		XCTAssertTrue(result.valid, "'ft' contains letter 'f'")
		
		XCTAssert(result.tried == "f", "Attempt letter should be 'f'")
		
		XCTAssert(result.attemptsRemaining == 1, "Attempts remaining should be 1")
		
		XCTAssertTrue(result.win, "Should win")
		
		XCTAssertFalse(result.lostGame, "Should not lost the game")
	}
	
	func testAttemptLetterWithDuplicatesAndWin() throws {
		let hangman = Hangman(word: "aaftt", attempts: 4)
		
		var result = hangman.attempt(letter: "a")
		
		XCTAssertTrue(result.valid, "'aaftt' contains letter 'a'")
		
		XCTAssert(result.tried == "a", "Attempt letter should be 'a'")
		
		XCTAssert(result.attemptsRemaining == 3, "Attempts remaining should be 3")
		
		XCTAssert(result.hits == 2, "'aaaftt' contains two 'a'")
		
		XCTAssertFalse(result.win, "Should not win")
		
		result = hangman.attempt(letter: "f")
		
		XCTAssertTrue(result.valid, "'aaftt' contains letter 'f'")
		
		XCTAssert(result.tried == "f", "Attempt letter should be 'f'")
		
		XCTAssert(result.attemptsRemaining == 2, "Attempts remaining should be 2")
		
		XCTAssert(result.hits == 1, "'aaaftt' contains two 'f'")
		
		XCTAssertFalse(result.win, "Should not win")
		
		result = hangman.attempt(letter: "t")
		
		XCTAssertTrue(result.valid, "'aaftt' contains letter 't'")
		
		XCTAssert(result.tried == "t", "Attempt letter should be 't'")
		
		XCTAssert(result.attemptsRemaining == 1, "Attempts remaining should be 1")
		
		XCTAssert(result.hits == 2, "'aaaftt' contains two 't'")
		
		XCTAssertTrue(result.win, "Should win")
		
		XCTAssertFalse(result.lostGame, "Should not lost the game")
	}
	
	func testAttemptLettersAndLost() {
		let hangman = Hangman(word: "swift", attempts: 2)
		
		var result = hangman.attempt(letter: "a")
		
		XCTAssertFalse(result.valid, "'swift' doesn't contains letter 'a'")
		
		XCTAssert(result.tried == "a", "Attempt letter should be 'a'")
		
		XCTAssert(result.attemptsRemaining == 1, "Attempts remaining should be 1")
		
		XCTAssert(result.hits == 0, "'swift' doesn't contains two 'a'")
		
		XCTAssertFalse(result.win, "Should not win")
		
		result = hangman.attempt(letter: "b")
		
		XCTAssertFalse(result.valid, "'swift' doesn't contains letter 'b'")
		
		XCTAssert(result.tried == "b", "Attempt letter should be 'b'")
		
		XCTAssert(result.attemptsRemaining == 0, "Attempts remaining should be 0")
		
		XCTAssert(result.hits == 0, "'swift' doesn't contains two 'b'")
		
		XCTAssertFalse(result.win, "Should not win")
		
		XCTAssertTrue(result.lostGame, "Should lost the game")
	}
	
	func testAttemptsWithSameCountOfWord() throws {
		let hangman = Hangman(word: "ft", attempts: 2)
		
		var result = hangman.attempt(letter: "t")
		
		XCTAssertNotNil(result, "Attempt letter can't return nil")
		
		XCTAssertTrue(result.valid, "'ft' contains letter 't'")
		
		XCTAssert(result.tried == "t", "Attempt letter should be 't'")
		
		XCTAssert(result.attemptsRemaining == 1, "Attempts remaining should be 1")
		
		XCTAssertFalse(result.win, "Should not win")
		
		result = hangman.attempt(letter: "f")
		
		XCTAssertNotNil(result, "Attempt letter can't return nil")
		
		XCTAssertTrue(result.valid, "'ft' contains letter 'f'")
		
		XCTAssert(result.tried == "f", "Attempt letter should be 'f'")
		
		XCTAssert(result.attemptsRemaining == 0, "Attempts remaining should be 0")
		
		XCTAssertTrue(result.win, "Should win")
		
		XCTAssertFalse(result.lostGame, "Should not lost the game")
	}
	
	func testAttemptsCaseInsesitive() throws {
		let hangman = Hangman(word: "ftf", attempts: 3)
		
		var result = hangman.attempt(letter: "F")
		
		XCTAssertTrue(result.valid, "'ft' contains letter 'F'")
		
		XCTAssert(result.tried == "F", "Attempt letter should be 'F'")
		
		XCTAssert(result.attemptsRemaining == 2, "Attempts remaining should be 2")
		
		XCTAssertFalse(result.win, "Should not win")
		
		result = hangman.attempt(letter: "t")
		
		XCTAssertNotNil(result, "Attempt letter can't return nil")
		
		XCTAssertTrue(result.valid, "'ft' contains letter 't'")
		
		XCTAssert(result.tried == "t", "Attempt letter should be 't'")
		
		XCTAssert(result.attemptsRemaining == 1, "Attempts remaining should be 1")
		
		XCTAssertTrue(result.win, "Should win")
	}
	
	func testAttemptWordAndLost() throws {
		let hangman = Hangman(word: "swift", attempts: 3)
	
		let result = hangman.attempt(word: "javac")
		
		XCTAssertFalse(result.valid, "'swift' isn't 'javac'")
		
		XCTAssert(result.tried == "javac", "Attempt word should be 'javac'")
		
		XCTAssert(result.attemptsRemaining == 0, "Attempts remaining should be 0")
		
		XCTAssertFalse(result.win, "Should not win")
		
		XCTAssertTrue(result.lostGame, "Should lost the game")
	}
	
	func testAttemptWordAndWind() throws {
		let hangman = Hangman(word: "Kotlin", attempts: 3)
		
		let result = hangman.attempt(word: "kotlin")
		
		XCTAssertTrue(result.valid, "The word is 'Koltin'")
		
		XCTAssert(result.tried == "kotlin", "Attempt word should be 'kotlin'")
		
		XCTAssert(result.attemptsRemaining == 0, "Attempts remaining should be 0")
		
		XCTAssertTrue(result.win, "Should win")
		
		XCTAssertFalse(result.lostGame, "Should not lost the game")
	}
}
