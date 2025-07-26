//
//  SwiftUIView.swift
//  Delete Me
//
//  Created by Tim Hagele on 7/25/25.
//

import SwiftUI

fileprivate extension Binding where Value == ContentView8.Category {
  func noFlicker ( option: Binding < ContentView8.Option > ) -> Self {
    Binding ( get: { self.wrappedValue } , set: { nv in
      guard self.wrappedValue != nv else { return }
      DispatchQueue.main.async {
        withAnimation ( nil ) {
          self.wrappedValue = nv
          if let newOption = nv.availableOptions.first {
            option.wrappedValue = newOption
          }
        }
      }
    }
    )
  }
}
//extension Binding where Value == ContentView8.Option {
//  var noFlicker: Self {
//    Binding ( get: { self.wrappedValue } , set: { nv in
//      guard self.wrappedValue != nv else { return }
//      DispatchQueue.main.asyncAfter ( deadline: .now() + 0.1 , execute:  {
//        withAnimation ( nil ) {
//          self.wrappedValue = nv
//        }
//      } )
//    }
//    )
//  }
//}

extension Binding where Value: Hashable {
  var noFlicker: Self {
    Binding ( get: { self.wrappedValue } , set: { nv in
      guard self.wrappedValue != nv else { return }
      DispatchQueue.main.asyncAfter ( deadline: .now() + 0.1 , execute:  {
        withAnimation ( nil ) {
          self.wrappedValue = nv
        }
      } )
    }
    )
  }
}


 struct ContentView8: View {
  enum Category: String, CaseIterable, Identifiable {
    case typeA, typeB, typeC
    var id: Self { self }
    var availableOptions: [Option] {
      switch self {
      case .typeA: return [.a1, .a2]
      case .typeB: return [.b1, .b2]
      case .typeC: return [.c1, .c2]
      }
    }
  }

  enum Option: String, CaseIterable , Identifiable{
    case a1, a2, b1, b2, c1, c2
    var id: Self { self }
  }

  @State private var selectedCategory: Category = .typeA
  @State private var selectedOption: Option = .a1


  var body: some View {
    Form {
      Section(header: Text("Selection")) {
        HStack {
          Picker ( "Hidden", selection: $selectedCategory.noFlicker ( option: self.$selectedOption ) ) {
            ForEach ( Category.allCases ) { category in
              Text ( category.rawValue.capitalized)
            }
          }
          Spacer()
          Picker ( "Hidden" , selection: $selectedOption.noFlicker ) {
            ForEach ( self.selectedCategory.availableOptions ) { option in
              Text ( option.rawValue.uppercased())
            }
          }
        }
        .labelsHidden()
        .pickerStyle(.menu)
      }
    }
  }
}

#Preview {
  ContentView7()
}

