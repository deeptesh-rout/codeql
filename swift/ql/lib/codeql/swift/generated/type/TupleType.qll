// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.type.Type

module Generated {
  class TupleType extends Synth::TTupleType, Type {
    override string getAPrimaryQlClass() { result = "TupleType" }

    /**
     * Gets the `index`th type.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    Type getImmediateType(int index) {
      result =
        Synth::convertTypeFromRaw(Synth::convertTupleTypeToRaw(this).(Raw::TupleType).getType(index))
    }

    /**
     * Gets the `index`th type.
     */
    final Type getType(int index) { result = getImmediateType(index).resolve() }

    /**
     * Gets any of the types.
     */
    final Type getAType() { result = getType(_) }

    /**
     * Gets the number of types.
     */
    final int getNumberOfTypes() { result = count(getAType()) }

    /**
     * Gets the `index`th name.
     */
    string getName(int index) {
      result = Synth::convertTupleTypeToRaw(this).(Raw::TupleType).getName(index)
    }

    /**
     * Gets any of the names.
     */
    final string getAName() { result = getName(_) }

    /**
     * Gets the number of names.
     */
    final int getNumberOfNames() { result = count(getAName()) }
  }
}
