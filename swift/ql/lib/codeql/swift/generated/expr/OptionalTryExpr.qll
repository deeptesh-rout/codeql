// generated by codegen/codegen.py
private import codeql.swift.generated.IpaTypes
private import codeql.swift.generated.Db
import codeql.swift.elements.expr.AnyTryExpr

class OptionalTryExprBase extends Ipa::TOptionalTryExpr, AnyTryExpr {
  override string getAPrimaryQlClass() { result = "OptionalTryExpr" }
}
