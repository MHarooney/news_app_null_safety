import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/shared/cubit.dart';
import 'package:new_app/shared/states.dart';
import 'package:new_app/shared/widgets/components.dart';

class ScienceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, AppStates state) {},
      builder: (context, state) {
        var list = AppCubit.get(context).science!;
        return articleBuilder(
          list,
          context,
        );
      },
    );
  }
}