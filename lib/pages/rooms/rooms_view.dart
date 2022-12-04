import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instrive_chat/bloc/room/room_bloc.dart';
import 'package:instrive_chat/config/matrix.dart';
import 'package:instrive_chat/widgets/room_list_item.dart';
import 'package:matrix/matrix.dart';

class RoomsView extends StatefulWidget {
  const RoomsView({super.key});

  @override
  State<RoomsView> createState() => _RoomsViewState();
}

class _RoomsViewState extends State<RoomsView> {

  @override
  void initState() {
    context.read<RoomBloc>().add(GetChatRooms());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                hintText: "Search chats ...",
                prefixIcon: const Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(8)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(8)
                ),
              ),
            )),
            const SizedBox(width: 16,),
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.amber,
              backgroundImage: AppMatrix.clientLogo!=null ? NetworkImage(AppMatrix.clientLogo!.path) : null,
            )
          ],
        ),
      ),
      body: Column(
            children: [
              BlocBuilder<RoomBloc, RoomState>(
                  buildWhen: (_, state)=> state is StoriesLoading || state is StoriesFetched,
                  builder: (_, state){
                    return StoriesBuilder(
                      loading: state is StoriesLoading,
                      rooms: state is StoriesFetched ? state.stories : [],
                    );
                  },
              ),
              Expanded(
                child: BlocBuilder<RoomBloc, RoomState>(
                  buildWhen: (_, state)=> state is RoomsLoading || state is ChatRoomsFetched,
                  builder: (_, state){
                    return RoomsBuilder(
                      loading: state is RoomsLoading,
                      rooms: state is ChatRoomsFetched ? state.rooms : [],
                    );
                  },
                )
              )
            ],
          ),
    );
  }
}


class StoriesBuilder extends StatelessWidget {
  final List<Room>? rooms;
  final bool loading;

  const StoriesBuilder({
    super.key,
    this.rooms,
    required this.loading
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: loading ? 3 : rooms!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_ ,index){
          return loading 
            ? const CircularProgressIndicator()
            : CircleAvatar(
                radius: 32,
                child: Text(rooms![index].name.substring(0,2)),
              );
        },
        separatorBuilder: (_, index){
          return const Divider();
        }
      ),
    );
  }
}

class RoomsBuilder extends StatelessWidget {
  final List<Room>? rooms;
  final bool loading;

  const RoomsBuilder({
    super.key,
    this.rooms,
    required this.loading
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: loading ? 3 : rooms!.length,
      itemBuilder: (_ ,index){
        return loading 
          ? const CircularProgressIndicator()
          : RoomListItem(room: rooms![index]);
      },
      separatorBuilder: (_, index){
        return const Divider();
      }
    );
  }
}