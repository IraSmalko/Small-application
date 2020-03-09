import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_application/bloc/data_bloc.dart';
import 'package:small_application/widgets/item_tile.dart';

import 'car_screen.dart';
import 'insert_user_screen.dart';

class AgeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.directions_car,
              size: 24,
            ),
            onPressed: () => startCarScreen(context),
          )
        ],
        title: Text('Age'),
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
              padding: const EdgeInsets.all(16.0),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return ItemTile(
                  user: state.users[index],
                  type: TileType.age,
                  onDeletePressed: (user) {
                    DataBloc.of(context).add(Delete(user: user));
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("${user.name} deleted")));
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => startInsertUserScreen(context),
      ),
    );
  }
}
