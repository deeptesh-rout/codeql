// generated by codegen/codegen.py
private import codeql.swift.generated.IpaTypes
private import codeql.swift.generated.Db
import codeql.swift.elements.expr.ImplicitConversionExpr

class DestructureTupleExprBase extends Ipa::TDestructureTupleExpr, ImplicitConversionExpr {
  override string getAPrimaryQlClass() { result = "DestructureTupleExpr" }
}
