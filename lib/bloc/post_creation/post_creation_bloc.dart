import 'package:bloc/bloc.dart';
import 'package:instagram/bloc/post_creation/post_creation_event.dart';
import 'package:instagram/bloc/post_creation/post_creation_state.dart';
import 'package:instagram/data/repositories/post_repository.dart';
import 'package:meta/meta.dart';

class PostCreationBloc extends Bloc<PostCreationEvent, PostCreationState> {
  final PostRepository repository;

  PostCreationBloc({@required this.repository});

  @override
  PostCreationState get initialState => PostCreationInitialState();

  @override
  Stream<PostCreationState> mapEventToState(PostCreationEvent event) async* {
    if (event is FetchAddPostEvent) {
      yield PostCreationLoadingState();
      try {
        await repository.addPost(
          comment: event.comment,
          file: event.file,
        );
        yield PostCreationLoadedState();
      } catch (error) {
        yield PostCreationErrorState(message: 'Data loading failed. Please try again.');
      }
    }
  }
}
