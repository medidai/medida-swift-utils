
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button {
                LoggerService.saveLog("Some text")
                AnalyticService.saveEvent(event: "Some event",
                                          params: [ "key" : "value" ])
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
