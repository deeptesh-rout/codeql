// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.Expr

module Generated {
  class AssignExpr extends Synth::TAssignExpr, Expr {
    override string getAPrimaryQlClass() { result = "AssignExpr" }

    /**
     * Gets the dest.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    Expr getImmediateDest() {
      result =
        Synth::convertExprFromRaw(Synth::convertAssignExprToRaw(this).(Raw::AssignExpr).getDest())
    }

    /**
     * Gets the dest.
     */
    final Expr getDest() { result = getImmediateDest().resolve() }

    /**
     * Gets the source.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    Expr getImmediateSource() {
      result =
        Synth::convertExprFromRaw(Synth::convertAssignExprToRaw(this).(Raw::AssignExpr).getSource())
    }

    /**
     * Gets the source.
     */
    final Expr getSource() { result = getImmediateSource().resolve() }
  }
}
