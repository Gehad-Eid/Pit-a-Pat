import SwiftUI
import AVFoundation

struct CircularProgressView: View {
    var progress: CGFloat
    var remainingTime: Int

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5.0)
                .opacity(0.3)
                .foregroundColor(Color.gray)
                .frame(width: 100, height: 100)

            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color("Color3"))
                .rotationEffect(Angle(degrees: -90))
                .animation(.easeInOut)
                .frame(width: 100, height: 100)

            Text(timeFormatted())
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color.white)
        }
    }

    private func timeFormatted() -> String {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


