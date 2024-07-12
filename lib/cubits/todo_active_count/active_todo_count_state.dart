// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'active_todo_count_cubit.dart';

class ActiveTodoCountState extends Equatable {
  final int activeCount;

  const ActiveTodoCountState({
    required this.activeCount,
  });

  factory ActiveTodoCountState.initial() {
    return ActiveTodoCountState(activeCount: 0);
  }

  @override
  String toString() => 'TodoActivecountState(activeCount: $activeCount)';

  ActiveTodoCountState copyWith({
    int? activeCount,
  }) {
    return ActiveTodoCountState(
      activeCount: activeCount ?? this.activeCount,
    );
  }

  @override
  List<Object?> get props => [activeCount];
}
