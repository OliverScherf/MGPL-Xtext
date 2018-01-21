package org.xtext.example.mydsl.validation

import org.eclipse.xtext.validation.Check
import org.xtext.example.mydsl.mGPL.MGPLPackage
import org.xtext.example.mydsl.mGPL.Prog
import org.xtext.example.mydsl.mGPL.Var
import org.xtext.example.mydsl.mGPL.AnimBlock
import org.eclipse.emf.ecore.EObject
import org.xtext.example.mydsl.mGPL.VarDecl
import org.xtext.example.mydsl.mGPL.ObjDecl

class BindingValidator extends AbstractMGPLValidator {

	public static val VARIABLE_NOT_DECLARED = 'variableNotDeclared'
	public static val VARIABLE_ISNT_ARRAY = 'variableIsntArray'

	@Check
	def checkVariableDeclared(Var v) {
		if (isAnimation(v)) {
			return
		}
		if (isParameter(v)) {
			return
		}
		if(isProg(v)) {
			return
		}

		val decl = findVarDecl(v)
		if (decl === null) {
			error('''The Variable «v.name» does not exists''', MGPLPackage.Literals.VAR__NAME, VARIABLE_NOT_DECLARED)
			return
		}
	}
	
	@Check
	def checkVariableArrayAccess(Var v) {
		if (v.varArray === null) {
			return;
		}
		val decl = findVarDecl(v)
		if (decl.arrSize == 0) {
			error('''The Variable «v.name» was not declared as array''', MGPLPackage.Literals.VAR__NAME, VARIABLE_NOT_DECLARED)
		}
	}
	
	private def isProg(Var v) {
		val prog = v.eResource.allContents.head as Prog
		if (prog.name.equals(v.name)) {
			return true
		}
	}

	private def findVarDecl(Var v) {
		val prog = v.eResource.allContents.head as Prog
		return prog.decls.findFirst [
			name.equals(v.name)
		]
	}

	private def isParameter(Var v) {
		val container = v.eContainer
		return isParameterRecursively(v, container)
	}
	
	private def boolean isParameterRecursively(Var v, EObject container) {
		if (container === null) {
			return false;
		}
		if (container instanceof AnimBlock) {
			return container.objName.equals(v.name)
		}
		return isParameterRecursively(v, container.eContainer)
	}

	private def isAnimation(Var v) {
		val prog = v.eResource.allContents.head as Prog
		return prog.functions.filter [
			it instanceof AnimBlock
		].map [
			it as AnimBlock
		].exists [
			name.equals(v.name)
		]
	}

}
