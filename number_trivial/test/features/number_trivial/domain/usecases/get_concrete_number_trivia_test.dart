import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivial/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {

}

void main() {
  GetConcreteNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp((){
      mockNumberTriviaRepository = MockNumberTriviaRepository();

      usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository) ;
  });
}