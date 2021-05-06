import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/modules/search/search_screen.dart';
import 'package:new_app/network/remote/dio_helper.dart';
import 'package:new_app/shared/cubit.dart';
import 'package:new_app/shared/states.dart';
import 'package:new_app/shared/widgets/components.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            body: cubit.screens[cubit.currentIndex],
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                  ),
                  onPressed: () {
                    navigateTo(
                      context,
                      SearchScreen(),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.brightness_4_outlined,
                  ),
                  onPressed: () {
                    cubit.changeAppMode();
                  },
                ),
              ],
              title: (Text(
                'News App',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                AppCubit.get(context).changeBottomIndex(index);
                print(cubit.currentIndex);
              },
              items: cubit.bottomItems,
            ),
          );
        });
  }
}