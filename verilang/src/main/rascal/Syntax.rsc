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

syntax Definition = definitionDef: SpaceDef | OperatorDef | VarDef|RuleDef|ExpressionDef;

syntax SpaceDef = spaceDefDef: "defspace" Identifier ("<" Identifier)? "end";

syntax OperatorDef = operatorDefDef: "defoperator" Identifier ":" OperatorSignature (AttributeList)? "end";

syntax OperatorSignature = operatorSignatureDef: Type ("->" Type)*;

syntax Type = typeDef : Identifier;

syntax AttributeList = attributeListDef : "[" Attribute + "]";

syntax Attribute = attributeDef : Identifier | Identifier ":" Identifier;

syntax VarDef = varDefDef : "defvar" VarList "end";

syntax VarList = varListDef : VarDecl ("," VarDecl) * ;

syntax VarDecl = varDeclDef : Identifier ":" Type;

syntax RuleDef = ruleDefDef : "defrule" OperatorApplication "->" OperatorApplication "end";

syntax OperatorApplication = operatorApplicationDef : PrefixApplication | InfixApplication;

syntax PrefixApplication = prefixApplicationDef : "(" Identifier ArgumentList ")";

syntax ArgumentList = argumentListDef : Expression+;

syntax InfixApplication = infixApplicationDef : SimpleTerm InfixOperator SimpleTerm;

syntax SimpleTerm = simpleTermDef : Identifier | "(" Expression ")"; 

syntax InfixOperator = infixOperatorDef : Identifier|"in";

syntax ExpressionDef = expressionDefDef : "defexpression" Expression "end";

syntax Expression = expressionDef : QuantifiedExpression|EquivalenceExpression;

syntax EquivalenceExpression = equivalenceExpressionDef : ImplicationExpression|ImplicationExpression "=" EquivalenceExpression;

syntax ImplicationExpression = implicationExpressionDef : OrExpression|OrExpression "=>" ImplicationExpression;

syntax OrExpression = orExpressionDef : AndExpression|AndExpression "or" OrExpression;

syntax AndExpression = andExpressionDef : ComparisonExpression|ComparisonExpression "and" AndExpression;

syntax ComparisonExpression = comparisonExpressionDef : PrimaryExpression|PrimaryExpression ComparisonOp PrimaryExpression;

syntax PrimaryExpression = primaryExpressionDef : OperatorApplication|Identifier|"(" Expression ")";

syntax ComparisonOp = eq:"="| lt:"<"| gt:">"| le:"<="| ge:">="| ne:"<>";

syntax QuantifiedExpression = quantifiedExpressionDe : Quantifier Identifier "in" Type "." Expression;

syntax Quantifier = quantifierDef : "forall" | "exists";

syntax IntLiteral = intLiteral : Number Number*;

syntax FloatLiteral = floatLiteralDef : Number Number* "." Number Number*;

lexical Number = [0-9];

lexical CharLiteral = [a-z];

lexical Identifier = CharLiteral (CharLiteral | Number | "-")*;
