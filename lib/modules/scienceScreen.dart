import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';
import 'package:news/shared/components.dart';

class ScienceScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener:(context,state){},
        builder: (context,state) {
          NewsCubit cubit = NewsCubit.get(context);
          if(state is LoadingScienceData)
            return Center(child: CircularProgressIndicator());
          else
          {
            dynamic list = NewsCubit.get(context).science;
            return ListView.separated(
              physics: BouncingScrollPhysics(),
                itemBuilder: (context,index) => articleItem(list[index], context),
                separatorBuilder:(context,index) => SizedBox(height: 10,),
                itemCount:cubit.science!.length,

            );}
        }
    );
  }
}