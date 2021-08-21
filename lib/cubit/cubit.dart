import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/states.dart';
import 'package:news/modules/businessScreen.dart';
import 'package:news/modules/scienceScreen.dart';
import 'package:news/modules/sportsScreen.dart';
import 'package:news/remoteNetwork/cacheHelper.dart';
import 'package:news/remoteNetwork/dioHelper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(InitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0 ;
  void changeIndex (index) {
      currentIndex = index;
      emit(BottomNavState());
      if(currentIndex == 0)
        getBusinessNews();
      else if(currentIndex == 1)
        getSportsNews();
      else if (currentIndex == 2)
        getScienceNews();
  }

  List<Widget> screens =
  [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen()
  ];
  List<String> title =
  [
    'Business News',
    'Sports News',
    'Science News'
  ];
  List<BottomNavigationBarItem> bottomNavItems =
  [
    BottomNavigationBarItem(
        icon:Icon(Icons.business_center_outlined) ,
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon:Icon(Icons.sports_soccer_outlined) ,
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon:Icon(Icons.science_outlined),
      label: 'Science',
    ),
  ];
  List<dynamic> ?business = [];

  void getBusinessNews() {
    emit(LoadingBusinessData());
    if(business!.length ==0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '2f50ecb4b25e46c0a9a90f0e38413e1b'

      }).then((value) {
        print(value.data['articles'][1]['title']);
        business = value.data['articles'];
        emit(GetBusinessDataSuccess());
      }).catchError((error) {
        emit(GetBusinessDataError());
        print(error.toString());
      });
    }
    else
      emit(GetBusinessDataSuccess());
  }

  List<dynamic> ?sports = [];
  void getSportsNews() {
    emit(LoadingSportsData());
    if (sports!.length==0) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '2f50ecb4b25e46c0a9a90f0e38413e1b'
      }).then((value) {
        print(value.data['articles'][1]['title']);
        sports = value.data['articles'];
        emit(GetSportsDataSuccess());
      }).catchError((error) {
        emit(GetSportsDataError());
        print(error.toString());
      });
    }
    else
      emit(GetSportsDataSuccess());
  }

  List<dynamic> ?science = [];
  void getScienceNews() {
    emit(LoadingScienceData());
    if(science!.length == 0) {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
        'country': 'eg',
        'category': 'science',
        'apiKey': '2f50ecb4b25e46c0a9a90f0e38413e1b'
          }).then((value) {
        print(value.data['articles'][1]['title']);
        science = value.data['articles'];
        emit(GetScienceDataSuccess());
      }).catchError((error) {
        emit(GetScienceDataError());
        print(error.toString());
      });
    }
    else
      emit(GetScienceDataSuccess());
  }

  List<dynamic> ?search = [];
  void searchNews(String valuee) {
    emit(LoadingSearchData());
    DioHelper.getData(
        url: 'v2/everything',
        query: {
          'q':'$valuee',
          'from':'2021-07-02',
          'sortBy': 'publishedAt',
          'apiKey':'2f50ecb4b25e46c0a9a90f0e38413e1b'
        })
        .then((value)
    {
        search = value.data['articles'];
      emit(GetSearchDataSuccess());
    }
    ).catchError((error)
    {
      emit(GetSearchDataError());
      print(error.toString());
    }
    );
  }
  
  bool isDark = false;
  IconData? icon = Icons.brightness_4_outlined;
  ThemeMode appMode = ThemeMode.light;

  void changeMode({fromCache}) {
    if(fromCache == null)
      isDark =!isDark;
    else
      isDark = fromCache;
    CacheHelper.putBool(key: 'isDark', value: isDark).then((value) {
      if(isDark)
      {
        icon = Icons.brightness_7;
        appMode = ThemeMode.dark;
      }
      else
      {
        icon = Icons.brightness_4_outlined;
        appMode = ThemeMode.light;
      }

      emit(ChangeModeState());
    });

  }


}