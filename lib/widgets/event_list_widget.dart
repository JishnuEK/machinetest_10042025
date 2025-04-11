// ignore_for_file: public_member_api_docs, sort_constructors_first
// lib/widgets/event_list.dart
import 'package:flutter/material.dart';
import 'package:machinetest_10042025/utils/date_formater.dart';
import 'package:provider/provider.dart';

import 'package:machinetest_10042025/models/meeting_model.dart';

import '../providers/event_provider.dart';

class EventList extends StatelessWidget {
  const EventList({super.key});

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    // final events = eventProvider.eventsOfSelectedDate;

    return Column(
      children: [
        if (eventProvider.items.isEmpty)
          const Text(
            'No events scheduled',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: eventProvider.items.length,
            itemBuilder: (context, index) {
              final event = eventProvider.items[index];
              return _EventCard(event: event, eventProvider: eventProvider);
            },
          ),
      ],
    );
  }
}

class _EventCard extends StatelessWidget {
  final EventItems event;
  final EventProvider eventProvider;
  const _EventCard({
    Key? key,
    required this.event,
    required this.eventProvider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color(0xff131925)),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    event.title,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  )),
                  Text(
                    event.time,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Divider(
                height: 1,
                thickness: 0.5,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      customFormatDatedmyy(eventProvider.selectedDate),
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                  ),
                  if (event.conflicted)
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                    ),
                ],
              ),
            ],
          )),
    );
  }
}
