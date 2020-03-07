import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_application/bloc/bloc.dart';
import 'package:small_application/widgets/item_tile.dart';

import 'car_screen.dart';

class AgeScreen extends StatefulWidget {
  @override
  _AgeScreenState createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.directions_car,
            size: 24,
          ),
          onPressed: () => startCarScreen(context),
        ),
        title: Text('Age screen'),
      ),
      body: BlocBuilder<DataBloc, DataState>(
        builder: (context, state) {
          if (state is Failure) {
            return Center(
              child: Text('Oops something went wrong!'),
            );
          }
          if (state is Loaded) {
            if (state.users.isEmpty) {
              return Center(
                child: Text('No content'),
              );
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ItemTile(
                  user: state.users[index],
                  type: TileType.age,
                  onDeletePressed: (user) {
                    BlocProvider.of<DataBloc>(context).add(Delete(user: user));
                  },
                );
              },
              itemCount: state.users.length,
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
