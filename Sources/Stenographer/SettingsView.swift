//
//  SwiftUIView.swift
//  
//
//  Created by linhey on 2021/10/22.
//

import SwiftUI
import Stem

struct SettingsView: View {
    
    class Content: Identifiable, ObservableObject {
        
        let id = UUID()
        
        lazy var name: Binding<String> = .init {
            return self.rawValue
        } set: { name in
            self.rawValue = name
        }
        
        
        var rawValue: String
        
        init(name: String) {
            self.rawValue = name
        }
        
    }
    
    class ViewModel: ObservableObject {
        
        @Published
        var contents: [Content]
        
        init(_ contents: [String]) {
            self.contents = contents.map({ .init(name: $0) })
        }
        
        func remove(content: Content) {
            contents = contents.filter({ result in
                content.id != result.id
            })
        }
        
        func add(name: String) {
            contents.append(.init(name: name))
        }
    }
    
    @ObservedObject
    var vm: ViewModel
    
    @State
    var newText: String = ""
    
    let doneEvent: ([String]) -> Void
    
    init(_ contents: [String], doneEvent: @escaping ([String]) -> Void) {
        self.vm = .init(contents)
        self.doneEvent = doneEvent
    }
    
    var body: some View {
        VStack {
            Form {
                ForEach(self.vm.contents) { content in
                    HStack {
                        TextField("Name", text: content.name)
                        SFSymbol.trashCircle.convert().onTapGesture {
                            vm.remove(content: content)
                        }
                    }
                }
            }
            HStack {
                TextField("new", text: $newText)
                SFSymbol.plusCircle.convert().onTapGesture {
                    guard !newText.isEmpty else {
                        return
                    }
                    vm.add(name: newText)
                    self.newText = ""
                }
            }
            HStack {
                Text("done").onTapGesture {
                    self.doneEvent(([newText] + vm.contents.map(\.rawValue)).filter({ $0.isEmpty == false }))
                }
            }
        }
        .font(.title)
        .frame(minWidth: 400)
        .fixedSize()
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView([], doneEvent: { print($0) })
    }
}
