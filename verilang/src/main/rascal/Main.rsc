module Main

import IO;
import ParseTree;
import Syntax;

void main() {

    println("\n=== Probando test ===");
    str c1 = readFile(|project://verilang/instance/test_completo.vlg|);
    t1 = parse(#Module, c1);
    println(t1);
}