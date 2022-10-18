// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.Expr
import codeql.swift.elements.expr.OpaqueValueExpr

module Generated {
  class MakeTemporarilyEscapableExpr extends Synth::TMakeTemporarilyEscapableExpr, Expr {
    override string getAPrimaryQlClass() { result = "MakeTemporarilyEscapableExpr" }

    /**
     * Gets the escaping closure.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    OpaqueValueExpr getImmediateEscapingClosure() {
      result =
        Synth::convertOpaqueValueExprFromRaw(Synth::convertMakeTemporarilyEscapableExprToRaw(this)
              .(Raw::MakeTemporarilyEscapableExpr)
              .getEscapingClosure())
    }

    /**
     * Gets the escaping closure.
     */
    final OpaqueValueExpr getEscapingClosure() { result = getImmediateEscapingClosure().resolve() }

    /**
     * Gets the nonescaping closure.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    Expr getImmediateNonescapingClosure() {
      result =
        Synth::convertExprFromRaw(Synth::convertMakeTemporarilyEscapableExprToRaw(this)
              .(Raw::MakeTemporarilyEscapableExpr)
              .getNonescapingClosure())
    }

    /**
     * Gets the nonescaping closure.
     */
    final Expr getNonescapingClosure() { result = getImmediateNonescapingClosure().resolve() }

    /**
     * Gets the sub expr.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    Expr getImmediateSubExpr() {
      result =
        Synth::convertExprFromRaw(Synth::convertMakeTemporarilyEscapableExprToRaw(this)
              .(Raw::MakeTemporarilyEscapableExpr)
              .getSubExpr())
    }

    /**
     * Gets the sub expr.
     */
    final Expr getSubExpr() { result = getImmediateSubExpr().resolve() }
  }
}
