import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                HomeView()
                    .navigationBarTitle("Instagram", displayMode: .inline)
                    .navigationBarItems(leading:
                                            Button(action: {}, label: {
                                                Image(systemName: "camera")
                                            }), trailing: Button(action: {}, label: {
                                                Image(systemName: "paperplane")
                                            }))
                    
            }.tabItem {
                Image(systemName: "house.fill")
                    .font(.title2)
            }
            
            Text("Search")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                }
            
            Text("Add")
                .tabItem {
                    Image(systemName: "plus.app")
                        .font(.title2)
                }
            
            Text("Heart")
                .tabItem {
                    Image(systemName: "heart.fill")
                        .font(.title2)
                }
            NavigationView{
                ProfilView()
            }.tabItem {
                Image(systemName: "person.fill")
                    .font(.title2)
            }
        }
    }
}

struct HomeView: View {
    var relativeFormatter: RelativeDateTimeFormatter {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        formatter.locale = Locale(identifier: "fr_FR")
        return formatter
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(Author.all) { author in
                            AuthorStoryView(author: author)
                        }
                    }.padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                }
                Divider()
                
                ForEach(Post.all) { post in
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            AuthorStoryView(author: post.author, width: 40, showText: false)
                            VStack(alignment: .leading) {
                                Text(post.author.name)
                                    .font(.headline)
                                Text("Paris")
                            }
                            
                            Spacer()
                            Image(systemName: "ellipsis")
                        }.padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        
                        Divider()
                        Image(post.imageName)
                            .resizable()
                            .scaledToFit()
                        
                        HStack(spacing: 20) {
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Image(systemName: "heart")
                                    .font(.title)
                            }).buttonStyle(PlainButtonStyle())
                            
                            Button(action: {}, label: {
                                Image(systemName: "bubble.right")
                                    .font(.title)
                            }).buttonStyle(PlainButtonStyle())
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Image(systemName: "paperplane")
                                    .font(.title)
                            }).buttonStyle(PlainButtonStyle())
                            Spacer()
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Image(systemName: "bookmark")
                                    .font(.title)
                            }).buttonStyle(PlainButtonStyle())
                        }.padding()
                    }
                    
                    VStack(alignment: .leading) {
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Voir les J'aime")
                                .font(.headline)
                        }).buttonStyle(PlainButtonStyle())
                        
                        
                        HStack(alignment: .top) {
                            Text(post.author.name)
                                .font(.headline)
                            Text(post.comment)
                                .lineLimit(nil)
                        }
                        
                        Text(relativeFormatter.localizedString(for: post.creationDate, relativeTo: Date()))
                            .font(.callout)
                            .foregroundColor(.gray)
                    }.padding(.horizontal)
                }
            }
        }
    }
}

struct Info: Hashable {
    let number: Int
    let label: String
}

struct InfoVStackView: View {
    let infos = [
        Info(number: 3, label: "Posts"),
        Info(number: 7, label: "Followers"),
        Info(number: 7, label: "Following")
    ]
    var body: some View {
        HStack {
            ForEach(infos, id: \.self){info in
                VStack {
                    Text("\(info.number)")
                        .bold()
                    Text(info.label)
                        .bold()
                }
                .padding(.horizontal)
            }
        }
    }
}
 
struct TopView: View {
    var body: some View{
        HStack{
            Image(systemName: "person.crop.circle.badge.plus")
                .font(.system(size: 35))
                .padding(.horizontal)
            
            InfoVStackView()
        }
        .padding(.top, 35)
    }
}

struct ProfilView: View {
    var body: some View {
        ScrollView(.vertical) {
            TopView()
            BioView()
            EditButtonView()
            HButtonView()
            ImageView()
            CompleteProfile()
        }
        .navigationBarTitle("coding_instagram_process",
                            displayMode: .inline)
    }
}
struct BioView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text("Nico Loco")
            }
            Spacer()
        }
        .padding()
    }
}
struct HButtonView: View {
    let buttons = ["square.grid.2x2", "person.crop.rectangle"]
    var body: some View {
        HStack{
            ForEach(buttons, id: \.self) { button in
                HStack{
                    Spacer()
                    Button(action: {
                        print("Edit")
                    }) {
                        Image(systemName: button)
                            .font(.title)
                            .foregroundColor(Color(.label))
                    }
                    Spacer()
                }
            }
        }
        .padding()
    }
}
struct EditButtonView: View {
    var body: some View {
        Button(action: {
            print("Edit")
        }) {
            Text("Edit Profile")
                .bold()
                .foregroundColor(Color(.label))
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
    }
}
struct ImageView: View {
    var body: some View {
        HStack (spacing: 2){
            ForEach(0 ..< 3) { _ in
                LinearGradient(gradient: Gradient(colors: [.orange, .pink]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(height: 138)
            }
        }
    }
}

struct CompleteProfile: View {
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading) {
                    Text("Complete your profile")
                        .bold()
                    Text("3 of 4")
                        .foregroundColor(.green)
                    Text("COMPLETE")
                }
                Spacer()
            }
            .padding()
            
            ScrollView (.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(0 ..< 5) { _ in
                        CardView()
                    }
                }
            }
        }
    }
}

struct CardView: View {
    var body: some View {
        VStack{
            Image(systemName: "bubble.right")
                .font(.system(size: 38))
                .overlay(CircleView())
                .padding()
            
            Text("Add a Bio")
                .bold()
                .padding()
            
            Text("Tell something about \nyourself")
                .multilineTextAlignment(.center)
            
            Button(action: {
                //
            }) {
                Text("Add Bio")
                    .bold()
                    .foregroundColor(.white)
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 16)
            .background(Color.blue)
            .cornerRadius(12)
            .padding(.top, 32)
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .padding()
    }
}

struct CircleView: View {
    var body: some View {
        Circle()
            .stroke(Color.primary, lineWidth: 4)
            .frame(width: 72, height: 72)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AuthorStoryView: View {
    let author: Author
    var width: CGFloat = 70
    var showText = true
    var body: some View {
        VStack {
            Image(author.photoName)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .frame(width: width)
                .overlay(
                    Circle().stroke(Color.red, style: StrokeStyle(lineWidth: 2))
                        .frame(width: width + 5, height: width + 5)
                )
            if showText {
                Text(author.name)
            }
        }
    }
}
