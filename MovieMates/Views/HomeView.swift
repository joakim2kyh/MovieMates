//
//  HomeView.swift
//  MovieMates
//
//  Created by Gustav Söderberg on 2022-05-02.
//

import SwiftUI

struct HomeView: View {
    
    @State var index = "friends"
    @State var showMovieView = false
    
    var body: some View {
        ZStack{
            Color("background")
                .ignoresSafeArea()
            
            VStack{
                Picker(selection: $index, label: Text("Review List"), content: {
                    Text("Friends").tag("friends")
                    Text("Trending").tag("trending")
                    
                })
                    .padding(.horizontal)
                    .padding(.top, 20)
                    .pickerStyle(SegmentedPickerStyle())
                    .colorMultiply(.red)
                
                ScrollView{
                    LazyVStack{
                        switch index {
                        case "friends":
                            ForEach(friendsReviews) { review in
                                Button {
                                    showMovieView = true
                                } label: {
                                    ReviewCardView(review: review)
                                }
                                .buttonStyle(.plain)
                            }
                        case "trending":
                            ForEach(trendingReviews) { review in
                                ReviewCardView(review: review)
                            }
                        default:
                            ForEach(friendsReviews) { review in
                                ReviewCardView(review: review)
                            }
                        }
                    }.padding()
                }
                .sheet(isPresented: $showMovieView) {
                    MovieView()
                }
            }
        }
    }
}

struct ReviewCardView: View {
    
    let review: Review
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.gray)
            HStack(alignment: .top){
                
                Image(systemName: "film")
                    .aspectRatio(CGSize(width: 2, height: 3), contentMode: .fit)
                    .frame(width: 100, height: 150, alignment: .center)
                    .border(Color.black, width: 3)
                    .onTapGesture {
                        print("click!")
                    }
                VStack(alignment: .leading){
                    
                    HStack{
                        Text(review.username)
                        Spacer()
                        Text(formatDate(date: review.timestamp))
                            .font(.system(size: 12))
                    }
                    Text(review.title)
                        .font(.title)
                    Text(review.rating)
                    Spacer()
                    Text(review.reviewText)
                        .font(.system(size: 15))
                    Spacer()
                }
            }
            .padding()
        }
    }
}

func formatDate(date: Date) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "d MMMM yyyy"
    return dateFormatter.string(from: date)
}


struct Review: Identifiable {
    var id = UUID()
    let username: String
    let title: String
    let rating: String
    let reviewText: String
    let timestamp = Date.now
}

private var friendsReviews = [
    Review(username: "Sarah", title: "The Batman", rating: "5/5", reviewText: "Siken film! jag grät, jag skrek, jag belv en helt ny människa!"),
    Review(username: "Oscar", title: "The Duckman", rating: "4/5", reviewText: "Jag gillar ankor så denna film var helt perfekt för mig! Dock så var det ett himla kvackande i biosalongen."),
    Review(username: "Joakim", title: "The Birdman", rating: "1/5", reviewText: "Trodde filmen skulle handla om en fågel som ville bli människa, men det var ju helt fel! Den handlar om en man som trodde han var en fågel. Falsk marknadsföring!"),
    Review(username: "Gustav", title: "The Spiderman", rating: "5/5", reviewText: "Jag somnade efter 30min och vaknade strax innan slutet. Bästa tuppluren jag haft på länge! Rekomenderas starkt!")
]

private var trendingReviews = [
    Review(username: "Oscar", title: "The Duckman", rating: "4/5", reviewText: "Jag gillar ankor så denna film var helt perfekt för mig! Dock så var det ett himla kvackande i biosalongen."),
    Review(username: "Joakim", title: "The Birdman", rating: "1/5", reviewText: "Trodde filmen skulle handla om en fågel som ville bli människa, men det var ju helt fel! Den handlar om en man som trodde han var en fågel. Falsk marknadsföring!"),
    Review(username: "Gustav", title: "The Spiderman", rating: "5/5", reviewText: "Jag somnade efter 30min och vaknade strax innan slutet. Bästa tuppluren jag haft på länge! Rekomenderas starkt!"),
    Review(username: "Sarah", title: "The Batman", rating: "5/5", reviewText: "Siken film! jag grät, jag skrek, jag belv en helt ny människa!")
]

//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
