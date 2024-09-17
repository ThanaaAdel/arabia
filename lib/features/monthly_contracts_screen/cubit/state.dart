abstract class MonthlyContractsState {}

class MainInitial extends MonthlyContractsState {}

class GetMonthlyContractLoadingState extends MonthlyContractsState {}

class GetMonthlyContractSuccessState extends MonthlyContractsState {}

class GetMonthlyContractErrorState extends MonthlyContractsState {}

class ChangeStatusOfSelectedIndexOrder extends MonthlyContractsState {}
class GetMonthlyContractLoadingMoreState extends MonthlyContractsState {}
class ArchiveMonthlyContractSuccessState extends MonthlyContractsState {}
class ArchiveMonthlyContractErrorState extends MonthlyContractsState {}

class ArchiveMonthlyContractLoadingState extends MonthlyContractsState {}
