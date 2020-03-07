import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_application/bloc/bloc.dart';
import 'package:small_application/widgets/item_tile.dart';

startCarScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (BuildContext context) => _CarScreen(),
  ));
}

class _CarScreen extends StatefulWidget {
  @override
  _CarScreenState createState() => _CarScreenState();
}

class _CarScreenState extends State<_CarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 24,
          ),
          onPressed: () => Navigator.pop(context),
        ),
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
