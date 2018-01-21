package org.xtext.example.mydsl.validation

import org.xtext.example.mydsl.mGPL.VarDecl
import org.eclipse.xtext.validation.Check
import org.xtext.example.mydsl.mGPL.MGPLPackage
import org.xtext.example.mydsl.mGPL.Prog

class VariableValidator extends AbstractMGPLValidator {
	
	public static val DUPLICATE_NAME = 'duplicateName'
	public static val UPPERCASE_NAME = 'invalidName'

	@Check
	def checkVarDeclLowercase(VarDecl varDecl) {
		if (Character.isUpperCase(varDecl.name.charAt(0))) {
			warning('Name should start with a lower case letter', MGPLPackage.Literals.DECL__NAME,
				org.xtext.example.mydsl.validation.VariableValidator.UPPERCASE_NAME)
		}
	}

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