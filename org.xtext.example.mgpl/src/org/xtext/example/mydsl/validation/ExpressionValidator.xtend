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
	public static val TYPE_INT = 'int'
	public static val GRAPHICAL_OBJECTS  = #['rectangle', 'triangle', 'circle']

	@Check
	def checkTouchesObjects(Operation o) {
		// get operands as vars
		val operand1 = o.left as Var;
		val operand2 = o.right as Var;
		
		// get type of first operand
		var var1DeclType = ASTHelper.getTypeOfVariable(operand1);
		// get type of second operand
		var var2DeclType = ASTHelper.getTypeOfVariable(operand2);
		
		if(var1DeclType === "" || var1DeclType === "") {
			return; 
		}
		
		if(o.op == TOUCHES_OP) {
			val valid1 = GRAPHICAL_OBJECTS.contains(var1DeclType);
			val valid2 = GRAPHICAL_OBJECTS.contains(var2DeclType);
			
			if(!valid1) {
				error('''Operands of touches must be graphical objects''', MGPLPackage.Literals.OPERATION__LEFT, NOT_GRAPHICAL_OBJECT);
			}
			if(!valid2) {
				error('''Operands of touches must be graphical objects''', MGPLPackage.Literals.OPERATION__RIGHT, NOT_GRAPHICAL_OBJECT);
			}
		} else {
			if(var1DeclType != TYPE_INT) {
				error('''Operands of must be of type int''', MGPLPackage.Literals.OPERATION__LEFT, NOT_GRAPHICAL_OBJECT);
			}
			if(var2DeclType != TYPE_INT) {
				error('''Operands of must be of type int''', MGPLPackage.Literals.OPERATION__RIGHT, NOT_GRAPHICAL_OBJECT);
			}
		}
		
		
	}

	
}
