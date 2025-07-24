//
//  ContentView.swift
//  Delete Me
//
//  Created by Tim Hagele on 7/23/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
//	DemoView()
		ContentView2()
}



struct ContentView2: View {

 @State private var selectedCategory: Category = .typeAAAAA
 @State private var selectedOption: Option = .a11111

 var body: some View {
	Form {
	 Section ( header: Text ( "Selection" ) ) {
		HStack {
		 ForEach ( Category.allCases , id: \.self ) { category in
			if self.selectedCategory == category {
			 Picker ( "Hidden" , selection: self.$selectedCategory ) {
				ForEach ( Category.allCases , id: \.self ) { category in
				 Text ( category.rawValue.capitalized )
				}
			 }
			 Spacer()
			 ForEach ( Option.allCases , id: \.self ) { option in
				if self.selectedOption == option {
				 Picker ( "Hidden" , selection: self.$selectedOption ) {
					 ForEach ( self.selectedCategory.availableOptions , id: \.self ) { option in
					 Text ( option.rawValue.uppercased() )
					}
				 }
				}
			 }
			}
		 }
		}
		.labelsHidden()
		.pickerStyle ( .menu )
		.onChange ( of: self.selectedCategory ) { _ , new in
		 if let option = new.availableOptions.first {
			self.selectedOption = option
		 }
		}
	 }
	}
 }
	enum Category: String , CaseIterable , Hashable {
	 case typeAAAAA , typeBBBBB , typeCCCCC

	 var availableOptions: [ Option ] {
		switch self {
		case .typeAAAAA : return [ .a11111 , .a22222 ]
		case .typeBBBBB : return [ .b11111 , .b22222 ]
		case .typeCCCCC : return [ .c11111 , .c22222 ]
		}
	 }
	}
	enum Option: String , CaseIterable , Hashable  {
	 case a11111 , a22222 , b11111 , b22222 , c11111 , c22222
	}
}

//struct DemoView : View {
//	@StateObject var container = Container.sync
//	var body: some View {
//		ContentView2 ( )
//	}
//}
