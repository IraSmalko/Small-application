import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_application/bloc/bloc.dart';
import 'package:small_application/widgets/item_tile.dart';

import 'insert_user_screen.dart';

startCarScreen(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) => _CarScreen(),
    ),
  );
}

class _CarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car screen'),
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
                  type: TileType.car,
                  onDeletePressed: (user) {
                    DataBloc.of(context).add(Delete(user: user));
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
