// generated by codegen/codegen.py
private import codeql.swift.generated.IpaTypes
private import codeql.swift.generated.Db
import codeql.swift.elements.expr.Expr

class AssignExprBase extends Ipa::TAssignExpr, Expr {
  override string getAPrimaryQlClass() { result = "AssignExpr" }

  Expr getImmediateDest() {
    result = Ipa::fromDbInstance(Ipa::toDbInstance(this).(Db::AssignExpr).getDest())
  }

  final Expr getDest() { result = getImmediateDest().resolve() }

  Expr getImmediateSource() {
    result = Ipa::fromDbInstance(Ipa::toDbInstance(this).(Db::AssignExpr).getSource())
  }

  final Expr getSource() { result = getImmediateSource().resolve() }
}
