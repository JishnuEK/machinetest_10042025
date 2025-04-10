// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:machinetest_10042025/widgets/event_list_widget.dart';
import 'package:machinetest_10042025/widgets/home_button_widget.dart';
import 'package:machinetest_10042025/widgets/loader.dart';
import 'package:provider/provider.dart';
import '../providers/event_provider.dart';
import '../widgets/calendar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 16.0, right: 10, left: 10),
        child: _buildBody(context, eventProvider),
      )),
    );
  }

  Widget _buildBody(BuildContext context, EventProvider eventProvider) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              const HomeButtonWidget(),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Meeting List',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 20,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: const [
                    CalendarWidget(),
                    SizedBox(height: 20),
                    Divider(height: 1),
                    SizedBox(height: 15),
                    EventList(),
                  ],
                ),
              )
            ],
          ),
        ),
        if (eventProvider.isLoading)
          Center(child: CustomLoading.defaultLoading(context))
      ],
    );
  }
}
