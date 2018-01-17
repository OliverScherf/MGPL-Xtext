package org.xtext.example.mydsl.generator

import org.xtext.example.mydsl.mGPL.Prog
import org.xtext.example.mydsl.mGPL.Expr

class MGPLNameProvider {
	def variableName(Prog p) {
		return p.name
	}
	
	/*
	 * TODO
	 */
	def resolveExpression(Expr e) {
		return "";
	}
}