package org.xtext.example.mydsl.validation

import org.xtext.example.mydsl.mGPL.VarDecl
import org.eclipse.xtext.validation.Check
import org.xtext.example.mydsl.mGPL.MGPLPackage
import org.xtext.example.mydsl.mGPL.Prog

class VariableValidator extends AbstractMGPLValidator {
	
	public static val DUPLICATE_NAME = 'duplicateName'

	@Check
	def checkVarDeclUniqueNames(VarDecl varDecl) {
		val prog = varDecl.eResource.allContents.head as Prog
		val orrucances = prog.decls.filter [
			it instanceof VarDecl
		].map [
			it as VarDecl
		].filter [
			name.equals(varDecl.name)
		].size
		if (orrucances != 1) {
			error('Variable Declarations have to be unique', MGPLPackage.Literals.DECL__NAME, DUPLICATE_NAME)
		}
	}
}