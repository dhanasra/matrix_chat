class RoomsViewModel {

  RoomsViewModel._internal();
  static final RoomsViewModel _roomsViewModel = RoomsViewModel._internal();
  factory RoomsViewModel(){
    return _roomsViewModel;
  } 


}