//
//  ContentView.swift
//  PromoCodeDemo
//
//  Created by Apple on 18/10/2023.
//

import SwiftUI

enum AhmedViews {
    case profileV(firstImage: String, text: String, lastImage: String)
    case profileH(firstImage: String, text: String, lastImage: String)
    case simpleView(text: String)
    case extremelySimpleView
}
//
protocol ViewFactoryProtocol {
    func makeView(view: AhmedViews) -> any View
}

struct AhmedViewFactory: ViewFactoryProtocol {
    func makeView(view: AhmedViews) -> any View {
        switch view {
        case .profileV(let firstImage, let text, let lastImage):
            return VProfileView(firstImage: firstImage, text: text, lastImage: lastImage)
        case .profileH(let firstImage, let text, let lastImage):
            return HProfileView(firstImage: firstImage, text: text, lastImage: lastImage)
        case .simpleView(text: let text):
            return Text(text)
        case .extremelySimpleView:
            return Text("Welcome V1")
        }
    }
}

struct AhmedViewV2Factory: ViewFactoryProtocol {
    func makeView(view: AhmedViews) -> any View {
        switch view {
        case .profileV(let firstImage, let text, let lastImage):
            return VProfileView_V2(firstImage: firstImage, text: text, lastImage: lastImage)
        case .profileH(let firstImage, let text, let lastImage):
            return HProfileView_V2(firstImage: firstImage, text: text, lastImage: lastImage)
        case .simpleView(text: let text):
            return Text(text)
        case .extremelySimpleView:
            return Text("Welcome V2")
        }
    }
}


// Loosly coupled ContentView & Factory
struct ContentView: View {
    let factory: ViewFactoryProtocol
    var body: some View {
        VStack {
            AnyView(
                factory.makeView(view: .simpleView(text: "Hello"))
            )
            AnyView(
                factory.makeView(view: .extremelySimpleView)
            )
            AnyView(
                factory.makeView(view: .profileV(firstImage: "globe", text: "Vertical", lastImage: "globe"))
            )
            AnyView(
                factory.makeView(view: .profileV(firstImage: "globe", text: "Vertical", lastImage: "globe"))
            )
            AnyView(
                factory.makeView(view: .profileH(firstImage: "globe", text: "Horizontal", lastImage: "globe"))
            )
        }
        .padding()
    }
}

struct VProfileView: View {
    let firstImage: String
    let text: String
    let lastImage: String
    var body: some View {
        VStack {
            Image(systemName: firstImage)
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(text)
                .foregroundColor(.orange)
                .font(.title3.bold())
            Image(systemName: lastImage)
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
        }
        .padding()
    }
}
struct HProfileView: View {
    let firstImage: String
    let text: String
    let lastImage: String
    var body: some View {
        HStack {
            Image(systemName: firstImage)
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(text)
                .foregroundColor(.orange)
                .font(.title3.bold())
            Image(systemName: lastImage)
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
        }
        .padding()
    }
}
struct VProfileView_V2: View {
    let firstImage: String
    let text: String
    let lastImage: String
    var body: some View {
        VStack {
            Form {
                Section {
                    Image(systemName: firstImage)
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                        .padding()
                }
                Section {
                    Text(text)
                        .foregroundColor(.red)
                        .font(.title.bold())
                        .padding()
                }
                Section {
                    Image(systemName: lastImage)
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                            .padding()
                }
            }
        }
        .padding()
    }
}
struct HProfileView_V2: View {
    let firstImage: String
    let text: String
    let lastImage: String
    var body: some View {
        HStack {
            Image(systemName: firstImage)
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(text)
                .foregroundColor(.red)
                .font(.title.bold())
            Image(systemName: lastImage)
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(factory: AhmedViewFactory())
    }
}
