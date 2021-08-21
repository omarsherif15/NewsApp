import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';
import 'package:news/modules/SearchScreen.dart';
import 'package:news/shared/components.dart';

class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context,state){},
        builder: (context,state) {
          NewsCubit cubit = NewsCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                leading: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 15),
                  child: Icon(Icons.article_outlined,size:30,),
                ),
                leadingWidth: 45,
                title: Text(cubit.title[cubit.currentIndex],
                ),
                actions:
                [
                  IconButton(
                      onPressed: (){
                        navigateTo(context, SearchScreen());
                      },
                      icon: Icon(Icons.search)
                  ),
                  IconButton(
                      onPressed: () => cubit.changeMode(),
                      icon:Icon(cubit.icon),
                  )
                ],
              ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) => cubit.changeIndex(index),
              items: cubit.bottomNavItems,
            ),
            );
        });
  }
}
