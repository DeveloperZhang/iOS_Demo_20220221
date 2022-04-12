//
//  MyWidget.swift
//  MyWidget
//
//  Created by Vicent on 2022/4/12.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct MyWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.date, style: .time)
    }
}

// View，小组件的界面
struct WidgetExtensionEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        // 深度布局，屏幕深度
        ZStack(alignment: .center, content: {
            // 背景图
//            Image(systemName: "square.and.arrow.up.fill").resizable().aspectRatio(contentMode: .fit)
            //  水平
            HStack(alignment: .center, spacing: 5, content: {
                // 左侧图
                Image(systemName:"airpods.gen3").frame(width: 80, height: 80, alignment: .center).aspectRatio(contentMode: .fit).cornerRadius(10.0)
                // 垂直
                VStack(alignment: .center, spacing: 5, content: {
                    // 右侧文字
                    Text("小组件1").foregroundColor(.blue)
                    Text("小组件2").foregroundColor(.blue).lineLimit(2)
                })

            })
        }).widgetURL(URL(string: "widgetExtensionDemo://test1"))
    }
}

@main
struct MyWidget: Widget {
    let kind: String = "MyWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WidgetExtensionEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}



struct MyWidget_Previews: PreviewProvider {
    static var previews: some View {
//        MyWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
        // 设置小组件尺寸 systemSmall systemMedium systemLarge
        WidgetExtensionEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
                   .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}

