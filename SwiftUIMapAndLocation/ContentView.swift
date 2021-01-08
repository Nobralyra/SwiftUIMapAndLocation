//
//  ContentView.swift
//  SwiftUIMapAndLocation
//
//  Created by admin on 02/10/2020.
//

import SwiftUI
import MapKit

// En udbyggelse kunne være til Firestorage

struct ContentView: View
{
    // Passer med binding i MapView
    @State private var centerCoordinate = CLLocationCoordinate2D()
    
    // Skal med som parameter til MapView, men behøver ikke at være forbundet, så MapViews annotations skal ikke have @Binding
    // Er de locationer som er blevet tilføjet
    @State var annotations = [MKPointAnnotation]()
    
    var body: some View
    {
        ZStack
        {
            // Få vist MapView
            // Dollertegn foran centerCoordinate for specificere at den der skal modtage dataen IKKE er @State variablen centerCoordinate fra ContentView, men MyMapView @Binding centerCoordinate
            // Man behøver ikke at skrive new MapView i SwiftUI, man kan bare bruge objektet af MapView med det samme - modsat Java
            // annotations: annotations smider med at der er et nyt punkt
            MyMapView(centerCoordinate: $centerCoordinate, annotations: annotations)
            Circle()
                .fill()
                .frame(width: 32, height: 32)
                .opacity(0.4)
            
            VStack
            {
                Spacer()
                HStack
                {
                    Spacer()
                    Button
                    {
                        let newLocation = MKPointAnnotation()
                        
                        // newLocation.coordinate er altid opdateret
                        newLocation.coordinate = self.centerCoordinate
                        self.annotations.append(newLocation)
                    }
                    label:
                    {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue.opacity(0.75))
                    .font(.title)
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
