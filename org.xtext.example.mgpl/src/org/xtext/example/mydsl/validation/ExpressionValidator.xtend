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
		val operand1 = o.left as Var;
		val operand2 = o.right as Var;
		
		
		val var1Decl = ASTHelper.findVarDecl(operand1);
		
		println(var1Decl.name);
		return;
		/*if(var1Decl === null || var2Decl === null) {
			return; 
		}
		val check = GRAPHICAL_OBJECTS.contains(var1Decl.type) && GRAPHICAL_OBJECTS.contains(var2Decl.type);
		if(!check) {
			error('''Operands of touches «operand1.name» and «operand2.name» must be graphical objects''', MGPLPackage.Literals.VAR__NAME, NOT_GRAPHICAL_OBJECT);
		}*/ 
		
	}

	
}
