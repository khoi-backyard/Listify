import AVFoundation

open class SoundService {
    open class Sound {
        open var soundId: SystemSoundID
        open fileprivate(set) var usingCount: Int = 1

        init(soundId: SystemSoundID) {
            self.soundId = soundId
        }
    }

    fileprivate let defaultExtension = "wav"

    open static let shared = SoundService()

    open fileprivate(set) var sounds = [String:Sound]()

    @discardableResult
    open func prepareSound(fileName: String) -> String? {
        let fixedSoundFileName = self.fixedSoundFileName(fileName: fileName)
        if let sound = soundForKey(fixedSoundFileName) {
            sound.usingCount += 1
            return fixedSoundFileName
        }

        if let pathURL = pathURLForSound(fileName: fixedSoundFileName) {
            var soundID: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(pathURL as CFURL, &soundID)
            let sound = Sound(soundId: soundID)
            sounds[fixedSoundFileName] = sound
            return fixedSoundFileName
        }

        return nil
    }

    open func playSound(fileName: String) {
        let fixedSoundFileName = self.fixedSoundFileName(fileName: fileName)
        if let sound = soundForKey(fixedSoundFileName) {
            AudioServicesPlaySystemSound(sound.soundId)
        }
    }

    open func removeSound(fileName: String) {
        let fixedSoundFileName = self.fixedSoundFileName(fileName: fileName)
        if let sound = soundForKey(fixedSoundFileName) {
            sound.usingCount -= 1
            if sound.usingCount <= 0 {
                AudioServicesDisposeSystemSoundID(sound.soundId)
                sounds.removeValue(forKey: fixedSoundFileName)
            }
        }
    }

    fileprivate func soundForKey(_ key: String) -> Sound? {
        return sounds[key]
    }

    fileprivate func fixedSoundFileName(fileName: String) -> String {

        var fixedSoundFileName = fileName.trimmingCharacters(in: .whitespacesAndNewlines)
        var soundFileComponents = fixedSoundFileName.components(separatedBy: ".")
        if soundFileComponents.count == 1 {
            fixedSoundFileName = "\(soundFileComponents[0]).\(defaultExtension)"
        }
        return fixedSoundFileName
    }

    fileprivate func pathForSound(fileName: String) -> String? {
        let fixedSoundFileName = self.fixedSoundFileName(fileName: fileName)
        let components = fixedSoundFileName.components(separatedBy: ".")
        return Bundle.main.path(forResource: components[0], ofType: components[1])
    }

    fileprivate func pathURLForSound(fileName: String) -> URL? {
        if let path = pathForSound(fileName: fileName) {
            return URL(fileURLWithPath: path)
        }
        return nil
    }
}
