abstract class AppEvent {
  Object? arguments;

  AppEvent(this.arguments);
}

class Add extends AppEvent {
  Add({Object? arguments}) : super(arguments);
}
class Click extends AppEvent {
  Click({Object? arguments}) : super(arguments);
}
class Reset extends AppEvent {
  Reset({Object? arguments}) : super(arguments);
}

class Get extends AppEvent {
  Get({Object? arguments}) : super(arguments);
}

class Read extends AppEvent {
  Read({Object? arguments}) : super(arguments);
}


class PickLocation extends AppEvent {
  PickLocation({Object? arguments}) : super(arguments);
}

class PickImage extends AppEvent {
  PickImage({Object? arguments}) : super(arguments);
}

class Restart extends AppEvent {
  Restart({Object? arguments}) : super(arguments);
}

class Refresh extends AppEvent {
  Refresh({Object? arguments}) : super(arguments);
}

class Verfiy extends AppEvent {
  Verfiy({Object? arguments}) : super(arguments);
}

class Clear extends AppEvent {
  Clear({Object? arguments}) : super(arguments);
}

class Update extends AppEvent {
  Update({Object? arguments}) : super(arguments);
}

class Accept extends AppEvent {
  Accept({Object? arguments}) : super(arguments);
}

class Negotiate extends AppEvent {
  Negotiate({Object? arguments}) : super(arguments);
}
class RequestCode extends AppEvent {
  RequestCode({Object? arguments}) : super(arguments);
}

class Cancel extends AppEvent {
  Cancel({Object? arguments}) : super(arguments);
}

class Delete extends AppEvent {
  Delete({Object? arguments}) : super(arguments);
}

class ResendCode extends AppEvent {
  ResendCode({Object? arguments}) : super(arguments);
}

class ResendForgetCode extends AppEvent {
  ResendForgetCode({Object? arguments}) : super(arguments);
}

class VerifyRegisterCodeEvent extends AppEvent {
  VerifyRegisterCodeEvent({Object? arguments}) : super(arguments);
}

class VerifyForgetPasswordEvent extends AppEvent {
  VerifyForgetPasswordEvent({Object? arguments}) : super(arguments);
}

class LoadingState extends AppEvent {
  LoadingState({Object? arguments}) : super(arguments);
}