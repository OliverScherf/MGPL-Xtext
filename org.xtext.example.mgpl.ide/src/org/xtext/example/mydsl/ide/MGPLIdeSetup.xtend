/*
 * generated by Xtext 2.13.0
 */
package org.xtext.example.mydsl.ide

import com.google.inject.Guice
import org.eclipse.xtext.util.Modules2
import org.xtext.example.mydsl.MGPLRuntimeModule
import org.xtext.example.mydsl.MGPLStandaloneSetup

/**
 * Initialization support for running Xtext languages as language servers.
 */
class MGPLIdeSetup extends MGPLStandaloneSetup {

	override createInjector() {
		Guice.createInjector(Modules2.mixin(new MGPLRuntimeModule, new MGPLIdeModule))
	}
	
}
