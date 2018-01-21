package org.xtext.example.mydsl.validation

import org.eclipse.xtext.validation.Check
import org.xtext.example.mydsl.mGPL.MGPLPackage
import org.xtext.example.mydsl.mGPL.Prog
import org.xtext.example.mydsl.mGPL.Decl

class VariableValidator extends AbstractMGPLValidator {
	
	public static val DUPLICATE_NAME = 'duplicateName'
	public static val UPPERCASE_NAME = 'invalidName'

	@Check
	def checkDeclLowercase(Decl decl) {
		if (Character.isUpperCase(decl.name.charAt(0))) {
			warning('Name should start with a lower case letter', MGPLPackage.Literals.DECL__NAME,
				org.xtext.example.mydsl.validation.VariableValidator.UPPERCASE_NAME)
		}
	}

	@Check
	def checkVarDeclUniqueNames(Decl decl) {
		val prog = decl.eResource.allContents.head as Prog
		val orrucances = prog.decls.filter [
			name.equals(decl.name)
		].size
		if (orrucances != 1) {
			error('Declarations have to be unique', MGPLPackage.Literals.DECL__NAME, DUPLICATE_NAME)
		}
	}
	
}