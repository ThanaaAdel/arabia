abstract class HourlyContractsState {}

class MainInitial extends HourlyContractsState {}

class GetHourlyContractLoadingState extends HourlyContractsState {}

class GetHourlyContractSuccessState extends HourlyContractsState {}

class GetHourlyContractErrorState extends HourlyContractsState {}

class ChangeStatusOfSelectedIndexOrder extends HourlyContractsState {}
class GetHourlyContractLoadingMoreState extends HourlyContractsState {}
class ArchiveHourlyContractSuccessState extends HourlyContractsState {}
class ArchiveHourlyContractErrorState extends HourlyContractsState {}

class ArchiveHourlyContractLoadingState extends HourlyContractsState {}
