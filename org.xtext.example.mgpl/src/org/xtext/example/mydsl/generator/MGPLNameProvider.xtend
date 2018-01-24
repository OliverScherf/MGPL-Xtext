package org.xtext.example.mydsl.generator

import org.xtext.example.mydsl.mGPL.Prog
import org.xtext.example.mydsl.mGPL.Expression
import org.xtext.example.mydsl.mGPL.IntLiteral
import org.xtext.example.mydsl.mGPL.VarDecl
import org.xtext.example.mydsl.mGPL.Decl
import org.xtext.example.mydsl.mGPL.Operation
import org.xtext.example.mydsl.mGPL.Var

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
		if (d.type == 'int')
			return NUMBER
		if (d.type == 'rectangle')
			return RECTANGLE
		if (d.type == 'circle')
			return CIRCLE
		if (d.type == 'triangle')
			return TRIANGLE
		throw new RuntimeException("Could not type Declaration " + d)
	}

}
