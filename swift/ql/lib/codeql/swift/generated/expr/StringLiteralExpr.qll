// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.BuiltinLiteralExpr

module Generated {
  class StringLiteralExpr extends Synth::TStringLiteralExpr, BuiltinLiteralExpr {
    override string getAPrimaryQlClass() { result = "StringLiteralExpr" }

    /**
     * Gets the value.
     */
    string getValue() {
      result = Synth::convertStringLiteralExprToRaw(this).(Raw::StringLiteralExpr).getValue()
    }
  }
}
