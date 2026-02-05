import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scand_test_app/core/models/models.dart';
import 'package:scand_test_app/core/states/charging_state.dart';
import 'package:scand_test_app/core/widgets/app_container.dart';
import 'package:scand_test_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:scand_test_app/features/dashboard/bloc/dashboard_state.dart';
import 'package:scand_test_app/features/details/details_screen.dart';

import 'bloc/dashboard_events.dart';

class DashboardForm extends StatelessWidget {
  const DashboardForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DashboardBloc>();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Miashok SC& Test App'),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 16,
          children: [
            BlocSelector<DashboardBloc, DashboardState, bool>(
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
            BlocSelector<DashboardBloc, DashboardState, bool>(
              selector: (state) => state.monitoringEnabled,
              builder: (context, monitoringEnabled) {
                if (monitoringEnabled) return const SizedBox.shrink();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Update Frequency (in seconds)', style: TextStyle(fontSize: 18)),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: SizedBox(
                        width: 24,
                        height: 30,
                        child: TextField(
                          controller: TextEditingController(text: '5'),
                          keyboardType: TextInputType.number,
                          maxLength: 2,
                          cursorColor: Colors.black,
                          cursorHeight: 15,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              bloc.add(UpdateIntervalChanged(Duration(seconds: int.parse(value))));
                            } else {
                              bloc.add(UpdateIntervalChanged(Duration(seconds: 5)));
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 4,
                children: [
                  BlocSelector<DashboardBloc, DashboardState, DeviceInfo>(
                    selector: (state) => state.device,
                    builder: (context, device) {
                      return AppContainer(
                        child: Center(
                          child: Text(
                            '${device.deviceVendor.toUpperCase()} ${device.deviceModel}\n OS - ${device.osName} ${device.osVersion}',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      );
                    },
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const DetailsScreen(dataType: 'battery')),
                      );
                    },
                    child: AppContainer(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocSelector<DashboardBloc, DashboardState, int>(
                            selector: (state) => state.battery.chargePercent,
                            builder: (context, chargePercent) {
                              return Text(
                                chargePercent.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 24),
                              );
                            },
                          ),
                          BlocSelector<DashboardBloc, DashboardState, ChargingState>(
                            selector: (state) => state.battery.chargingState,
                            builder: (context, chargingState) {
                              return Text(
                                chargingState.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 24),
                              );
                            },
                          ),
                          BlocSelector<DashboardBloc, DashboardState, bool>(
                            selector: (state) => state.isPowerSavingEnabled,
                            builder: (context, isPowerSavingEnabled) {
                              return Text(
                                isPowerSavingEnabled ? 'PS Enabled' : 'PS Disabled',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 24),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocSelector<DashboardBloc, DashboardState, NetworkInfo>(
                    selector: (state) => state.network,
                    builder: (context, network) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const DetailsScreen(dataType: 'network'),
                            ),
                          );
                        },
                        child: AppContainer(
                          child: Center(
                            child: Text(
                              '${network.isOnline ? 'Online' : 'Offline'}\n${network.type.title}',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  BlocSelector<DashboardBloc, DashboardState, BluetoothInfo>(
                    selector: (state) => state.bluetooth,
                    builder: (context, bluetooth) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const DetailsScreen(dataType: 'bluetooth'),
                            ),
                          );
                        },
                        child: AppContainer(
                          child: Center(
                            child: Text(
                              bluetooth.state.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
