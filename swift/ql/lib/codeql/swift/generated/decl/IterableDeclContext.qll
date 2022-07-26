// generated by codegen/codegen.py
private import codeql.swift.generated.IpaTypes
private import codeql.swift.generated.Db
import codeql.swift.elements.decl.Decl
import codeql.swift.elements.Element

class IterableDeclContextBase extends Ipa::TIterableDeclContext, Element {
  Decl getImmediateMember(int index) {
    result = Ipa::fromDbInstance(Ipa::toDbInstance(this).(Db::IterableDeclContext).getMember(index))
  }

  final Decl getMember(int index) { result = getImmediateMember(index).resolve() }

  final Decl getAMember() { result = getMember(_) }

  final int getNumberOfMembers() { result = count(getAMember()) }
}
