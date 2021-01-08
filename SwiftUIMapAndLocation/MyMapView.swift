//
//  MapView.swift
//  SwiftUIMapAndLocation
//
//  Created by admin on 02/10/2020.
//

import SwiftUI
import MapKit

// MapView er selvkørende, så man skal ikke kalde metoderne selv, for det gør AppDelegate ved at protokollen UIViewRepresentable
// Struct har allerede en constructor
struct MyMapView: UIViewRepresentable
{
    // Den skal angives med dollertegn i ContentView, for at fortælle at det er en binding der skal modtage dataen
    @Binding var centerCoordinate: CLLocationCoordinate2D
    
    // Er med som parameter fra ContentView til MapView, men behøver ikke at være forbundet, så MapViews annotations skal ikke have @Binding
    // Bliver først angivet i constructoren af Struct, så derfor er det colon : og ikke ligmed =
    var annotations: [MKPointAnnotation]
    
    // Laver mappet der skal vises
    func makeUIView(context: Context) -> some MKMapView
    {
        let map = MKMapView()
        //map.mapType = .satellite // Ændrer på vores map der vises
        map.delegate = context.coordinator
        return map
    }
    
    // Når man opdatere en ny lokation
    func updateUIView(_ uiView: UIViewType, context: Context)
    {
        // Hvis vores list annotations ikke matcher uiView (mappet), så
        if annotations.count != uiView.annotations.count
        {
            // Fjerne alt fra mappet
            uiView.removeAnnotations(uiView.annotations)
            
            // Tilføje det nyeste antal
            uiView.addAnnotations(annotations)
        }
    }
    
    // Hvordan får man givet instans af struct med som parameter i en child class
    func makeCoordinator() -> Coordinator
    {
        // Giver MapView med som parameter - et helt objekt
        return Coordinator(self)
    }
    
    // Håndtere specifikt mappet
    // Coordinator class - en klasse man selv bygger som er et pattern, som skal håndtere events for det gamle og oversætte til det nye - er en slags bro.
    // Håndtere events fremadrettet. Så som at hvis man har flyttet mappet - hvad er de nye koordinator
    class Coordinator: NSObject, MKMapViewDelegate
    {
        var parent: MyMapView
        
        // Constructor for klassen, da den ikke er der som standard til class
        init(_ parent: MyMapView)
        {
            self.parent = parent
        }
        
        // Er en metode som MKMapViewDelegate skal have implementeret
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView)
        {
            // Gem ny lokation for centrum af map
            // Spørge om MapView hvad de nye koordinator der skal gemmes i vores parent
            parent.centerCoordinate = mapView.centerCoordinate
        }
    }
}
