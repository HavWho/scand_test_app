import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scand_test_app/core/widgets/app_container.dart';

import 'bloc/details_state.dart';
import 'bloc/details_bloc.dart';
import 'bloc/details_events.dart';
import 'utils/detail_event_entry.dart';

class DetailsForm extends StatelessWidget {
  const DetailsForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DetailsBloc>();
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        title: BlocSelector<DetailsBloc, DetailsState, String>(
          selector: (state) => state.dataType,
          builder: (context, dataType) {
            return Text(dataType.toUpperCase());
          },
        ),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 16,
          children: [
            BlocSelector<DetailsBloc, DetailsState, bool>(
              selector: (state) => state.monitoringEnabled,
              builder: (context, monitoringEnabled) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Monitoring ${monitoringEnabled ? 'Enabled' : 'Disabled'}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Switch(
                      value: monitoringEnabled,
                      activeThumbColor: Colors.cyan,
                      inactiveTrackColor: Colors.grey[50],
                      inactiveThumbColor: Colors.cyan,
                      trackOutlineColor: WidgetStatePropertyAll<Color>(Colors.cyan),
                      onChanged: (value) => bloc.add(MonitoringToggled(value)),
                    ),
                  ],
                );
              },
            ),
            BlocSelector<DetailsBloc, DetailsState, Map<String, dynamic>>(
              selector: (state) => {
                'monitoringEnabled': state.monitoringEnabled,
                'events': state.events,
              },
              builder: (context, data) {
                final monitoringEnabled = data['monitoringEnabled'] as bool;
                final events = data['events'] as List<DetailEventEntry>;

                if (!monitoringEnabled) {
                  return const Center(child: Text('Monitoring is disabled'));
                }

                if (events.isEmpty) {
                  return const Center(child: Text('No events yet'));
                }

                return Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final item = events[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: AppContainer(
                          child: ListTile(
                            leading: Icon(Icons.ac_unit_sharp, color: Colors.grey[50]),
                            title: Text(item.description, style: TextStyle(fontSize: 18)),
                            subtitle: Text(
                              item.timestamp.toLocal().toIso8601String(),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
