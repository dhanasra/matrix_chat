import 'package:flutter/material.dart';
import 'package:instrive_chat/app/app_routes.dart';
import 'package:instrive_chat/config/matrix.dart';
import 'package:instrive_chat/utils/data_time_extension.dart';
import 'package:matrix/matrix.dart';

class RoomListItem extends StatelessWidget {
  final Room room;
  const RoomListItem({
    super.key,
    required this.room
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.of(context).pushNamed(Routes.chatPage, arguments: room.id);
      },
      leading: CircleAvatar(
        radius: 35,
        backgroundImage: room.avatar!=null ? NetworkImage(room.avatar!.path) : null,
        backgroundColor: Colors.amber,
        child: room.avatar==null ? Text(room.displayname.substring(0,1)) : null,
      ),
      title: Row(
        children: [
          Expanded(
              child: Text(
                room.displayname,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontSize: 18
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                room.timeCreated.localizedTimeShort(context),
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontSize: 18
                ),
              ),
            ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          room.lastEvent!.body,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
          maxLines: 1,
          softWrap: false,
        ),
      ),
    );  
  }
}