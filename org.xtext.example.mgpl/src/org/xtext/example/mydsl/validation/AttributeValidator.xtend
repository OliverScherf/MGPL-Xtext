package org.xtext.example.mydsl.validation

import java.util.List
import org.eclipse.xtext.validation.Check
import org.xtext.example.mydsl.mGPL.AttrAssList
import org.xtext.example.mydsl.mGPL.IntLiteral
import org.xtext.example.mydsl.mGPL.MGPLPackage
import org.xtext.example.mydsl.mGPL.ObjDecl
import org.xtext.example.mydsl.mGPL.Prog

class AttributeValidator extends AbstractMGPLValidator {
	
	public static val DUPLICATE_NAME = 'duplicateName'
	public static val UPPERCASE_NAME = 'invalidName'
	public static val NOT_ALLOWED_ATTRIBUTE = 'notAllowedAttribute'
	public static val ATTRIBUTE_ONCE = 'attributeOnce'
	public static val INVALID_VALUE = 'invalidValue'
	public static val INVALID_SPEED = 'invalidSpeed'
	public static val ALLOWED_GAME_ATTRIBUTES = #['height','width','speed','x','y'];
	public static val ALLOWED_RECTANGLE_ATTRIBUTES = #['height','width','x','y', 'animation_block', 'visible'];
	public static val ALLOWED_CIRCLE_ATTRIBUTES = #['radius','x','y', 'animation_block', 'visible'];

	
	def checkGameAttributes(AttrAssList attrList) {
		val attributes = attrList.attrAss;
		checkIfAttributeNamesValid(attrList, ALLOWED_GAME_ATTRIBUTES);
		checkIfAttributesMaxOnce(attrList)
		attributes.forEach[
			val attributeName = normalizeName(it.name);
			if(!(it.expr instanceof IntLiteral)) {
				error('''This attribute has to be an int constant''', it, MGPLPackage.Literals.ATTR_ASS__EXPR, INVALID_VALUE);
				return;
			}
			if(attributeName == "speed") {				
				val speed = it.expr as IntLiteral;
				if(speed.value < 0 || speed.value >= 100) {
					error('''Speed Attribute has to be an int between 0 and 100''', it, MGPLPackage.Literals.ATTR_ASS__EXPR, INVALID_SPEED);
				}
			}
		]
	}
	
	def checkCircleAttributes(AttrAssList attrList) {
		checkIfAttributeNamesValid(attrList, ALLOWED_CIRCLE_ATTRIBUTES);
		checkIfAttributesMaxOnce(attrList);
	}
	
	def checkRectangleAttributes(AttrAssList attrList) {
		checkIfAttributeNamesValid(attrList, ALLOWED_RECTANGLE_ATTRIBUTES);
		checkIfAttributesMaxOnce(attrList);
	}
	
	@Check
	def checkAttributes(AttrAssList attrList) {
		if(attrList.eContainer instanceof Prog) {
			checkGameAttributes(attrList)
		}
		if(attrList.eContainer instanceof ObjDecl) {
			val gameObject = attrList.eContainer as ObjDecl;
			if(gameObject.type == "circle") {
				checkCircleAttributes(attrList);
			}
			if(gameObject.type == "rectangle" || gameObject.type == "triangle") {
				checkRectangleAttributes(attrList)
			}
		}
	}
	
	def String normalizeName(String name) {
		switch (name) {
			case "h": {
				return "height";
			}
			case "w": {
				return "width";
			}
			case "r": {
				return "radius";
			}
			default: {
				return name;	
			}
		}
	}
	
	def checkIfAttributesMaxOnce(AttrAssList attrList) {
		val attributes = attrList.attrAss;
		val seenAttributes = newArrayList();
		attributes.forEach[
			val attributeName = normalizeName(it.name);
			val alreadyExists = seenAttributes.contains(attributeName);
			if(alreadyExists) {
				error('''This attribute is only allowed once''', it, MGPLPackage.Literals.ATTR_ASS__NAME, ATTRIBUTE_ONCE);
			}
			if(attributeName !== null) {
				seenAttributes.add(attributeName);	
			}
		]
	}
	
	def checkIfAttributeNamesValid(AttrAssList attrList, List<String> allowed) {
		val attributes = attrList.attrAss;
		attributes.forEach[
			val attributeName = normalizeName(it.name);
			val validName = allowed.contains(attributeName);
			if(!validName) {
				error('''This attribute is not allowed''', it, MGPLPackage.Literals.ATTR_ASS__NAME, NOT_ALLOWED_ATTRIBUTE);
			}
		]
	}
	
}