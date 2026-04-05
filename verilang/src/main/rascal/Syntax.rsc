module Syntax

layout Layout = WS* !>> [\ \t\n\r#];

lexical WS
  = [\ \t\n\r]
  | @category="Comment" "#" ![\n]* $;


start syntax Module
  = moduleDef: "defmodule" Identifier ImportList ModuleBody "end";

syntax ImportList = importDef: Import*;

syntax Import = importDef: "using" Identifier;

syntax ModuleBody = moduleBodyDef: Definition*;

syntax Definition
  = defSpace: SpaceDef
  | defOperator: OperatorDef
  | defVar: VarDef
  | defRule: RuleDef
  | defExpression: ExpressionDef;

syntax SpaceDef
  = spaceDefDef: "defspace" Identifier ("\<" Identifier)? "end";

syntax OperatorDef = operatorDefDef: "defoperator" Identifier ":" OperatorSignature AttributeList? "end";

syntax OperatorSignature = operatorSignatureDef: Identifier ("-\>" Identifier)*;

syntax AttributeList = attributeListDef : "[" Attribute+ "]";

syntax Attribute
  = attrName: Identifier
  | attrPair: Identifier ":" Identifier;

syntax VarDef = varDefDef : "defvar" VarList "end";

syntax VarList = varListDef : VarDecl ("," VarDecl)* ;

syntax VarDecl = varDeclDef : Identifier ":" Identifier;

syntax RuleDef = ruleDefDef : "defrule" OperatorApplication "-\>" OperatorApplication "end";

syntax OperatorApplication
  = prefixOpApp: PrefixApplication
  | infixOpApp: InfixApplication;

syntax PrefixApplication = prefixApplicationDef : "(" Identifier ArgumentList ")";

syntax ArgumentList = argumentListDef : Expression+;

syntax InfixApplication = infixApplicationDef : SimpleTerm InfixOperator SimpleTerm;

syntax SimpleTerm
  = simpleIdentifier: Identifier
  | groupedSimpleTerm: "(" Expression ")"; 

syntax InfixOperator = infixOperatorDef : Identifier|"in";

syntax ExpressionDef = expressionDefDef : "defexpression" Expression "end";

syntax Expression
  = quantifiedExpr: QuantifiedExpression
  | equivalenceExpr: EquivalenceExpression;

syntax EquivalenceExpression
  = implicationOnly: ImplicationExpression
  | equivalenceChain: ImplicationExpression "===" EquivalenceExpression;

syntax ImplicationExpression
  = orOnly: OrExpression
  | implicationChain: OrExpression "=\>" ImplicationExpression;

syntax OrExpression
  = andOnly: AndExpression
  | orChain: AndExpression "or" OrExpression;

syntax AndExpression
  = comparisonOnly: ComparisonExpression
  | andChain: ComparisonExpression "and" AndExpression;

syntax ComparisonExpression
  = primaryOnly: PrimaryExpression
  | comparisonExpr: PrimaryExpression ComparisonOp PrimaryExpression;

syntax PrimaryExpression
  = operatorPrimary: OperatorApplication
  | identifierPrimary: Identifier
  | groupedPrimary: "(" Expression ")";

syntax ComparisonOp = eq:"="|lt:"\<"|gt:"\>"|le:"\<="|ge:"\>="|ne:"\<\>";

syntax QuantifiedExpression = quantifiedExpressionDe : Quantifier Identifier "in" Identifier "." Expression;

syntax Quantifier
  = forallQ: "forall"
  | existsQ: "exists";

syntax IntLiteral = intLiteral : Number Number*;

syntax FloatLiteral = floatLiteralDef : Number Number* "." Number Number*;

lexical Number = [0-9];

lexical CharLiteral = [a-z];

lexical Identifier = CharLiteral (CharLiteral|Number|"-")*;
