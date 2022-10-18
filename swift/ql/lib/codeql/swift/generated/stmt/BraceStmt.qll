// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.AstNode
import codeql.swift.elements.stmt.Stmt

module Generated {
  class BraceStmt extends Synth::TBraceStmt, Stmt {
    override string getAPrimaryQlClass() { result = "BraceStmt" }

    /**
     * Gets the `index`th element.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    AstNode getImmediateElement(int index) {
      result =
        Synth::convertAstNodeFromRaw(Synth::convertBraceStmtToRaw(this)
              .(Raw::BraceStmt)
              .getElement(index))
    }

    /**
     * Gets the `index`th element.
     */
    final AstNode getElement(int index) { result = getImmediateElement(index).resolve() }

    /**
     * Gets any of the elements.
     */
    final AstNode getAnElement() { result = getElement(_) }

    /**
     * Gets the number of elements.
     */
    final int getNumberOfElements() { result = count(getAnElement()) }
  }
}
