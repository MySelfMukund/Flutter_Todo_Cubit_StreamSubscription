// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_activecount_cubit.dart';

class TodoActivecountState extends Equatable {
  final int activeCount;

  const TodoActivecountState({
    required this.activeCount,
  });

  factory TodoActivecountState.initial() {
    return TodoActivecountState(activeCount: 0);
  }

  @override
  String toString() => 'TodoActivecountState(activeCount: $activeCount)';

  TodoActivecountState copyWith({
    int? activeCount,
  }) {
    return TodoActivecountState(
      activeCount: activeCount ?? this.activeCount,
    );
  }

  @override
  List<Object?> get props => [activeCount];
}
