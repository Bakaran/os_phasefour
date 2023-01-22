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

void requestVar(String varName) {
  PROCESS? p = null;
  VAR? pVar = null;

  for (var pr in processes) {
    for (var Var in pr.vars) {
      if (Var.name == varName) {
        p = pr;
        pVar = Var;
      }
    }
  }
  if (p == null || pVar == null) {
    print("Not Found");
    return;
  }
  print("Logical: Page ${pVar.page}");
  print("Offset ${pVar.pageOffset}");
  String? frameName = p.processName + "${pVar.page}";
  int frameNumber = 0;
  bool frameFound = false;
  for (var frame in memory) {
    if (frame.name == frameName) {
      frameFound = true;
      break;
    }
    frameNumber++;
  }
  if (!frameFound) {
    print("Fault");
    return;
  }
  print("Pysical: frame");
  print("${frameNumber} offset ${pVar.pageOffset}");
}
int main() {
  PROCESS pr = PROCESS("B");
  /*pr.addVAR("var1", 4);
  pr.addVAR("var2", 8);
  pr.addVAR("var3", 240);
  pr.addVAR("var4", 148);
  pr.addVAR("var5", 240);
  pr.addVAR("var6", 280);
  pr.addVAR("var7", 120);
  addProcess(pr);
  requestVar("var7");*/
  /*
  Logical: Page2
  Off 280
  Fault
  */

  pr.addVAR("var1", 4);
  pr.addVAR("var2", 8);
  pr.addVAR("var3", 240);
  pr.addVAR("var4", 148);
  pr.addVAR("var5", 300);
  addProcess(pr);
  requestVar("var2");
  return 0;
}