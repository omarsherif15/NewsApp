import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';
import 'package:news/remoteNetwork/cacheHelper.dart';
import 'package:news/remoteNetwork/dioHelper.dart';
import 'package:news/shared/bloc_observer.dart';
import 'package:news/shared/themes.dart';
import 'layout/newsLayout.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool ?isDark = CacheHelper.getBool(key: 'isDark');

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp(this.isDark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context) => NewsCubit()..getBusinessNews()..changeMode(fromCache: isDark),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener:(context,state){} ,
        builder: (context,state) {
          NewsCubit cubit = NewsCubit.get(context);
          return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: NewsLayout(),
          theme: lightMode(),
          darkTheme: darkMode(),
          themeMode: cubit.appMode
        );
        },
      )
    );
  }
}

