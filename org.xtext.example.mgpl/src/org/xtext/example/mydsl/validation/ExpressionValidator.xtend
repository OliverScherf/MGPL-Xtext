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
import org.xtext.example.mydsl.mGPL.Operation

class ExpressionValidator extends AbstractMGPLValidator {

	public static val NOT_GRAPHICAL_OBJECT = 'notGraphicalObject'
	public static val TOUCHES_OP = 'touches'
	public static val GRAPHICAL_OBJECTS  = #['rectangle', 'triangle', 'circle']

	@Check
	def checkTouchesObjects(Operation o) {
		if(o.op != TOUCHES_OP) {
			return;
		}
		// get operands as vars
		val operand1 = o.left as Var;
		val operand2 = o.right as Var;
		
		// get type of first operand
		var var1DeclType = "";
		if(ASTHelper.isParameter(operand1)) {
			var1DeclType = ASTHelper.findParameterTypeRecursively(operand1, operand1.eContainer);
		} else {
			val var1Decl = ASTHelper.findVarDecl(operand1);
			if(var1Decl !== null) {
				var1DeclType = var1Decl.type;
			}
		}
		
		// get type of second operand
		var var2DeclType = "";
		if(ASTHelper.isParameter(operand2)) {
			var2DeclType = ASTHelper.findParameterTypeRecursively(operand2, operand2.eContainer);
		} else {
			val var2Decl = ASTHelper.findVarDecl(operand2);
			if(var2Decl !== null) {
				var2DeclType = var2Decl.type;
			}	
		}
		
		if(var1DeclType === "" || var1DeclType === "") {
			return; 
		}
		val valid1 = GRAPHICAL_OBJECTS.contains(var1DeclType);
		val valid2 = GRAPHICAL_OBJECTS.contains(var2DeclType);
		
		if(!valid1) {
			error('''Operands of touches must be graphical objects''', MGPLPackage.Literals.OPERATION__LEFT, NOT_GRAPHICAL_OBJECT);
		}
		if(!valid2) {
			error('''Operands of touches must be graphical objects''', MGPLPackage.Literals.OPERATION__RIGHT, NOT_GRAPHICAL_OBJECT);
		}
		
	}

	
}
