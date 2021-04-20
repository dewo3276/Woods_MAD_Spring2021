//
//  mapWidget.swift
//  mapWidget
//
//  Created by Dusty on 4/20/21.
//

import WidgetKit
import SwiftUI
import MapKit
import Intents

struct Provider: IntentTimelineProvider {
    
    private func makeSnapshotter(for country: Country, with size: CGSize)
      -> MKMapSnapshotter {
      let options = MKMapSnapshotter.Options()
      options.region = country.region
      options.size = size

      // Force light mode snapshot
      options.traitCollection = UITraitCollection(traitsFrom: [
        options.traitCollection,
        UITraitCollection(userInterfaceStyle: .light)
      ])

      return MKMapSnapshotter(options: options)
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let countries = loadCountries().randomSample(count: 1)
         if let country = countries.first {
            let mapSnapshotter = makeSnapshotter(for: country,
                  with: context.displaySize)
            mapSnapshotter.start { (snapshot, error) in
                 if let snapshot = snapshot {
                   let date = Date()
                   let nextUpdate = Calendar.current.date(byAdding: .hour,
                     value: 1,
                     to: date)!
                   let entry = MapEntry(date: date,
                     country: country,
                     image: snapshot.image)
                   let timeline = Timeline(entries: [entry],
                     policy: .after(nextUpdate))
                   completion(timeline)
                 }
               }
             }
           }

struct SimpleEntry: TimelineEntry {
    let date: Date
    let country: Country
    let image: UIImage
    let configuration: ConfigurationIntent
}

    struct CountryView: View {
      let country: Country

      var body: some View {
        VStack {
          CountryFields(country: country)
          Divider()
          Map(coordinateRegion: .constant(country.region))
        }
        .navigationBarTitle(Text(country.name), displayMode: .inline)
      }
    }
    
struct mapWidgetEntryView : View {
    var entry: Provider.Entry
    var entry: MapEntry
      var body: some View {
        Image(uiImage: entry.image)
          .widgetURL(entry.country.url)
      }
}

@main
struct mapWidget: Widget {
    let kind: String = "mapWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            mapWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct mapWidget_Previews: PreviewProvider {
    static var previews: some View {
        mapWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
