// generated by codegen/codegen.py
private import codeql.swift.generated.IpaTypes
private import codeql.swift.generated.Db
import codeql.swift.elements.expr.IdentityExpr

class ParenExprBase extends Ipa::TParenExpr, IdentityExpr {
  override string getAPrimaryQlClass() { result = "ParenExpr" }
}
