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
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: StadiumBorder(
          side: BorderSide(
            color: const Color(0xFFe7e7e7),
            width: 1.0,
          ),
        ),
        child: Dismissible(
          key: Key('${user.id}'),
          background: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(
                const Radius.circular(24.0),
              ),
              border: Border.all(
                color: const Color(0xFFe7e7e7),
              ),
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment(0.9, 0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          confirmDismiss: (_) async {
            ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
                controller;
            controller = Scaffold.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 1),
                content: Text('Really?'),
                action: SnackBarAction(
                  label: "No",
                  textColor: Colors.yellow,
                  onPressed: () => controller.close(),
                ),
              ),
            );
            final reason = await controller.closed;
            return reason == SnackBarClosedReason.timeout;
          },
          onDismissed: (direction) => onDeletePressed(user),
          child: Container(
            color: Colors.red,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(32.0),
              ),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      user.name,
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      type == TileType.car
                          ? 'Car : ${user.car}'
                          : 'Age : ${user.age}',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
