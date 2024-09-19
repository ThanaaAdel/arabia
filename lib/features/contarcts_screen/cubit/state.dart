abstract class ContractsState {}

class MainInitial extends ContractsState {}

class ChangeStatusOfSelectedIndexOrder extends ContractsState {}
class GetContractsLoadingState extends ContractsState {}
class GetContractsErrorState extends ContractsState {
  final String error;

  GetContractsErrorState(this.error);
}
class GetContractsLoadedState extends ContractsState {}
class ArchiveContractLoadingState extends ContractsState {}
class ArchiveContractErrorState extends ContractsState {}
class ArchiveContractSuccessState extends ContractsState {}

