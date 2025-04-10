import 'dart:convert';

MeetingModel meetingModelFromJson(String str) =>
    MeetingModel.fromJson(json.decode(str));

class MeetingModel {
  int status;
  String message;
  List<Event> data;

  MeetingModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MeetingModel.fromJson(Map<String, dynamic> json) => MeetingModel(
      status: json["status"],
      message: json["message"],
      data: json.containsKey("data")
          ? json["data"] == null
              ? []
              : List<Event>.from(json["data"].map((x) => Event.fromJson(x)))
          : []);
}

class Event {
  DateTime date;
  List<EventItems> items;

  Event({
    required this.date,
    required this.items,
  });
  DateTime get dateOnly => DateTime(date.year, date.month, date.day);
  bool get isPastEvent {
    final now = DateTime.now();
    return dateOnly.isBefore(DateTime(now.year, now.month, now.day));
  }

  bool get isUpcomingEvent {
    final now = DateTime.now();
    return dateOnly.isAfter(DateTime(now.year, now.month, now.day));
  }

  bool get isTodayEvent {
    final now = DateTime.now();
    return dateOnly == DateTime(now.year, now.month, now.day);
  }

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        date: DateTime.parse(json["date"]),
        items: List<EventItems>.from(
            json["items"].map((x) => EventItems.fromJson(x))),
      );
}

class EventItems {
  String id;
  String title;
  String time;
  bool conflicted;

  EventItems({
    required this.id,
    required this.title,
    required this.time,
    required this.conflicted,
  });

  factory EventItems.fromJson(Map<String, dynamic> json) => EventItems(
        id: json["id"],
        title: json["title"],
        time: json["time"],
        conflicted: json["conflicted"],
      );
}
