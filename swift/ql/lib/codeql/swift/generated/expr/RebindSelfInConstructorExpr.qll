// generated by codegen/codegen.py
private import codeql.swift.generated.IpaTypes
private import codeql.swift.generated.Db
import codeql.swift.elements.expr.Expr
import codeql.swift.elements.decl.VarDecl

class RebindSelfInConstructorExprBase extends Ipa::TRebindSelfInConstructorExpr, Expr {
  override string getAPrimaryQlClass() { result = "RebindSelfInConstructorExpr" }

  Expr getImmediateSubExpr() {
    result =
      Ipa::fromDbInstance(Ipa::toDbInstance(this).(Db::RebindSelfInConstructorExpr).getSubExpr())
  }

  final Expr getSubExpr() { result = getImmediateSubExpr().resolve() }

  VarDecl getImmediateSelf() {
    result =
      Ipa::fromDbInstance(Ipa::toDbInstance(this).(Db::RebindSelfInConstructorExpr).getSelf())
  }

  final VarDecl getSelf() { result = getImmediateSelf().resolve() }
}
