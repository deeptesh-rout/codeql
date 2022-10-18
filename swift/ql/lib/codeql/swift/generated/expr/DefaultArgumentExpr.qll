// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.Expr
import codeql.swift.elements.decl.ParamDecl

module Generated {
  class DefaultArgumentExpr extends Synth::TDefaultArgumentExpr, Expr {
    override string getAPrimaryQlClass() { result = "DefaultArgumentExpr" }

    /**
     * Gets the param decl.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    ParamDecl getImmediateParamDecl() {
      result =
        Synth::convertParamDeclFromRaw(Synth::convertDefaultArgumentExprToRaw(this)
              .(Raw::DefaultArgumentExpr)
              .getParamDecl())
    }

    /**
     * Gets the param decl.
     */
    final ParamDecl getParamDecl() { result = getImmediateParamDecl().resolve() }

    /**
     * Gets the param index.
     */
    int getParamIndex() {
      result =
        Synth::convertDefaultArgumentExprToRaw(this).(Raw::DefaultArgumentExpr).getParamIndex()
    }

    /**
     * Gets the caller side default, if it exists.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    Expr getImmediateCallerSideDefault() {
      result =
        Synth::convertExprFromRaw(Synth::convertDefaultArgumentExprToRaw(this)
              .(Raw::DefaultArgumentExpr)
              .getCallerSideDefault())
    }

    /**
     * Gets the caller side default, if it exists.
     */
    final Expr getCallerSideDefault() { result = getImmediateCallerSideDefault().resolve() }

    /**
     * Holds if `getCallerSideDefault()` exists.
     */
    final predicate hasCallerSideDefault() { exists(getCallerSideDefault()) }
  }
}
