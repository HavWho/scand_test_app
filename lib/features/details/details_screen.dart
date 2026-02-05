import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scand_test_app/data/platform/device_platform_service_impl.dart';
import 'package:scand_test_app/features/details/bloc/details_bloc.dart';
import 'package:scand_test_app/features/details/bloc/details_events.dart';
import 'package:scand_test_app/features/details/details_form.dart';

class DetailsScreen extends StatelessWidget {
  final String dataType;

  const DetailsScreen({super.key, required this.dataType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailsBloc(dataType: dataType, service: DevicePlatformServiceImpl())..add(DetailsInit()),
      child: DetailsForm(),
    );
  }
}
