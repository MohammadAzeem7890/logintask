abstract class ListDetailsState {}

class GetListDetailsInitial extends ListDetailsState {
}


class ListDetailsLoading extends ListDetailsState {
}

class AddListDetailsSuccess extends ListDetailsState {
}

class AddListDetailsFailure extends ListDetailsState {
  final String message;
  AddListDetailsFailure(this.message);
}

class DeleteListDetailsLoading extends ListDetailsState {

}


class DeleteListDetailsSuccess extends ListDetailsState {

}


class DeleteListDetailsFailed extends ListDetailsState {

}

class UpdateListDetailsLoading extends ListDetailsState {
}

class UpdateListDetailsSuccess extends ListDetailsState {
}

class UpdateListDetailsFailure extends ListDetailsState {

}

class DeleteListDetailsFailure extends ListDetailsState {
  final String message;
  DeleteListDetailsFailure(this.message);
}