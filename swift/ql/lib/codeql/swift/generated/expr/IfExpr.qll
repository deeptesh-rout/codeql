// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.Expr

module Generated {
  class IfExpr extends Synth::TIfExpr, Expr {
    override string getAPrimaryQlClass() { result = "IfExpr" }

    /**
     * Gets the condition.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    Expr getImmediateCondition() {
      result =
        Synth::convertExprFromRaw(Synth::convertIfExprToRaw(this).(Raw::IfExpr).getCondition())
    }

    /**
     * Gets the condition.
     */
    final Expr getCondition() { result = getImmediateCondition().resolve() }

    /**
     * Gets the then expr.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    Expr getImmediateThenExpr() {
      result =
        Synth::convertExprFromRaw(Synth::convertIfExprToRaw(this).(Raw::IfExpr).getThenExpr())
    }

    /**
     * Gets the then expr.
     */
    final Expr getThenExpr() { result = getImmediateThenExpr().resolve() }

    /**
     * Gets the else expr.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    Expr getImmediateElseExpr() {
      result =
        Synth::convertExprFromRaw(Synth::convertIfExprToRaw(this).(Raw::IfExpr).getElseExpr())
    }

    /**
     * Gets the else expr.
     */
    final Expr getElseExpr() { result = getImmediateElseExpr().resolve() }
  }
}
