// generated by codegen/codegen.py
private import codeql.swift.generated.IpaTypes
private import codeql.swift.generated.Db
import codeql.swift.elements.type.AnyBuiltinIntegerType

class BuiltinIntegerLiteralTypeBase extends Ipa::TBuiltinIntegerLiteralType, AnyBuiltinIntegerType {
  override string getAPrimaryQlClass() { result = "BuiltinIntegerLiteralType" }
}
