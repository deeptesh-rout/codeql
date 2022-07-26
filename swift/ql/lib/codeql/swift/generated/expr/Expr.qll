// generated by codegen/codegen.py
private import codeql.swift.generated.IpaTypes
private import codeql.swift.generated.Db
import codeql.swift.elements.AstNode
import codeql.swift.elements.type.Type

class ExprBase extends Ipa::TExpr, AstNode {
  Type getImmediateType() {
    result = Ipa::fromDbInstance(Ipa::toDbInstance(this).(Db::Expr).getType())
  }

  final Type getType() { result = getImmediateType().resolve() }

  final predicate hasType() { exists(getType()) }
}
