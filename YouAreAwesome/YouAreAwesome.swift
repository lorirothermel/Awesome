//
//  YouAreAwesome.swift
//  YouAreAwesome
//
//  Created by Lori Rothermel on 5/21/23.
//

import SwiftUI
import AVFAudio


struct YouAreAwesome: View {
    
    @State private var messageString = ""
    @State private var imageName = ""
    @State private var lastMessageNumber: Int = -1
    @State private var lastImageNumber: Int = -1
    @State private var lastSoundNumber: Int = -1
    @State private var soundName = ""
    @State private var audioPlayer: AVAudioPlayer!
    @State private var toggleSound: Bool = true
    
    
    
    let messages = ["You Are Great!",
                    "You Are Wonderful!",
                    "Fabulous? That Is You!",
                    "You Are The Best Coder Around.",
                    "Life Is A Barrel of Laughs",
                    "Hey You Are In Pittsburgh",
                    "There Is Always Tomorrow" ]
        
    
    
    var body: some View {
        
        VStack {
            
            Text(messageString)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.pink)
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .padding()
            
            Image(imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(30)
                .shadow(radius: 10)
                .padding()
            
            Spacer()
            
            HStack {
                Text(toggleSound ? "Sound On" : "Sound Off")
                    .foregroundColor(toggleSound ? .green : .blue)
                Toggle("", isOn: $toggleSound)
                    .labelsHidden()
                    .onChange(of: toggleSound) { _ in
                        if audioPlayer != nil && audioPlayer.isPlaying {
                            audioPlayer.stop()
                        }  // if
                    }  // .onChange
                
                Spacer()
                
                Button("Show Message") {
                    // Messages
                    
                    lastMessageNumber = nonRepeatingRandom(lastNumber: lastMessageNumber, upperBound: messages.count-1)
                    messageString = messages[lastMessageNumber]
                    
                    // Images
                    
                    lastImageNumber = nonRepeatingRandom(lastNumber: lastImageNumber, upperBound: 9)
                    imageName = "image\(lastImageNumber)"
                    
                    // Sound
                    
                    lastSoundNumber = nonRepeatingRandom(lastNumber: lastSoundNumber, upperBound: 5)
                    soundName = "sound\(lastSoundNumber)"
                    
                    if toggleSound {
                        playSound(soundName: soundName)
                    }  // if
                      
                    
                }  // Button
                .buttonStyle(.borderedProminent)
                
            }  // HStack
            
            
        }  // VStack
        .padding()
        
        
    }  // some View
    
    func nonRepeatingRandom(lastNumber: Int, upperBound: Int) -> Int {
        var newNumber: Int
        
        repeat {
            newNumber = Int.random(in: 0...upperBound)
        } while newNumber == lastNumber
                       
        return newNumber
    }  // nonRepeatingRandom
    
    
    func playSound(soundName: String) {
        
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("❗️ Could not read file named \(soundName)")
            return
        }  // guard let
        
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("❗️ ERROR: \(error.localizedDescription)")
        }  // do...catch
        
    }  // playSound
    
    
}  // YouAreAwesome

struct YouAreAwesome_Previews: PreviewProvider {
    static var previews: some View {
        YouAreAwesome()
    }
}
