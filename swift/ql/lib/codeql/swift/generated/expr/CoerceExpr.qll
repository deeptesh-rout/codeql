// generated by codegen/codegen.py
private import codeql.swift.generated.IpaTypes
private import codeql.swift.generated.Db
import codeql.swift.elements.expr.ExplicitCastExpr

class CoerceExprBase extends Ipa::TCoerceExpr, ExplicitCastExpr {
  override string getAPrimaryQlClass() { result = "CoerceExpr" }
}
