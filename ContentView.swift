import SwiftUI

struct ContentView: View {
    @State private var timeRemaining = 25 * 60
    @State private var isRunning = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            Text("Focus")
                .font(.headline)
                .foregroundColor(.green)
            
            Text(timeString(time: timeRemaining))
                .font(.system(size: 40, weight: .bold, design: .monospaced))
                .foregroundColor(.cyan)
                .onReceive(timer) { _ in
                    if isRunning && timeRemaining > 0 {
                        timeRemaining -= 1
                    } else if timeRemaining == 0 {
                        isRunning = false
                    }
                }
            
            Button(action: {
                isRunning.toggle()
            }) {
                Text(isRunning ? "Pause" : "Start")
            }
            .tint(isRunning ? .red : .green)
        }
    }
    
    func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
