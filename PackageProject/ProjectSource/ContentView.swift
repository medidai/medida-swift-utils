
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                LoggerService.saveLog("Some text")
            } label: {
                Text("Print log")
            }

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
