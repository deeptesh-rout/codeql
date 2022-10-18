// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.ApplyExpr
import codeql.swift.elements.expr.Expr

module Generated {
  class SelfApplyExpr extends Synth::TSelfApplyExpr, ApplyExpr {
    /**
     * Gets the base.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    Expr getImmediateBase() {
      result =
        Synth::convertExprFromRaw(Synth::convertSelfApplyExprToRaw(this)
              .(Raw::SelfApplyExpr)
              .getBase())
    }

    /**
     * Gets the base.
     */
    final Expr getBase() { result = getImmediateBase().resolve() }
  }
}
