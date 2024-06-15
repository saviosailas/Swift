import SwiftUI

struct ContentView: View {
    @State private var offset: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                HeaderView()
                    .frame(height: 300)
                    .background(GeometryReader { geo -> Color in
                        let minY = geo.frame(in: .global).minY
                        DispatchQueue.main.async {
                            self.offset = minY
                        }
                        return Color.clear
                    })
                    .offset(y: self.offset > 0 ? -self.offset : 0)
                    .scaleEffect(self.offset > 0 ? 1 + self.offset / 300 : 1)
                    .animation(.easeOut, value: self.offset)

                ScrollView {
                    VStack {
                        ForEach(0..<30) { index in
                            Text("Item \(index)")
                                .padding()
                                .background(Color.white)
                                .cornerRadius(8)
                                .shadow(radius: 2)
                                .padding(.horizontal)
                                .padding(.top, 8)
                        }
                    }
                    .background(Color(UIColor.systemGroupedBackground))
                    .padding(.top, -20) // Adjust padding to hide the top space caused by header
                }
                .background(Color(UIColor.systemGroupedBackground))
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct HeaderView: View {
    var body: some View {
        ZStack {
            Image("profile_picture") // Replace with your image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: 300)
                .clipped()

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Profile Name")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}