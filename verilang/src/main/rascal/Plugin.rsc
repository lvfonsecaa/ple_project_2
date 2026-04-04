module Plugin

import ParseTree;
import util::Reflective;
import util::LanguageServer;
import Syntax;

PathConfig pcfg = getProjectPathConfig(|project://verilang|);

set[LanguageService] contribs() = {
  parser(start[Module] (str program, loc src) {
    return parse(#start[Module], program, src);
  })
};

void main() {
  registerLanguage(language(pcfg, "verilang", {"vlg"}, "Plugin", "contribs"));
}
