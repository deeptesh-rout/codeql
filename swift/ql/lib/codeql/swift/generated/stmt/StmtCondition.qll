// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.AstNode
import codeql.swift.elements.stmt.ConditionElement

module Generated {
  class StmtCondition extends Synth::TStmtCondition, AstNode {
    override string getAPrimaryQlClass() { result = "StmtCondition" }

    /**
     * Gets the `index`th element.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    ConditionElement getImmediateElement(int index) {
      result =
        Synth::convertConditionElementFromRaw(Synth::convertStmtConditionToRaw(this)
              .(Raw::StmtCondition)
              .getElement(index))
    }

    /**
     * Gets the `index`th element.
     */
    final ConditionElement getElement(int index) { result = getImmediateElement(index).resolve() }

    /**
     * Gets any of the elements.
     */
    final ConditionElement getAnElement() { result = getElement(_) }

    /**
     * Gets the number of elements.
     */
    final int getNumberOfElements() { result = count(getAnElement()) }
  }
}
