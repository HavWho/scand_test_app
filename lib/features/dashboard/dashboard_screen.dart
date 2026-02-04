import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scand_test_app/data/platform/device_platform_service_impl.dart';
import 'package:scand_test_app/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:scand_test_app/features/dashboard/dashboard_form.dart';

import 'bloc/dashboard_events.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(service: DevicePlatformServiceImpl())..add(DashboardInit()),
      child: DashboardForm(),
    );
  }
}
