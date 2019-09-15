//
// Created by Adam Haafiz on 15/09/2019.
// Copyright (c) 2019 Adam Haafiz. All rights reserved.
//

import AVFoundation

enum Sounds {
    case cardOpened, cardDismissed, gameStarted, gameEnded

    var soundFile: URL {
        switch self {

        case .cardOpened:
            return R.file.flipWav()!
        case .cardDismissed:
            return R.file.whooshWav()!
        case .gameStarted:
            return R.file.kingWav()!
        case .gameEnded:
            return R.file.game_overWav()!
        }
    }
}

extension AVAudioPlayer {
    convenience init?(sound: Sounds) {
        do {
            try self.init(contentsOf: sound.soundFile)
        } catch {
            debugPrint(error)
            return nil
        }
    }
}

struct SoundEngine {
    lazy var flipSoundEngine: AVAudioPlayer? = {
        AVAudioPlayer(sound: .cardOpened)
    }()
    lazy var whooshSoundEngine: AVAudioPlayer? = {
        AVAudioPlayer(sound: .cardDismissed)
    }()
    lazy var gameOverSoundEngine: AVAudioPlayer? = {
        AVAudioPlayer(sound: .gameEnded)
    }()
    lazy var kingSoundEngine: AVAudioPlayer? = {
        AVAudioPlayer(sound: .gameStarted)
    }()

    mutating func play(sound: Sounds) {
        switch sound {

        case .cardOpened:
            flipSoundEngine?.play()
        case .cardDismissed:
            whooshSoundEngine?.play()
        case .gameStarted:
            kingSoundEngine?.play()
        case .gameEnded:
            gameOverSoundEngine?.play()
        }
    }
}