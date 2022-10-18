// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.type.NominalOrBoundGenericNominalType
import codeql.swift.elements.type.Type

module Generated {
  class BoundGenericType extends Synth::TBoundGenericType, NominalOrBoundGenericNominalType {
    /**
     * Gets the `index`th arg type.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    Type getImmediateArgType(int index) {
      result =
        Synth::convertTypeFromRaw(Synth::convertBoundGenericTypeToRaw(this)
              .(Raw::BoundGenericType)
              .getArgType(index))
    }

    /**
     * Gets the `index`th arg type.
     */
    final Type getArgType(int index) { result = getImmediateArgType(index).resolve() }

    /**
     * Gets any of the arg types.
     */
    final Type getAnArgType() { result = getArgType(_) }

    /**
     * Gets the number of arg types.
     */
    final int getNumberOfArgTypes() { result = count(getAnArgType()) }
  }
}
