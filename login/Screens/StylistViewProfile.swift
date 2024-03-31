//
//  StylistViewProfile.swift
//  UMI
//
//  Created by Cyril John on 3/30/24.
//

import SwiftUI

struct Review: Identifiable {
    let id: UUID
    let customerName: String
    let rating: Float
    let comment: String
    let tags: [String] // Example: ["Cutting", "Styling"]
}

struct StylistProfile: Identifiable {
    let id: UUID
    let name: String
    let address: String
    let priceRange: String
    let specialties: [String]
    let profileImageUrl: String
    let portfolioImages: [String] // URLs of portfolio images
    let matchingPercentage: Float // e.g., 95%
    let rating: Float
    let services: [String]
    let reviews: [Review]
}

// example review

let exampleReviews: [Review] = [
    Review(id: UUID(), customerName: "Customer 1", rating: 4, comment: "Great experience, loved the haircut!", tags: ["fades", "blonde services"]),
    Review(id: UUID(), customerName: "Customer 2", rating: 5, comment: "Amazing service, very friendly!", tags: ["long haircuts"])
]


struct StylistProfileView: View {
    var stylist: StylistProfile
    
    @State private var selectedSegment: Int = 0
    @State private var showingAddReview = false
    
    let availableTags = ["fades", "blonde services", "long haircuts"]
    @State private var showingFilterView = false
    @State private var filterTags: [String] = []
    
    var filteredReviews: [Review] {
        guard !filterTags.isEmpty else {
            return stylist.reviews
        }
        return stylist.reviews.filter { review in
            !Set(review.tags).isDisjoint(with: Set(filterTags))
        }
    }
    
    var body: some View {
        VStack(spacing: 0){
            ProfileNavigationBar(name: stylist.name)
            CustomSegmentedControl(selectedSegment: $selectedSegment, segments: ["Profile", "Reviews"])
            ScrollView {
                VStack(alignment: .leading) {
                    // Profile image (reverted back to original size)
                    
                    // Profile details in adjacent rectangles with icons
                    if selectedSegment == 0 {
                        
                        AsyncImage(url: URL(string: stylist.profileImageUrl)) { image in
                            image.resizable()
                        } placeholder: {
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                        }
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(10)
                        HStack() {
                            Image(systemName: "mappin.and.ellipse")
                                .frame(width: 30, alignment: .leading)
                                .foregroundColor(Color("PrimaryColor"))
                            VStack(alignment: .leading) {
                                Text(stylist.address)
                                    .font(.custom("Poppins-Regular", size: 18))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
                        
                        HStack {
                            Image(systemName: "dollarsign.circle")
                                .frame(width: 30, alignment: .leading)
                                .foregroundColor(Color("PrimaryColor"))
                            VStack(alignment: .leading) {
                                Text(stylist.priceRange)
                                    .font(.custom("Poppins-Regular", size: 18))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
                        
                        HStack {
                            Image(systemName: "scissors")
                                .frame(width: 30, alignment: .leading)
                                .foregroundColor(Color("PrimaryColor"))
                            
                            VStack(alignment: .leading) {
                                ForEach(stylist.specialties, id: \.self) { specialty in
                                    Text(specialty)
                                        .font(.custom("Poppins-Regular", size: 18))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
                        
                        HStack {
                            Image(systemName: "person.fill.questionmark") // Example icon for matching percentage
                                .frame(width: 30, alignment: .leading)
                                .foregroundColor(Color("PrimaryColor"))
                            VStack(alignment: .leading) {
                                
                                Text("\(stylist.matchingPercentage, specifier: "%.0f%%")")
                                    .font(.custom("Poppins-Regular", size: 18))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
                        
                        // Rating HStack
                        HStack {
                            Image(systemName: "star.fill") // Example icon for rating
                                .frame(width: 30, alignment: .leading)
                                .foregroundColor(Color("PrimaryColor"))
                            VStack(alignment: .leading) {
                                
                                Text("\(stylist.rating, specifier: "%.1f")")
                                    .font(.custom("Poppins-Regular", size: 18))
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
                        
                        // Services HStack
                        HStack {
                            Image(systemName: "wrench.and.screwdriver.fill") // Example icon for services
                                .frame(width: 30, alignment: .leading)
                                .foregroundColor(Color("PrimaryColor"))
                            VStack(alignment: .leading) {
                                
                                ForEach(stylist.services, id: \.self) { service in
                                    Text(service)
                                        .font(.custom("Poppins-Regular", size: 18))
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 1)
                        
                        Text("More Work")
                            .font(.custom("Poppins-SemiBold", size: 20)) // Replace with your actual font name and size
                            .foregroundColor(Color("PrimaryColor")) // Replace with your actual color
                            .padding(.top)
                        ForEach(stylist.portfolioImages, id: \.self) { imageUrl in
                            AsyncImage(url: URL(string: imageUrl)) { image in
                                image.resizable()
                            } placeholder: {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.3))
                            }
                            .aspectRatio(1, contentMode: .fit)
                            .cornerRadius(10)
                    }
                    
                    
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
                                        FilterView(selectedTags: $filterTags, availableTags: availableTags)
                                    }
                                    
                                    Spacer() // Pushes the button to the left
                                }
                                .padding([.leading, .top, .trailing])
                                
                                // Reviews list
                                VStack(spacing: 30) {
                                    ForEach(stylist.reviews) { review in
                                        ReviewEntryView(review: review)
                                    }
                                }
                                Spacer()
                                Spacer()
                                
                                // Add Review button
                                Button(action: {
                                    showingAddReview.toggle()
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
                            AddReviewView()
                        }
                    }
                    // Reviews content would go here
                }
                .padding()
            }
            
        }
        
        
    }
    private func actionSheetButtons() -> [ActionSheet.Button] {
            var buttons = availableTags.map { tag in
                ActionSheet.Button.default(Text(tag)) {
                    if filterTags.contains(tag) {
                        filterTags.removeAll(where: { $0 == tag })
                    } else {
                        filterTags.append(tag)
                    }
                }
            }
            buttons.append(.cancel())
            return buttons
        }
}

// INTERACTIONS & ANIMATIONS /////////////////////////////////////////////////////

struct ProfileNavigationBar: View {
    let name: String  // Add a property to accept the name

    var body: some View {
        ZStack {
            HStack {
                Text("UMI") // Left-aligned logo text
                    .font(.custom("Sarina-Regular", size: 15))
                    .foregroundColor(Color("PrimaryColor"))
                    .frame(width: 80, alignment: .leading)
                
                Spacer() // This will push the name towards center
                
                Text(name) // Use the name here
                    .font(.custom("Sansita-BoldItalic", size: 28))
                    .foregroundColor(Color("TitleTextColor"))
                    .frame(maxWidth: .infinity, alignment: .center) // Center the name text
                
                Spacer() // This will push the button towards the trailing edge
                
                Button(action: {
                    // Action for search button
                }) {
                    Image(systemName: "person")
                        .imageScale(.large)
                        .accentColor(.black)
                }
                .frame(width: 80, alignment: .trailing) // Right-aligned button
            }
            .padding(.horizontal)
        }
        .frame(height: 60) // Fixed height for the navigation bar
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
    let review: Review
    
    var body: some View {
        VStack {
            Text(review.customerName)
                .font(.title)
                .padding(.top)
            
            HStack{
                ForEach(1...5, id: \.self) { index in
                Image(systemName: "star.fill")
                        .foregroundColor(index <= Int(review.rating) ? Color("PrimaryColor") : .gray)
            }
            }
            
            Text(review.comment)
                .padding()
            
            ForEach(review.tags, id: \.self) { tag in
                Text(tag)
                    .font(.caption)
                    .padding(4)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(4)
            }
            
            Spacer()
        }
       
    }
}


struct ReviewEntryView: View {
    let review: Review
    @State private var showingPopup = false
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(review.customerName)
                .font(.custom("Poppins-SemiBold", size: 20))

            VStack {
                StarRatingView(rating: .constant(Int(review.rating)), offColor: .gray , onColor: Color("PrimaryColor"))
                Spacer()
                Text(review.comment)
                    .font(.custom("Poppins-Regular", size: 15))
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)

            HStack {
                ForEach(review.tags, id: \.self) { tag in
                    Text(tag)
                        .font(.custom("Poppins-Italic", size: 12))
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
}


struct AddReviewView: View {
    // Define the states for each field you need for the review
    @State private var rating: Int = 0
    @State private var comment: String = ""
    @State private var selectedTags: Set<String> = []
    
    // Other states as needed for your form
    
    let availableTags = ["fades", "blonde services", "long haircuts"]
    
    
    var body: some View {
        // Create the form for adding a review here
        NavigationView {
            Form {
                Section(header: Text("Rating")) {
                    
                    StarRatingView(rating: $rating)
                }
                
                Section(header: Text("Comment")) {
                    
                    TextEditor(text: $comment)
                                            .frame(minHeight: 100)
                }
                Section(header: Text("Tags")) {
                                    ForEach(availableTags, id: \.self) { tag in
                                        Button(tag) {
                                            if selectedTags.contains(tag) {
                                                selectedTags.remove(tag)
                                            } else {
                                                selectedTags.insert(tag)
                                            }
                        }
                                        .foregroundColor(selectedTags.contains(tag) ? .blue : .primary)
                    }
                }
                // Add more sections as needed for your form
            }
            .navigationBarTitle("Add Review", displayMode: .inline)
            .navigationBarItems(trailing: Button("Submit") {
                // Submit action
            })
        }
    }
}
struct FilterView: View {
    @Binding var selectedTags: [String]
    let availableTags: [String]
    
    var body: some View {
        VStack {
            ForEach(availableTags, id: \.self) { tag in
                Button(action: {
                    if selectedTags.contains(tag) {
                        selectedTags.removeAll { $0 == tag }
                    } else {
                        selectedTags.append(tag)
                    }
                }) {
                    HStack {
                        Text(tag)
                            .foregroundColor(selectedTags.contains(tag) ? .blue : .black)
                        if selectedTags.contains(tag) {
                            Image(systemName: "checkmark")
                        }
                    }
                }
                .padding()
            }
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

struct StylistProfileView_Previews: PreviewProvider {
    static var previews: some View {
        StylistProfileView(stylist: StylistProfile(id: UUID(),
                                                   name: "Alex Smith",
                                                   address: "1234 Road Dr",
                                                   priceRange: "$60 - $100",
                                                   specialties: ["Curly Hair"],
                                                   profileImageUrl: "https://example.com/image1.jpg",
                                                   portfolioImages: ["https://example.com/work1.jpg",
                                                                     "https://example.com/work2.jpg",
                                                                     "https://example.com/work3.jpg"],
                                                   matchingPercentage: 90,
                                                   rating: 4.5, services: ["Fades"], reviews: exampleReviews))
    }
}
