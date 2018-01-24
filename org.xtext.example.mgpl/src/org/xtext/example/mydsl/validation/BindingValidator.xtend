package org.xtext.example.mydsl.validation

import org.eclipse.xtext.validation.Check
import org.xtext.example.mydsl.mGPL.MGPLPackage
import org.xtext.example.mydsl.mGPL.Prog
import org.xtext.example.mydsl.mGPL.Var
import org.xtext.example.mydsl.mGPL.AnimBlock
import org.eclipse.emf.ecore.EObject
import org.xtext.example.mydsl.mGPL.VarDecl
import org.xtext.example.mydsl.mGPL.ObjDecl
import org.xtext.example.mydsl.mGPL.AttrAss
import org.eclipse.xtext.xbase.lib.Functions.Function1

class BindingValidator extends AbstractMGPLValidator {

	public static val VARIABLE_NOT_DECLARED = 'variableNotDeclared'
	public static val VARIABLE_ISNT_ARRAY = 'variableIsntArray'
	public static val ANIMATION_BLOCK_TYPE_MISMATCH = 'animationBlockTypeMismatch'

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
	
	@Check
	def checkAnimationBlockBinding(AttrAss a) {
		// check if attribute is animation_block
		if(!isAnimBlockProperty(a)) {
			return;
		}
		
		// find parent object if exists
		val parentObjDecl = findParentObjectDeclarationRecursively(a, a.eContainer);
		if(parentObjDecl === null) {
			return;
		}
		
		val isAnimBlockValue = a.expr as Var;
		// find animation with same name as animationBlockValue and check if types mismatch
		val sameNameMisMatchBlocks = findAnimations(a, [e | return e.name == isAnimBlockValue.name  && e.objType != parentObjDecl.type])
		val element = sameNameMisMatchBlocks.head;
		if(element === null) {
			return;
		}
		error('''The type of animation_block «element.name» mismatches''', MGPLPackage.Literals.ATTR_ASS__NAME, ANIMATION_BLOCK_TYPE_MISMATCH);
		 
		
	}
	
	private def isProg(Var v) {
		val prog = v.eResource.allContents.head as Prog
		if (prog.name.equals(v.name)) {
			return true
		}
	}
	
	private def isAnimBlockProperty(AttrAss a) {
		return a.name == "animation_block";
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
	
	private def ObjDecl findParentObjectDeclarationRecursively(AttrAss a, EObject container) {
		if (container === null) {
			return null;
		}
		if (container instanceof ObjDecl) {
			return container;
		}
		return findParentObjectDeclarationRecursively(a, container.eContainer)
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
	
	private def findAnimations(EObject o, Function1<AnimBlock, Boolean> f) {
		val prog = o.eResource.allContents.head as Prog
		return prog.functions.filter [
			it instanceof AnimBlock
		].map [
			it as AnimBlock
		].filter(f)
	}

}
