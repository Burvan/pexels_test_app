abstract interface class UseCase<Input, OutPut> {
  Future<OutPut> execute (Input input);
}

abstract interface class FutureUseCase<OutPut, Input> {
  Future<OutPut> execute (Input input);
}

class NoParams {
  const NoParams();
}

