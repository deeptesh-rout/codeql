// generated by codegen/codegen.py
private import codeql.swift.generated.Synth
private import codeql.swift.generated.Raw
import codeql.swift.elements.decl.TypeDecl

module Generated {
  class ModuleDecl extends Synth::TModuleDecl, TypeDecl {
    override string getAPrimaryQlClass() { result = "ModuleDecl" }

    predicate isBuiltinModule() {
      Synth::convertModuleDeclToRaw(this).(Raw::ModuleDecl).isBuiltinModule()
    }

    predicate isSystemModule() {
      Synth::convertModuleDeclToRaw(this).(Raw::ModuleDecl).isSystemModule()
    }

    /**
     * Gets the `index`th imported module.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    ModuleDecl getImmediateImportedModule(int index) {
      result =
        Synth::convertModuleDeclFromRaw(Synth::convertModuleDeclToRaw(this)
              .(Raw::ModuleDecl)
              .getImportedModule(index))
    }

    /**
     * Gets the `index`th imported module.
     */
    final ModuleDecl getImportedModule(int index) {
      result = getImmediateImportedModule(index).resolve()
    }

    /**
     * Gets any of the imported modules.
     */
    final ModuleDecl getAnImportedModule() { result = getImportedModule(_) }

    /**
     * Gets the number of imported modules.
     */
    final int getNumberOfImportedModules() { result = count(getAnImportedModule()) }

    /**
     * Gets the `index`th exported module.
     * This is taken from the "hidden" AST and should only be used to be overridden by classes.
     */
    ModuleDecl getImmediateExportedModule(int index) {
      result =
        Synth::convertModuleDeclFromRaw(Synth::convertModuleDeclToRaw(this)
              .(Raw::ModuleDecl)
              .getExportedModule(index))
    }

    /**
     * Gets the `index`th exported module.
     */
    final ModuleDecl getExportedModule(int index) {
      result = getImmediateExportedModule(index).resolve()
    }

    /**
     * Gets any of the exported modules.
     */
    final ModuleDecl getAnExportedModule() { result = getExportedModule(_) }

    /**
     * Gets the number of exported modules.
     */
    final int getNumberOfExportedModules() { result = count(getAnExportedModule()) }
  }
}
