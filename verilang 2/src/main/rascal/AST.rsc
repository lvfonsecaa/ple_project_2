module AST

//data Module
// = moduleDef(str name, list[Import] imports, list[Definition] definitions);

data Import
  = importDef(str name);
