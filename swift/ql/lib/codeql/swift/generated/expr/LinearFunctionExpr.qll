// generated by codegen/codegen.py
private import codeql.swift.generated.IpaTypes
private import codeql.swift.generated.Db
import codeql.swift.elements.expr.ImplicitConversionExpr

class LinearFunctionExprBase extends Ipa::TLinearFunctionExpr, ImplicitConversionExpr {
  override string getAPrimaryQlClass() { result = "LinearFunctionExpr" }
}
