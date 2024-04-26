//
//  StylistViewProfile.swift
//  UMI
//
//  Created by Cyril John on 3/30/24.
//

import SwiftUI

struct StylistViewProfile: View {
    
    var stylistId: Int
    @EnvironmentObject private var session: UserSessionManager
    @ObservedObject var viewModel: ClientViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var stylistProfile: StylistProfile?
    
    @State private var isLoading = false
    @State private var errorMessage: String?
    
    @State private var selectedSegment: Int = 0
    
    //Reviews

    @State private var showingFilterView = false
    @State private var filterTags: [String] = []
    @State private var showingAddReview = false
    
    
    var body: some View {
        ZStack(alignment: .bottomLeading){
            
            VStack(spacing: 0){
                if let stylistP = stylistProfile{
                    ProfileNavigationBar(name: "\(stylistP.fname) \(stylistP.lname)")
                    CustomSegmentedControl(selectedSegment: $selectedSegment, segments: ["Profile", "Reviews"])
                    ScrollView {
                        VStack(alignment: .leading) {
                            // Profile image (reverted back to original size)
                            
                            // Profile details in adjacent rectangles with icons
                            if selectedSegment == 0 {
                                
                                HStack() {
                                    Image(systemName: "person.fill")
                                        .frame(width: 30, alignment: .leading)
                                        .foregroundColor(Color("PrimaryColor"))
                                    VStack(alignment: .leading) {
                                        Text("About Me")
                                            .font(.custom("Poppins-SemiBold", size: 15))
                                        Text(stylistP.clientsShouldKnow)
                                            .font(.custom("Poppins-Regular", size: 18))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                
                                .cornerRadius(10) // Apply corner radius to make the edges rounded
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10) // Use the same corner radius for the overlay as the background
                                        .stroke(Color.black, lineWidth: 1) // Apply stroke to create the border
                                )
                                
                                HStack() {
                                    Image(systemName: "mappin.and.ellipse")
                                        .frame(width: 30, alignment: .leading)
                                        .foregroundColor(Color("PrimaryColor"))
                                    VStack(alignment: .leading) {
                                        Text(stylistP.address.formattedAddress)
                                            .font(.custom("Poppins-Regular", size: 18))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                
                                .cornerRadius(10) // Apply corner radius to make the edges rounded
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10) // Use the same corner radius for the overlay as the background
                                        .stroke(Color.black, lineWidth: 1) // Apply stroke to create the border
                                )
                                HStack {
                                    Image(systemName: "phone")
                                        .frame(width: 30, alignment: .leading)
                                        .foregroundColor(Color("PrimaryColor"))
                                    VStack(alignment: .leading) {
                                        Text("\(stylistP.contacts.phoneNum ?? "Unavailable")")
                                            .font(.custom("Poppins-Regular", size: 18))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(10) // Apply corner radius to make the edges rounded
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10) // Use the same corner radius for the overlay as the background
                                        .stroke(Color.black, lineWidth: 1) // Apply stroke to create the border
                                )
                                
                                HStack {
                                    Image(systemName: "camera")
                                        .frame(width: 30, alignment: .leading)
                                        .foregroundColor(Color("PrimaryColor"))
                                    VStack(alignment: .leading) {
                                        Text("Instagram: \(stylistP.contacts.instagram ?? "Unavailable")")
                                            .font(.custom("Poppins-Regular", size: 18))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(10) // Apply corner radius to make the edges rounded
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10) // Use the same corner radius for the overlay as the background
                                        .stroke(Color.black, lineWidth: 1) // Apply stroke to create the border
                                )
                                
                                HStack {
                                    Image(systemName: "message")
                                        .frame(width: 30, alignment: .leading)
                                        .foregroundColor(Color("PrimaryColor"))
                                    VStack(alignment: .leading) {
                                        Text("Twitter: \(stylistP.contacts.twitter ?? "Unavailable")")
                                            .font(.custom("Poppins-Regular", size: 18))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(10) // Apply corner radius to make the edges rounded
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10) // Use the same corner radius for the overlay as the background
                                        .stroke(Color.black, lineWidth: 1) // Apply stroke to create the border
                                )
                                
                                HStack {
                                    Image(systemName: "link")
                                        .frame(width: 30, alignment: .leading)
                                        .foregroundColor(Color("PrimaryColor"))
                                    VStack(alignment: .leading) {
                                        Text("LinkedTree: \(stylistP.contacts.linkedTree ?? "Unavailable")")
                                            .font(.custom("Poppins-Regular", size: 18))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(10) // Apply corner radius to make the edges rounded
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10) // Use the same corner radius for the overlay as the background
                                        .stroke(Color.black, lineWidth: 1) // Apply stroke to create the border
                                )
                                
                                
                                HStack {
                                    Image(systemName: "dollarsign.circle")
                                        .frame(width: 30, alignment: .leading)
                                        .foregroundColor(Color("PrimaryColor"))
                                    VStack(alignment: .leading) {
                                        Text("\(stylistP.avgPrice)")
                                            .font(.custom("Poppins-Regular", size: 18))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(10) // Apply corner radius to make the edges rounded
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10) // Use the same corner radius for the overlay as the background
                                        .stroke(Color.black, lineWidth: 1) // Apply stroke to create the border
                                )
                                
                                
//                                HStack {
//                                    Image(systemName: "scissors")
//                                        .frame(width: 30, alignment: .leading)
//                                        .foregroundColor(Color("PrimaryColor"))
//                                    
//                                    VStack(alignment: .leading) {
//                                        ForEach(stylistP.specialities, id: \.self) { specialty in
//                                            Text(specialty)
//                                                .font(.custom("Poppins-Regular", size: 18))
//                                        }
//                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                    }
//                                }
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(Color.white)
//                                .cornerRadius(10) // Apply corner radius to make the edges rounded
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 10) // Use the same corner radius for the overlay as the background
//                                        .stroke(Color.black, lineWidth: 1) // Apply stroke to create the border
//                                )
                                
                                HStack {
                                    Image(systemName: "scissors")
                                        .frame(width: 30, alignment: .leading)
                                        .foregroundColor(Color("PrimaryColor"))

                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            ForEach(stylistP.specialities, id: \.self) { specialty in
                                                Text(specialty)
                                                    .font(.custom("Poppins-Regular", size: 18))
                                                    .foregroundColor(.white)
                                                    .padding(.horizontal, 10)
                                                    .padding(.vertical, 5)
                                                    .background(Color("PrimaryColor"))
                                                    .cornerRadius(8)
                                            }
                                        }
                                    }
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(10) // Apply corner radius to make the edges rounded
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10) // Use the same corner radius for the overlay as the background
                                        .stroke(Color.black, lineWidth: 1) // Apply stroke to create the border
                                )

                        
                                
                                // Rating HStack
                                HStack {
                                    Image(systemName: "star.fill") // Example icon for rating
                                        .frame(width: 30, alignment: .leading)
                                        .foregroundColor(Color("PrimaryColor"))
                                    VStack(alignment: .leading) {
                                        
                                        Text("\(stylistP.rating ?? 0.0, specifier: "%.1f")")
                                            .font(.custom("Poppins-Regular", size: 18))
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .cornerRadius(10) // Apply corner radius to make the edges rounded
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10) // Use the same corner radius for the overlay as the background
                                        .stroke(Color.black, lineWidth: 1) // Apply stroke to create the border
                                )
                                
                                
                                Text("More Work")
                                    .font(.custom("Poppins-SemiBold", size: 20)) // Replace with your actual font name and size
                                    .foregroundColor(Color("PrimaryColor")) // Replace with your actual color
                                    .padding(.top)
                                //PortfolioImageView(portfolioImages: stylist.portfolioImages)
                                
                                //                            ForEach(stylist.portfolioImages, id: \.self) { imageUrl in
                                //                                AsyncImage(url: URL(string: imageUrl)) { image in
                                //                                    image.resizable()
                                //                                } placeholder: {
                                //                                    Rectangle()
                                //                                        .fill(Color.gray.opacity(0.3))
                                //                                }
                                //                                .aspectRatio(1, contentMode: .fit)
                                //                                .cornerRadius(10)
                                //                            }
                                
                                
                                // More work - portfolio images scrolling down
                                
                            }
                            if selectedSegment == 1 { // When Reviews segment is selected
                                ScrollView {
                                    VStack(spacing : 20) {
                                        // Filter button
                                        HStack {
                                            Button("Filter") {
                                                showingFilterView = true
                                            }
                                            .foregroundColor(Color("PrimaryColor")) // Color of the text
                                            .font(.custom("Poppins-SemiBold", size: 15)) // Font of the text
                                            .padding(.horizontal) // Horizontal padding
                                            .padding(.vertical, 8) // Vertical padding
                                            .background(Color.white) // Background color of the button
                                            .clipShape(Capsule()) // Shape of the button
                                            .shadow(radius: 3) // Shadow for the button
                                            .popover(isPresented: $showingFilterView) {
                                                FilterView(selectedTags: $filterTags, availableTags: viewModel.tags)
                                            }
                                            
                                            Spacer() // Pushes the button to the left
                                        }
                                        .padding([.leading, .top, .trailing])
                                        
                                        
                                        //FILTERED REVIEWS
                                        
                                        var filteredReviews: [Rating] {
                                            if filterTags.isEmpty {
                                                return viewModel.ratings
                                            } else {
                                                return viewModel.ratings.filter { rating in
                                                    !Set(rating.tags).isDisjoint(with: Set(filterTags))
                                                }
                                            }
                                        }
                                        
                                        // Reviews list
                                        VStack(spacing: 30) {
                                            ForEach(filteredReviews, id: \.rating_id) { review in
                                                ReviewEntryView(review: review)
                                            }
                                        }
                                        
                                        
                                        Spacer()
                                        Spacer()
                                        
                                        // Add Review button
                                        Button(action: {
                                            if stylistId != 0 {
                                                showingAddReview.toggle()
                                            } else {
                                                print("Stylist data is not available")
                                            }
                                        }) {
                                            HStack {
                                                Spacer()
                                                Image(systemName: "plus")
                                                    .font(.title3)
                                                Spacer()
                                            }
                                            .foregroundColor(Color.white)
                                            .padding(.vertical, 10)
                                            .background(Color("PrimaryColor"))
                                            .cornerRadius(25)
                                            .shadow(radius: 3)
                                        }
                                        .padding([.leading, .top, .trailing])
                                    }
                                }
                                .sheet(isPresented: $showingAddReview) {
                                    AddReviewView(stylistId: stylistId, clientVM: viewModel)
                                }
                                
                                .onAppear {
                                    viewModel.getStylistRatings(stylistId: stylistId) { success in
                                        if !success {
                                            print("Error loading reviews: \(viewModel.errorMessage ?? "Unknown error")")
                                        }
                                    }
                                }
                            }
                            // Reviews content would go here
                        }
                        .padding()
                    }
                }else{
                    Text("Loading..")
                }
                
            }
            Spacer()
            
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "arrow.left")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("PrimaryColor").opacity(0.5))
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    .shadow(radius: 4)
                    .padding()
            }
            .padding([.leading, .bottom], 20)
        }
        .edgesIgnoringSafeArea(.bottom)
        
        .navigationBarBackButtonHidden(true)
        
        .onAppear{
            print("StylistViewProfile appeared")
            fetchStylistProfile(stylistId: stylistId)
        }
        .onDisappear {
            print("StylistViewProfile disappeared")
            self.stylistProfile = nil
        }
        
        
    }
//    private func fetchStylistProfile() {
//        viewModel.fetchStylistProfileById(stylistId: stylistId) { [weak viewModel] result in
//            DispatchQueue.main.async {
//                viewModel?.isLoading =  false
//                switch result {
//                case .success(let profile):
//                    self.stylistProfile = profile
//                    // Create and assign a Stylist object based on the fetched profile
//                case .failure(let error):
//                    print("Failed to fetch stylist profile:", error.localizedDescription)
//                    print(viewModel?.errorMessage ?? "Unknown error")
//                }
//            }
//        }
//    }
    
    private func fetchStylistProfile(stylistId: Int) {
            isLoading = true
            errorMessage = nil
            
            let urlString = "http://127.0.0.1:5000/stylist/read-stylist/\(stylistId)"
            guard let url = URL(string: urlString) else {
                self.isLoading = false
                self.errorMessage = "Invalid URL"
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                
                if let error = error {
                    DispatchQueue.main.async {
                        self.errorMessage = "Network request failed: \(error.localizedDescription)"
                    }
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data else {
                    DispatchQueue.main.async {
                        self.errorMessage = "Server error or no data"
                        
                        if let httpResponse = response as? HTTPURLResponse {
                                        print("HTTP Response Status Code: \(httpResponse.statusCode)")
                                    }
                        
                    }
                    return
                }
                
                let rawJSON = String(data: data, encoding: .utf8)
                print("Raw JSON received: \(rawJSON ?? "Invalid JSON")")
                
                do {
                    let decodedResponse = try JSONDecoder().decode(StylistProfile.self, from: data)
                    DispatchQueue.main.async {
                        self.stylistProfile = decodedResponse
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = "Decoding error: \(error.localizedDescription)"
                    }
                }
            }.resume()
        }
    
    
}

// INTERACTIONS & ANIMATIONS /////////////////////////////////////////////////////

struct ProfileNavigationBar: View {
    let name: String  // Property to accept the name

    var body: some View {
        ZStack {
            HStack {
                Text("UMI") // Left-aligned logo text
                    .font(.custom("Sarina-Regular", size: 15))
                    .foregroundColor(Color("PrimaryColor"))
                    .frame(width: 80, alignment: .leading)
                
                Spacer() // This will push the name towards center
                
                Text(name) // Use the name here
                    .font(.custom("Sansita-BoldItalic", size: calculateFontSize(for: name)))
                    .foregroundColor(Color("TitleTextColor"))
                    .frame(maxWidth: .infinity, alignment: .center) // Center the name text
                
                Spacer() // This will push the button towards the trailing edge
                
                Button(action: {
                    // Action for search button
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle.fill")
                        .imageScale(.large)
                        .accentColor(Color("PrimaryColor"))
                }
                .frame(width: 80, alignment: .trailing) // Right-aligned button
            }
            .padding(.horizontal)
        }
        .frame(height: 60) // Fixed height for the navigation bar
    }

    // Function to calculate font size based on the length of the name
    private func calculateFontSize(for name: String) -> CGFloat {
        switch name.count {
        case 0...10:
            return 28 // Larger font size for short names
        case 11...20:
            return 24 // Medium font size for moderately long names
        default:
            return 20 // Smaller font size for long names
        }
    }
}

struct CustomSegmentedControl: View {
    @Binding var selectedSegment: Int // This should be bound to a state variable
    let segments: [String]
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    ForEach(segments.indices, id: \.self) { index in
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                selectedSegment = index
                                
                            }
                        }) {
                            Text(segments[index])
                                .font(.custom("Poppins-SemiBold", size: 16)) // Set the font size to match your design
                                .foregroundColor(selectedSegment == index ? Color("PrimaryColor") : .gray)
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
                .frame(height: 40) // Height of your segment control
                
                // Underline only the selected segment
                Rectangle()
                    .frame(width: geometry.size.width / CGFloat(segments.count), height: 2) // Use the width of the GeometryReader divided by the number of segments
                    .foregroundColor(Color("PrimaryColor"))
                    .offset(x: geometry.size.width / CGFloat(segments.count) * CGFloat(selectedSegment), y: 0)
                    // Apply animation to smoothly move the underline
                    .animation(.linear, value: selectedSegment)
            }
        }
        .frame(height: 42) // Total height of the segment control including the underline
        .animation(.easeInOut(duration: 0.1), value: selectedSegment)
    }
}

struct StarRatingView: View {
    @Binding var rating: Int
    
    var label = ""
    var maximumRating = 5
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color("PrimaryColor")
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
    
    var body: some View {
        HStack {
            if !label.isEmpty {
                Text(label)
            }
            
            ForEach(1..<maximumRating + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
    }
}

//REVIEWSS /////////////////////

struct ReviewDetailView: View {
    let review: Rating
    @State private var isExpanded = false  // State to track expanded/collapsed view

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(review.client_name)
                .font(.custom("Poppins-SemiBold", size: 20))
                .padding(.top)

            HStack {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: "star.fill")
                        .foregroundColor(index <= Int(review.stars) ? Color("PrimaryColor") : .gray)
                }
            }

            // Make the text expandable on tap
            Text(review.review)
                .font(.custom("Poppins-Regular", size: 15))
                .lineLimit(isExpanded ? nil : 3) // Show all lines when expanded, default to 3 lines
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
                .padding()

            HStack {
                ForEach(review.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.custom("Poppins-Italic", size: 12))
                        .padding(4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(4)
                }
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
        .padding(.horizontal)
    }
}


struct ReviewEntryView: View {
    
    let review: Rating
    @State private var showingPopup = false
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(review.client_name)
                .font(.custom("Poppins-SemiBold", size: 20))

            VStack {
                StarRatingView(rating: .constant(Int(review.stars)), offColor: .gray , onColor: Color("PrimaryColor"))
                Spacer()
                Text(review.review)
                    .font(.custom("Poppins-Regular", size: 15))
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)

            HStack {
                ForEach(review.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.custom("Poppins-Italic",size: dynamicTagFontSize(for: tag)))
                        .padding(4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(4)
                }
            }
        }
        .padding()
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 3)
                .padding(.horizontal)
                .onTapGesture {
                    showingPopup = true
                }
                .sheet(isPresented: $showingPopup) {
                    ReviewDetailView(review: review)
                }
    }
    
    private func dynamicTagFontSize(for tag: String) -> CGFloat {
            let length = tag.count
            switch length {
            case 0...4:
                return 14 // Larger font size for shorter tags
            case 5...10:
                return 12 // Medium font size for medium-length tags
            default:
                return 10 // Smaller font size for longer tags
            }
        }
}



import SwiftUI

struct AddReviewView: View {
    
    @EnvironmentObject private var session: UserSessionManager
    var stylistId: Int  // Accept stylistId directly
    @State private var rating: Int = 0
    @State private var comment: String = ""
  
    @State private var isLoading: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    @ObservedObject var clientVM: ClientViewModel

    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Submitting...")
                } else {
                    Form {
                        Section(header: Text("Rating").font(.headline)) {
                            StarRatingView(rating: $rating)
                        }
                        Section(header: Text("Comment").font(.headline)) {
                            TextField("Comment", text: $comment)
                                .frame(minHeight: 100)
                                .padding(4)
                                .background(Color(UIColor.systemBackground))
                                .cornerRadius(8)
                        }
                    }

                    Button(action: submitReview) {
                        Text("Submit")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color.blue)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding(.vertical)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Review Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
            }
            .navigationBarTitle("Add Review", displayMode: .inline)
        }
    }
    
    func submitReview() {
        guard let clientId = session.userId, session.userType == "client" else {
                    alertMessage = "Invalid user or user type for review submission"
                    showAlert = true
                    return
                }
                isLoading = true
                clientVM.postReview(clientId: clientId, stylistId: stylistId, rating: rating, comment: comment) { success, message in
                    isLoading = false
                    alertMessage = message
                    showAlert = true
                }
            }
}


struct FilterView: View {
    @Binding var selectedTags: [String]
    let availableTags: [String]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                ForEach(availableTags, id: \.self) { tag in
                    Button(action: {
                        toggleTag(tag)
                    }) {
                        TagView(tag: tag, isSelected: selectedTags.contains(tag))
                    }
                    .padding(.horizontal, 4)
                }
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 3)
        .padding(.horizontal)
    }
    
    private func toggleTag(_ tag: String) {
        if let index = selectedTags.firstIndex(of: tag) {
            selectedTags.remove(at: index)
        } else {
            selectedTags.append(tag)
        }
    }
}

struct TagView: View {
    let tag: String
    var isSelected: Bool

    var body: some View {
        HStack {
            Text(tag)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .font(.custom("Poppins-Regular", size: 14))
                .background(isSelected ? Color("PrimaryColor") : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? Color.white : Color.black)
                .cornerRadius(8)
        }
    }
}

//public struct PortfolioImageView: View {
//    let portfolioImages: [String]
//    @State private var selectedImageUrl: String?
//    @State private var isSheetPresented = false
//
//    public init(portfolioImages: [String]) {
//        self.portfolioImages = portfolioImages
//    }
//
//    private var columns: [GridItem] = [
//        GridItem(.flexible()),
//        GridItem(.flexible())
//    ]
//
//    public var body: some View {
//        LazyVGrid(columns: columns, spacing: 10) {
//            ForEach(portfolioImages, id: \.self) { imageName in // imageURL in
//                Image("long-hair") // Using the asset name to create an Image view
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                    .frame(height: 150)
//                                    .cornerRadius(10)
//                                    .onTapGesture {
//                                        selectedImageUrl = imageName
//                                        isSheetPresented = true
//                                    }
//                
////                AsyncImage(url: URL(string: imageUrl)) { phase in
////                    switch phase {
////                    case .success(let image):
////                        image.resizable()
////                             .aspectRatio(contentMode: .fill)
////                             .frame(height: 150)
////                             .cornerRadius(10)
////                             .onTapGesture {
////                                 selectedImageUrl = imageUrl
////                                 isSheetPresented = true
////                             }
////                    case .failure(_):
////                        Rectangle().fill(Color.gray.opacity(0.3))
////                    case .empty:
////                        ProgressView()
////                    @unknown default:
////                        EmptyView()
////                    }
////                }
//            }
//        }
//        .sheet(isPresented: $isSheetPresented) {
//            if let url = selectedImageUrl {
//                AsyncImage(url: URL(string: url)) { phase in
//                    switch phase {
//                    case .success(let image):
//                        image.resizable()
//                             .aspectRatio(contentMode: .fit)
//                             .padding()
//                    case .failure(_):
//                        Text("Unable to load image")
//                    case .empty:
//                        ProgressView()
//                    @unknown default:
//                        EmptyView()
//                    }
//                }
//            }
//        }
//    }
//}


struct StylistViewProfile_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of UserSessionManager and set it up as needed for the preview.
        let sessionManager = UserSessionManager.shared
        sessionManager.userId = 1 // Example user ID, set this to a valid ID for your preview
        sessionManager.userType = "stylist" // Assuming you're previewing a stylist profile

        return StylistViewProfile(stylistId: 0, viewModel: ClientViewModel())
            .environmentObject(sessionManager) // Injecting the UserSessionManager as an environment object
    }
}
