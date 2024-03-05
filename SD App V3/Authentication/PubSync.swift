//
//  PubSync.swift
//  SD App V3
//
//  Created by Xaria Davis on 3/4/24.
//

import Foundation
import SwiftUI

extension View {
    func syncBool(_ published: Binding<Bool>, with binding: Binding<Bool>) -> some View {
        self
            .onChange(of: published.wrappedValue) { published in
                binding.wrappedValue = published
            }
            .onChange(of: binding.wrappedValue) { binding in
                published.wrappedValue = binding
            }
    }
    
    func syncString(_ published: Binding<String>, with binding: Binding<String>) -> some View {
        self
            .onChange(of: published.wrappedValue) { published in
                binding.wrappedValue = published
            }
            .onChange(of: binding.wrappedValue) { binding in
                published.wrappedValue = binding
            }
    }
}
