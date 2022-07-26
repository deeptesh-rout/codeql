// generated by codegen/codegen.py
private import codeql.swift.generated.IpaTypes
private import codeql.swift.generated.Db
import codeql.swift.elements.decl.ParamDecl
import codeql.swift.elements.decl.ValueDecl

class EnumElementDeclBase extends Ipa::TEnumElementDecl, ValueDecl {
  override string getAPrimaryQlClass() { result = "EnumElementDecl" }

  string getName() { result = Ipa::toDbInstance(this).(Db::EnumElementDecl).getName() }

  ParamDecl getImmediateParam(int index) {
    result = Ipa::fromDbInstance(Ipa::toDbInstance(this).(Db::EnumElementDecl).getParam(index))
  }

  final ParamDecl getParam(int index) { result = getImmediateParam(index).resolve() }

  final ParamDecl getAParam() { result = getParam(_) }

  final int getNumberOfParams() { result = count(getAParam()) }
}
