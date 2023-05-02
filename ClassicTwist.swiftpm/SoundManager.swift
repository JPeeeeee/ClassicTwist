import AVFoundation

class SoundManager {
    static let backgroundManager = SoundManager()
    private var soundDict: [Sound:AVAudioPlayer?] = [:]
    
    init() {
        for sound in Sound.allCases {
            soundDict[sound] = getAudioPlayer(sound: sound)
        }
    }
    
    private func getAudioPlayer(sound: Sound) -> AVAudioPlayer? {
        guard let url = Bundle.main.url(
            forResource: sound.rawValue,
            withExtension: ".m4a"
        ) else {
            print("Fail to get url for \(sound)")
            return nil
        }

        var audioPlayer: AVAudioPlayer?
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            return audioPlayer
        } catch {
            print("Fail to load \(sound)")
            return nil
        }
    }
    
    func playLoop(sound: Sound) {
        guard let audioPlayer = soundDict[sound, default: nil] else { return }
        audioPlayer.numberOfLoops = -1
        if sound == Sound.backgroundMusic || sound == Sound.falaPlateia {
            audioPlayer.volume = 0.15
        } else {
            audioPlayer.volume = 1
        }
        audioPlayer.play()
    }
    
    func play(sound: Sound) {
        guard let audioPlayer = soundDict[sound, default: nil] else { return }
        if sound == Sound.palmas {
            audioPlayer.volume = 0.15
        } else {
            audioPlayer.volume = 1
        }
        audioPlayer.play()
    }
    
    func pause(sound: Sound) {
        guard let audioPlayer = soundDict[sound, default: nil] else { return }
        audioPlayer.pause()
    }
    
    func stop(sound: Sound) {
        guard let audioPlayer = soundDict[sound, default: nil] else { return }
        audioPlayer.currentTime = 0
        audioPlayer.pause()
    }
    
    enum Sound: String, CaseIterable {
        case bateriaFixed
        case choron1
        case correiaCortina
        case falaPlateia
        case luxMaxima
        case panoCortina
        case prato1
        case prato2
        case tambor
        case palmas
        case backgroundMusic
        case corda1
        case corda2
        case corda3
        case corda4
        case corda5
        case corda6
        case chord
    }
}
