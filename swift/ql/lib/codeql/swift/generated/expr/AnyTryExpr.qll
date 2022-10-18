// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.Expr

module Generated {
  class AnyTryExpr extends Synth::TAnyTryExpr, Expr {
    /**
     * Gets the sub expr.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    Expr getImmediateSubExpr() {
      result =
        Synth::convertExprFromRaw(Synth::convertAnyTryExprToRaw(this).(Raw::AnyTryExpr).getSubExpr())
    }

    /**
     * Gets the sub expr.
     */
    final Expr getSubExpr() { result = getImmediateSubExpr().resolve() }
  }
}
