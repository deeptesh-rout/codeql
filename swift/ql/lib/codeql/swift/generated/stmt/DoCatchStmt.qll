// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.stmt.CaseStmt
import codeql.swift.elements.stmt.LabeledStmt
import codeql.swift.elements.stmt.Stmt

module Generated {
  class DoCatchStmt extends Synth::TDoCatchStmt, LabeledStmt {
    override string getAPrimaryQlClass() { result = "DoCatchStmt" }

    /**
     * Gets the body.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    Stmt getImmediateBody() {
      result =
        Synth::convertStmtFromRaw(Synth::convertDoCatchStmtToRaw(this).(Raw::DoCatchStmt).getBody())
    }

    /**
     * Gets the body.
     */
    final Stmt getBody() { result = getImmediateBody().resolve() }

    /**
     * Gets the `index`th catch.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    CaseStmt getImmediateCatch(int index) {
      result =
        Synth::convertCaseStmtFromRaw(Synth::convertDoCatchStmtToRaw(this)
              .(Raw::DoCatchStmt)
              .getCatch(index))
    }

    /**
     * Gets the `index`th catch.
     */
    final CaseStmt getCatch(int index) { result = getImmediateCatch(index).resolve() }

    /**
     * Gets any of the catches.
     */
    final CaseStmt getACatch() { result = getCatch(_) }

    /**
     * Gets the number of catches.
     */
    final int getNumberOfCatches() { result = count(getACatch()) }
  }
}
