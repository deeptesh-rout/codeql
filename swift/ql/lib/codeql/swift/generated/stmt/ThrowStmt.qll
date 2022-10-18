// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.Expr
import codeql.swift.elements.stmt.Stmt

module Generated {
  class ThrowStmt extends Synth::TThrowStmt, Stmt {
    override string getAPrimaryQlClass() { result = "ThrowStmt" }

    /**
     * Gets the sub expr.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    Expr getImmediateSubExpr() {
      result =
        Synth::convertExprFromRaw(Synth::convertThrowStmtToRaw(this).(Raw::ThrowStmt).getSubExpr())
    }

    /**
     * Gets the sub expr.
     */
    final Expr getSubExpr() { result = getImmediateSubExpr().resolve() }
  }
}
