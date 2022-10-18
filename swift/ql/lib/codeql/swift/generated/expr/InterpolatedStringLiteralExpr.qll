// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.Expr
import codeql.swift.elements.expr.LiteralExpr
import codeql.swift.elements.expr.OpaqueValueExpr
import codeql.swift.elements.expr.TapExpr

module Generated {
  class InterpolatedStringLiteralExpr extends Synth::TInterpolatedStringLiteralExpr, LiteralExpr {
    override string getAPrimaryQlClass() { result = "InterpolatedStringLiteralExpr" }

    /**
     * Gets the interpolation expr, if it exists.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    OpaqueValueExpr getImmediateInterpolationExpr() {
      result =
        Synth::convertOpaqueValueExprFromRaw(Synth::convertInterpolatedStringLiteralExprToRaw(this)
              .(Raw::InterpolatedStringLiteralExpr)
              .getInterpolationExpr())
    }

    /**
     * Gets the interpolation expr, if it exists.
     */
    final OpaqueValueExpr getInterpolationExpr() {
      result = getImmediateInterpolationExpr().resolve()
    }

    /**
     * Holds if `getInterpolationExpr()` exists.
     */
    final predicate hasInterpolationExpr() { exists(getInterpolationExpr()) }

    /**
     * Gets the interpolation count expr, if it exists.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    Expr getImmediateInterpolationCountExpr() {
      result =
        Synth::convertExprFromRaw(Synth::convertInterpolatedStringLiteralExprToRaw(this)
              .(Raw::InterpolatedStringLiteralExpr)
              .getInterpolationCountExpr())
    }

    /**
     * Gets the interpolation count expr, if it exists.
     */
    final Expr getInterpolationCountExpr() {
      result = getImmediateInterpolationCountExpr().resolve()
    }

    /**
     * Holds if `getInterpolationCountExpr()` exists.
     */
    final predicate hasInterpolationCountExpr() { exists(getInterpolationCountExpr()) }

    /**
     * Gets the literal capacity expr, if it exists.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    Expr getImmediateLiteralCapacityExpr() {
      result =
        Synth::convertExprFromRaw(Synth::convertInterpolatedStringLiteralExprToRaw(this)
              .(Raw::InterpolatedStringLiteralExpr)
              .getLiteralCapacityExpr())
    }

    /**
     * Gets the literal capacity expr, if it exists.
     */
    final Expr getLiteralCapacityExpr() { result = getImmediateLiteralCapacityExpr().resolve() }

    /**
     * Holds if `getLiteralCapacityExpr()` exists.
     */
    final predicate hasLiteralCapacityExpr() { exists(getLiteralCapacityExpr()) }

    /**
     * Gets the appending expr, if it exists.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    TapExpr getImmediateAppendingExpr() {
      result =
        Synth::convertTapExprFromRaw(Synth::convertInterpolatedStringLiteralExprToRaw(this)
              .(Raw::InterpolatedStringLiteralExpr)
              .getAppendingExpr())
    }

    /**
     * Gets the appending expr, if it exists.
     */
    final TapExpr getAppendingExpr() { result = getImmediateAppendingExpr().resolve() }

    /**
     * Holds if `getAppendingExpr()` exists.
     */
    final predicate hasAppendingExpr() { exists(getAppendingExpr()) }
  }
}
