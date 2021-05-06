import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/modules/business/business_screen.dart';
import 'package:new_app/modules/science/science_screen.dart';
import 'package:new_app/modules/sports/sports_screen.dart';
import 'package:new_app/network/local/cache_helper.dart';
import 'package:new_app/network/remote/dio_helper.dart';
import 'package:new_app/shared/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
        label: 'Business'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports,
        ),
        label: 'Sports'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science,
        ),
        label: 'Science'),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  List<String> titles = [
    'Business',
    'Sports',
    'Science',
    'Settings',
  ];

  void changeBottomIndex(int index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getScience();
    emit(AppChangeBottomNavAppBarState());
  }

  List<dynamic>? business = [];

  void getBusiness() {
    emit(AppGetBusinessLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '8a76595cc7b8493995e6899fc42f0c54',
      },
    ).then((value) {
      // print(value.data['totalResults'].toString());
      business = value.data['articles'];
      print(business![0]['title']);

      emit(AppGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic>? sports = [];

  void getSports() {
    emit(AppGetSportsLoadingState());

    if (sports!.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '8a76595cc7b8493995e6899fc42f0c54',
        },
      ).then((value) {
        // print(value.data['totalResults'].toString());
        sports = value.data['articles'];
        print(sports![0]['title']);

        emit(AppGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(AppGetSportsErrorState(error.toString()));
      });
    } else {
      emit(AppGetSportsSuccessState());
    }
  }

  List<dynamic>? science = [];

  void getScience() {
    emit(AppGetScienceLoadingState());

    if (science!.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '8a76595cc7b8493995e6899fc42f0c54',
        },
      ).then((value) {
        // print(value.data['totalResults'].toString());
        science = value.data['articles'];
        print(science![0]['title']);

        emit(AppGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(AppGetScienceErrorState(error.toString()));
      });
    } else {
      emit(AppGetScienceSuccessState());
    }
  }

  List<dynamic>? search = [];

  void getSearch(String value) {
    emit(AppGetSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '8a76595cc7b8493995e6899fc42f0c54',
      },
    ).then((value) {
      // print(value.data['totalResults'].toString());
      search = value.data['articles'];
      print(search![0]['title']);

      emit(AppGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetSearchErrorState(error.toString()));
    });
  }

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}