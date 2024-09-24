abstract class MediationState {}

class MainInitial extends MediationState {}

class GetMediationContractLoadingState extends MediationState {}

class GetMediationContractSuccessState extends MediationState {}

class GetMediationContractErrorState extends MediationState {}

class ChangeStatusOfSelectedIndexOrder extends MediationState {}
class GetMediationContractLoadingMoreState extends MediationState {}
class ArchiveMediationContractSuccessState extends MediationState {}
class ArchiveMediationContractErrorState extends MediationState {}

class ArchiveMediationContractLoadingState extends MediationState {}
