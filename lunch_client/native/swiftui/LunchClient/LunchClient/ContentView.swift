import SwiftUI
import LiveViewNative
import LiveViewNativeLiveForm

struct MyRegistry: CustomRegistry {
    typealias Root = AppRegistries
}

struct AppRegistries: AggregateRegistry {
    typealias Registries = Registry2<
        MyRegistry,
        LiveFormRegistry<Self>
    >
}

struct ContentView: View {
    @StateObject private var coordinator = LiveSessionCoordinator<AppRegistries>(
        {
            let prodURL = Bundle.main.object(forInfoDictionaryKey: "Phoenix Production URL") as? String

            #if DEBUG
            return URL(string: "https://80ec-46-59-110-96.ngrok-free.app")!
            #else
            return URL(string: URL || "https://example.com")!
            #endif
        }(),
        config: LiveSessionConfiguration()
    )
    
    var body: some View {
        LiveView(session: coordinator)
    }
}
