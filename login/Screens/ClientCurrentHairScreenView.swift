//
//  CurrentHairScreenView.swift
//  UMI
//
//  Created by Sebastian Oberg on 3/30/24.
//


import SwiftUI

struct ClientCurrentHairScreenView: View {
    @State private var images: [UIImage?] = [nil, nil, nil, nil]
    @State private var showingImagePicker = false
    @State private var showingAlert = false
    @State private var activeImageIndex = 0
    @State private var navigateToHairInspoScreen = false

    var body: some View {
        NavigationView {
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("UMI")
                        .font(.custom("Sarina-Regular", size: 35))
                        .foregroundColor(Color("PrimaryColor"))
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("My Hair Looks Like...")
                                .font(.custom("Sansita-BoldItalic", size: 50))
                                .foregroundColor(Color("TitleTextColor"))
                                .padding(.bottom, 20)
                            
                            Text("Please upload 4 images:")
                                .font(.custom("Poppins-SemiBoldItalic", size: 20))
                                .padding(.bottom, 10)
                        }

                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            ForEach(0..<images.count, id: \.self) { index in
                                ZStack(alignment: .topTrailing) {
                                    if let image = images[index] {
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 150, height: 150)
                                            .clipped()
                                            .cornerRadius(15)
                                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 10)
                                            .onTapGesture {
                                                activeImageIndex = index
                                                showingImagePicker = true
                                            }

                                        Button(action: {
                                            deleteImage(at: index)
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(Color.white)
                                                .padding(5)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .padding([.top, .trailing], 10)
                                    } else {
                                        Image(systemName: "camera")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(Color.gray)
                                            .padding()
                                            .background(Color.white)
                                            .cornerRadius(15)
                                            .onTapGesture {
                                                activeImageIndex = index
                                                showingImagePicker = true
                                            }
                                    }
                                }
                                .frame(width: 150, height: 150)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    }

                    Spacer()
                    
                    Button(action: continueButtonTapped) {
                        Text("Continue")
                            .font(.title3)
                            .foregroundColor(images.allSatisfy { $0 != nil } ? Color.white : Color("PrimaryColor"))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(images.allSatisfy { $0 != nil } ? Color("PrimaryColor") : Color.white)
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0, y: 16)
                    }
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Error"), message: Text("Please upload 4 images before continuing."), dismissButton: .default(Text("OK")))
                    }

                    NavigationLink("", destination: ClientHairInspoScreenView().navigationBarHidden(true), isActive: $navigateToHairInspoScreen)
                }
                .padding()
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(sourceType: activeImageIndex < images.count && images[activeImageIndex] != nil ? .camera : .photoLibrary, selectedImage: $images[activeImageIndex])
            }
        }
    }

    private func continueButtonTapped() {
        if images.allSatisfy({ $0 != nil }) {
            sendImagesToBackend()
            navigateToHairInspoScreen = true
        } else {
            showingAlert = true
        }
    }

    private func deleteImage(at index: Int) {
        images[index] = nil
        // Add this line to manually toggle the image picker if needed
        showingImagePicker = false
    }

    private func sendImagesToBackend() {
        // Implement the logic to send images to the backend
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType
    @Binding var selectedImage: UIImage?

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }

            picker.dismiss(animated: true)
        }
    }
}

struct CurrentHairScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ClientCurrentHairScreenView()
    }
}
