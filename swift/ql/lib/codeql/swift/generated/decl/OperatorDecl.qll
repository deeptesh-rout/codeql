// generated by codegen/codegen.py
private import codeql.swift.generated.IpaTypes
private import codeql.swift.generated.Db
import codeql.swift.elements.decl.Decl

class OperatorDeclBase extends Ipa::TOperatorDecl, Decl {
  string getName() { result = Ipa::toDbInstance(this).(Db::OperatorDecl).getName() }
}
