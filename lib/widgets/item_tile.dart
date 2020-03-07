import 'package:flutter/material.dart';
import 'package:small_application/models/user.dart';

enum TileType { age, car }

class ItemTile extends StatelessWidget {
  final TileType type;
  final User user;
  final Function(User) onDeletePressed;

  const ItemTile({
    Key key,
    @required this.user,
    @required this.type,
    @required this.onDeletePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(user.name),
      title: Text(type == TileType.car ? user.car : '${user.age}'),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        onPressed: () => onDeletePressed(user),
      ),
    );
  }
}
