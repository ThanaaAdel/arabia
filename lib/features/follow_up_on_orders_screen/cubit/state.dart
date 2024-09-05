abstract class FollowUpOnOrdersState {}

class MainInitial extends FollowUpOnOrdersState {}

class LoadedGetUserData extends FollowUpOnOrdersState {}

class LoadingGetUserData extends FollowUpOnOrdersState {}

class LoadedGetNewOrderState extends FollowUpOnOrdersState {}

class ErrorGetNewOrderState extends FollowUpOnOrdersState {}

class LoadingGetNewOrderState extends FollowUpOnOrdersState {}

class ChangeStatusOfSelectedIndexOrder extends FollowUpOnOrdersState {}

class LoadingGetCurrentOrderState extends FollowUpOnOrdersState {}

class LoadedGetCurrentOrderState extends FollowUpOnOrdersState {}

class LoadingSendToken extends FollowUpOnOrdersState {}

class ErrorSendToken extends FollowUpOnOrdersState {}

class LoadedSendToken extends FollowUpOnOrdersState {}
