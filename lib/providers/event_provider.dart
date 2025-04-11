// lib/providers/event_provider.dart
import 'package:flutter/material.dart';
import 'package:machinetest_10042025/main.dart';
import 'package:machinetest_10042025/models/meeting_model.dart';
import 'package:machinetest_10042025/services/event_services.dart';
import 'package:machinetest_10042025/utils/date_formater.dart';

class EventProvider with ChangeNotifier {
  final EventService _eventService;
  List<Event> _events = [];
  DateTime _selectedDate = DateTime.now();
  DateTime _currentMonth = DateTime.now();
  bool _isLoading = false;

  EventProvider({required EventService eventService})
      : _eventService = eventService;

  List<Event> get events => _events;
  DateTime get selectedDate => _selectedDate;
  DateTime get currentMonth => _currentMonth;
  bool get isLoading => _isLoading;

  List<EventItems> items = [];

  bool hasEvents(DateTime date) {
    return _events.any(
        (event) => event.dateOnly == DateTime(date.year, date.month, date.day));
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    clearEventItems();

    for (var event in _events) {
      if (FormatDatedmyy(event.date) == FormatDatedmyy(_selectedDate)) {
        items.addAll(event.items);
      }
    }

    notifyListeners();
  }

  Future<void> setCurrentMonth(DateTime month) async {
    clearEventItems();
    _currentMonth = month;
    await _fetchEventsForMonth();
  }

  Future<void> _fetchEventsForMonth() async {
    MeetingModel? _meetingModel;
    _isLoading = true;
    notifyListeners();
    _events.clear();
    try {
      _meetingModel = await _eventService.fetchEventsForMonth(_currentMonth);
      if (_meetingModel != null) {
        _events.addAll(_meetingModel.data);
      } else {
        _events = [];
      }
    } catch (e) {
      ScaffoldMessenger.of(
        Get.context!,
      ).showSnackBar(
        SnackBar(
          content: Text('${e}'),
        ),
      );
      _events = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> initialize() async {
    await _fetchEventsForMonth();
  }

  clearEventItems() {
    items.clear();
    notifyListeners();
  }
}
