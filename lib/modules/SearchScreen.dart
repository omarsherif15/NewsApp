import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';
import 'package:news/shared/components.dart';

class SearchScreen extends StatelessWidget {

 final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   NewsCubit cubit = NewsCubit.get(context);
    return BlocConsumer<NewsCubit,NewsStates>(
        listener: (context, state){},
        builder:(context, state) {
          var list =cubit.search;
          return Scaffold(
              appBar: AppBar(
                toolbarHeight: 60,
                titleSpacing: -20,
                title: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    height: 50,
                    width: 280,
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyText1,
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      decoration: InputDecoration(
                          hintText: 'Search',
                        prefixIcon: Icon(Icons.search,color: Colors.green,),
                          ),
                      onChanged: (value) {
                        cubit.searchNews(value);
                      },
                    ),
                  ),
                ),
              ),
              body: state is LoadingSearchData?
              Center(child: CircularProgressIndicator()):ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index) => articleItem(list![index],context),
                  separatorBuilder:(context,index) => separator(0, 10),
                  itemCount:cubit.search!.length
              ),
            );
            },

    );
  }
}
