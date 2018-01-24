package org.xtext.example.mydsl.generator

import org.xtext.example.mydsl.mGPL.Prog
import org.xtext.example.mydsl.mGPL.Expression
import org.xtext.example.mydsl.mGPL.IntLiteral
import org.xtext.example.mydsl.mGPL.VarDecl
import org.xtext.example.mydsl.mGPL.Decl
import org.xtext.example.mydsl.mGPL.Operation
import org.xtext.example.mydsl.mGPL.Var
import org.xtext.example.mydsl.mGPL.UnaryOperation

class MGPLNameProvider {

	public String NUMBER = 'number'
	public String RECTANGLE = 'Rectangle'
	public String CIRCLE = 'Circle'
	public String TRIANGLE = 'Triangle'

	def variableName(Prog p) {
		return p.name
	}

	def String resolveExpression(Expression e) {
		if (e === null) {
			return ""
		}
		if (e instanceof IntLiteral) {
			return String.valueOf(e.value)
		}
		if (e instanceof UnaryOperation) {
			return e.op + resolveExpression(e.right)
		}
		if (e instanceof Var) {
			var resolved = e.name;
			// check if its an array access
			if (e.varArray !== null) {
				resolved += '''[«resolveExpression(e.varArray.indexExpr)»]'''			
			}
			// check if its an property access
			if (e.varProp !== null) {
				resolved += '''.«e.varProp.objProp»'''
			}
			return resolved
		}
		
		// call resolveExpression recursevly with left and right
		if (e instanceof Operation) {
			return resolveExpression(e.left) + e?.op + resolveExpression(e.right)
		}
		
		return "unknown"
	}

	def type(Decl d) {
		return type(d.type)
	}
	
	def type(String d) {
		if (d == 'int')
			return NUMBER
		if (d == 'rectangle')
			return RECTANGLE
		if (d == 'circle')
			return CIRCLE
		if (d == 'triangle')
			return TRIANGLE
		
	}

}
