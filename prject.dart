int memoryMaxSize = 2;
int mamorySize = 0;
List<FRAME> memory = [];
List<FRAME> disk = [];
List<PROCESS> processes = [];

class VAR {
  int size = 0;
  int page = 0;
  int pageOffset = 0;
  String name = "";
}


class PAGE {
  int number = 0;
  int size = 0;
}

