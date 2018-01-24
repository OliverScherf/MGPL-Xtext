/*
 * generated by Xtext 2.13.0
 */
package org.xtext.example.mydsl.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import org.xtext.example.mydsl.mGPL.Prog
import org.xtext.example.mydsl.mGPL.impl.ProgImpl
import java.io.File
import org.eclipse.core.runtime.FileLocator
import java.net.URL
import org.eclipse.emf.mwe.internal.core.Workflow
import java.nio.file.Files
import java.nio.file.StandardOpenOption
import java.nio.file.StandardCopyOption
import org.xtext.example.mydsl.mGPL.VarDecl
import org.xtext.example.mydsl.mGPL.Decl
import org.xtext.example.mydsl.mGPL.ObjDecl
import org.eclipse.emf.common.util.EList
import org.xtext.example.mydsl.mGPL.AttrAss

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class MGPLGenerator extends AbstractGenerator {

	/*
	 * Kopiere Framework nach res/
	 * Rectangle, Circle Klassen
	 * KeyListener
	 * animations in update Funktion generieren (callback an Framework)
	 */

	MGPLNameProvider np = new MGPLNameProvider

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		copyFramework(fsa)
		val prog = resource.allContents.head as Prog
		val code = generateProg(prog)
		fsa.generateFile(prog.name + ".ts", code)
	}
	
	private def copyFramework(IFileSystemAccess2 fsa) {
		val resDir = new File(System.getenv("PARENT_LOC") + "/res/src/framework")
		for (f : resDir.listFiles)
			fsa.generateFile("framework/" + f.name, new String(Files.readAllBytes(f.toPath)))
	}
	
	def generateProg(Prog p) {
		'''
		import Game from "./framework/Game.js";
		import Rectangle from "./framework/rectangle.js";
		import Triangle from "./framework/Triangle.js";
		import { touches } from "./framework/Collision.js";
		import Circle from "./framework/Circle.js";
		import {arrayOfN} from "./framework/Util.js";
		
		enum «p.name» {
			«generateAttrAssList(p)»
		}

		«generateGlobalVariables(p)»

		'''
	}
		
	
	def generateAttrAssList(Prog p) {
		'''
		«FOR a : p.attrAssList.attrAss SEPARATOR ','»
		 «a.name» = «np.resolveExpression(a.expr)»
		«ENDFOR» 
		'''
	}
	
	def generateGlobalVariables(Prog p) {
		'''
		// global variables
		«FOR d : p.decls.filter[it instanceof VarDecl].map[it as VarDecl]»
			let «d.name»: «np.type(d)»«generateInitValue(d)»;
		«ENDFOR»
		
		// global objects
		«FOR d : p.decls.filter[it instanceof ObjDecl].map[it as ObjDecl]»
			let «d.name»: «np.type(d)»«generateInitValue(d)»;
		«ENDFOR»
		'''
	}
		
	def generateInitValue(Decl d) {
		if (d instanceof VarDecl) {
			if (d.value !== null) {
				return ''' = «np.resolveExpression(d.value.expr)»'''
			}
		} else if (d instanceof ObjDecl) {
			if (d.attrAssList !== null) {
				if (np.type(d) == np.RECTANGLE || np.type(d) == np.TRIANGLE) {
					return 
					'''
					 = new «np.type(d)»(«findAttribute(d.attrAssList.attrAss, "x")»,
					 								«findAttribute(d.attrAssList.attrAss, "y")»,
					 								«findAttribute(d.attrAssList.attrAss, "w", "width")»,
					 								«findAttribute(d.attrAssList.attrAss, "h", "height")»)'''
				}

			}
		}
		return "";
	}
	
	def findAttribute(EList<AttrAss> a, String... fields) {
		var AttrAss ret;
		for (f : fields) {
			ret = a.findFirst[
				it.name == f
			]
			if (ret !== null) return np.resolveExpression(ret.expr)
		}
		return "0"
	}
		
}
