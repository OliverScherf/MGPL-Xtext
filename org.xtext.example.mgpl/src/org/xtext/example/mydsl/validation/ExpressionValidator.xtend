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
import org.xtext.example.mydsl.mGPL.IntLiteral
import com.ibm.icu.impl.locale.InternalLocaleBuilder

class ExpressionValidator extends AbstractMGPLValidator {

	public static val NOT_GRAPHICAL_OBJECT = 'notGraphicalObject'
	public static val TOUCHES_OP = 'touches'
	public static val TYPE_INT = 'int'
	public static val GRAPHICAL_OBJECTS  = #['rectangle', 'triangle', 'circle']

	@Check
	def checkTouchesObjects(Operation o) {
		var var1DeclType = "";
		var var2DeclType = "";
	

		if(o.left instanceof IntLiteral || o.left instanceof Operation) {
			var1DeclType = TYPE_INT;
		}
		else {
			val operand1 = o.left as Var;
			var1DeclType = ASTHelper.getTypeOfVariable(operand1);
		}
		
		if(o.right instanceof IntLiteral || o.right instanceof Operation) {
			var2DeclType = TYPE_INT;
		} 
		else {
			val operand2 = o.right as Var;
			var2DeclType = ASTHelper.getTypeOfVariable(operand2);
		}
		
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
