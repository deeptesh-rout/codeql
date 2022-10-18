// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.expr.ClosureExpr
import codeql.swift.elements.expr.Expr
import codeql.swift.elements.decl.PatternBindingDecl

module Generated {
  class CaptureListExpr extends Synth::TCaptureListExpr, Expr {
    override string getAPrimaryQlClass() { result = "CaptureListExpr" }

    /**
     * Gets the `index`th binding decl.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    PatternBindingDecl getImmediateBindingDecl(int index) {
      result =
        Synth::convertPatternBindingDeclFromRaw(Synth::convertCaptureListExprToRaw(this)
              .(Raw::CaptureListExpr)
              .getBindingDecl(index))
    }

    /**
     * Gets the `index`th binding decl.
     */
    final PatternBindingDecl getBindingDecl(int index) {
      result = getImmediateBindingDecl(index).resolve()
    }

    /**
     * Gets any of the binding decls.
     */
    final PatternBindingDecl getABindingDecl() { result = getBindingDecl(_) }

    /**
     * Gets the number of binding decls.
     */
    final int getNumberOfBindingDecls() { result = count(getABindingDecl()) }

    /**
     * Gets the closure body.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    ClosureExpr getImmediateClosureBody() {
      result =
        Synth::convertClosureExprFromRaw(Synth::convertCaptureListExprToRaw(this)
              .(Raw::CaptureListExpr)
              .getClosureBody())
    }

    /**
     * Gets the closure body.
     */
    final ClosureExpr getClosureBody() { result = getImmediateClosureBody().resolve() }
  }
}
