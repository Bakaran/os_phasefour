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

class PROCESS {
  int processSize = 0;
  int pageSize = 400;
  String processName = "";
  List<VAR> vars = [];
  List<PAGE> pageTable = [];

  PROCESS(String processName) {
    this.processName = processName;
    this.pageTable.add(PAGE());
  }

  void addVAR(String varName, int size) {
    VAR Var = VAR();
    Var.name = varName;
    Var.size = size;

    PAGE last = pageTable.last;
    if (last.size + Var.size > pageSize) {
      PAGE tmp = PAGE();
      tmp.number = last.number + 1;
      tmp.size = 0;
      pageTable.add(tmp);
      last = pageTable.last;
    }

    Var.page = last.number;
    Var.pageOffset = last.size;
    last.size += Var.size;
    vars.add(Var);
    processSize += Var.size;
  }
}

class FRAME {
  String name = "";
  int frameSize = 400;
}

void addProcess(PROCESS p) {
  processes.add(p);
  for (int i = 0; i <= (p.processSize / p.pageSize); i++) {
    FRAME frame = FRAME();
    frame.name = p.processName + "$i";
    if (memory.length == memoryMaxSize) {
      disk.add(frame);
    } else {
      memory.add(frame);
    }
  }
}

