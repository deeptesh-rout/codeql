// generated by codegen/codegen.py
private import codeql.swift.generated.IpaTypes
private import codeql.swift.generated.Db
import codeql.swift.elements.expr.Expr

class OptionalEvaluationExprBase extends Ipa::TOptionalEvaluationExpr, Expr {
  override string getAPrimaryQlClass() { result = "OptionalEvaluationExpr" }

  Expr getImmediateSubExpr() {
    result = Ipa::fromDbInstance(Ipa::toDbInstance(this).(Db::OptionalEvaluationExpr).getSubExpr())
  }

  final Expr getSubExpr() { result = getImmediateSubExpr().resolve() }
}
