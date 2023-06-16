//
//  ContentView.swift
//  textdetector
//
//  Created by Pawan's Mac on 31/03/23.
//
import SwiftUI
import CoreML

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var outputLabel: String = ""
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
   
    
    var body: some View {
        NavigationView{
            Form {
                Text("Enter the sentence you want to Classify").font(.system(size: 25, weight: .bold))
                    TextField("Enter the text", text: $inputText)
                        .padding().font(.system(size: 20))

                Text(outputLabel)
            }
            .navigationTitle("")
            .toolbar{
                Button("Classify", action: classifyText)
            }
            .alert(alertTitle, isPresented: $showingAlert){
                Button("OK"){}
            }message: {
                Text(alertMessage)
            }
        }
       
       
    }
    
    func classifyText() {
        guard let model = try? MyTextClassifier_1(configuration: .init()) else {
            fatalError("Failed to load model")
        }
        
        let input = MyTextClassifier_1Input(text: inputText)
        
        guard let output = try? model.prediction(input: input) else {
            fatalError("Model prediction failed")
        }
        
        outputLabel = output.label
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
