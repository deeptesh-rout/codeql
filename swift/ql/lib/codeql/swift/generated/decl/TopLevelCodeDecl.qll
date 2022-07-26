// generated by codegen/codegen.py
private import codeql.swift.generated.IpaTypes
private import codeql.swift.generated.Db
import codeql.swift.elements.stmt.BraceStmt
import codeql.swift.elements.decl.Decl

class TopLevelCodeDeclBase extends Ipa::TTopLevelCodeDecl, Decl {
  override string getAPrimaryQlClass() { result = "TopLevelCodeDecl" }

  BraceStmt getImmediateBody() {
    result = Ipa::fromDbInstance(Ipa::toDbInstance(this).(Db::TopLevelCodeDecl).getBody())
  }

  final BraceStmt getBody() { result = getImmediateBody().resolve() }
}
