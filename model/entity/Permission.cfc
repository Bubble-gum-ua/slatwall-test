/*

    Slatwall - An Open Source eCommerce Platform
    Copyright (C) ten24, LLC
	
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
	
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
	
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
    Linking this program statically or dynamically with other modules is
    making a combined work based on this program.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.
	
    As a special exception, the copyright holders of this program give you
    permission to combine this program with independent modules and your 
    custom code, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting program under terms 
    of your choice, provided that you follow these specific guidelines: 

	- You also meet the terms and conditions of the license of each 
	  independent module 
	- You must not alter the default display of the Slatwall name or logo from  
	  any part of the application 
	- Your custom code must not alter or create any files inside Slatwall, 
	  except in the following directories:
		/integrationServices/

	You may copy and distribute the modified version of this program that meets 
	the above guidelines as a combined work under the terms of GPL for this program, 
	provided that you include the source code of that other code when and as the 
	GNU GPL requires distribution of source code.
    
    If you modify this program, you may extend this exception to your version 
    of the program, but you are not obligated to do so.

Notes:
	Access Types
	============
	entity
	action
*/
component entityname="SlatwallPermission" table="SwPermission" persistent="true" accessors="true" extends="HibachiEntity" cacheuse="transactional" hb_serviceName="accountService" hb_permission="permissionGroup.permissions" {
	
	// Persistent Properties
	property name="permissionID" ormtype="string" length="32" fieldtype="id" generator="uuid" unsavedvalue="" default="";
	property name="accessType" ormtype="string";
	property name="subsystem" ormtype="string";
	property name="section" ormtype="string";
	property name="item" ormtype="string";
	property name="allowActionFlag" ormtype="boolean";
	property name="allowCreateFlag" ormtype="boolean";
	property name="allowReadFlag" ormtype="boolean";
	property name="allowUpdateFlag" ormtype="boolean";
	property name="allowDeleteFlag" ormtype="boolean";
	property name="allowProcessFlag" ormtype="boolean";
	property name="allowReportFlag" ormtype="boolean";
	property name="entityClassName" ormtype="string";
	property name="propertyName" ormtype="string";
	property name="processContext" ormtype="string";
	
	// Related Object Properties (many-to-one)
	property name="permissionGroup" cfc="PermissionGroup" fieldtype="many-to-one" fkcolumn="permissionGroupID";
	
	// Related Object Properties (one-to-many)
	property name="permissionRecordRestrictions" singularname="permissionRecordRestriction" type="array" cfc="PermissionRecordRestriction" fieldtype="one-to-many" fkcolumn="permissionID" cascade="all-delete-orphan" inverse="true";
	
	// Related Object Properties (many-to-many - owner)

	// Related Object Properties (many-to-many - inverse)
	
	// Remote Properties
	property name="remoteID" ormtype="string";
	
	// Audit Properties
	property name="createdDateTime" hb_populateEnabled="false" ormtype="timestamp";
	property name="createdByAccountID" hb_populateEnabled="false" ormtype="string";
	property name="modifiedDateTime" hb_populateEnabled="false" ormtype="timestamp";
	property name="modifiedByAccountID" hb_populateEnabled="false" ormtype="string";
	
	// Non-Persistent Properties

	public any function init() {
		
		return super.init();
	}

	
	// ============ START: Non-Persistent Property Methods =================
	
	// ============  END:  Non-Persistent Property Methods =================
		
	// ============= START: Bidirectional Helper Methods ===================
	
	// Permission Group (many-to-one)    
	public void function setPermissionGroup(required any permissionGroup) {    
		variables.permissionGroup = arguments.permissionGroup;    
		if(isNew() or !arguments.permissionGroup.hasPermission( this )) {    
			arrayAppend(arguments.permissionGroup.getPermissions(), this);    
		}    
	}    
	public void function removePermissionGroup(any permissionGroup) {    
		if(!structKeyExists(arguments, "permissionGroup")) {    
			arguments.permissionGroup = variables.permissionGroup;    
		}    
		var index = arrayFind(arguments.permissionGroup.getPermissions(), this);    
		if(index > 0) {    
			arrayDeleteAt(arguments.permissionGroup.getPermissions(), index);    
		}    
		structDelete(variables, "permissionGroup");    
	}
	
	// Permission Record Restriction (one-to-many)    
	public void function addPermissionRecordRestriction(required any permissionRecordRestriction) {    
		arguments.permissionRecordRestriction.setPermission( this );    
	}    
	public void function removePermissionRecordRestriction(required any permissionRecordRestriction) {    
		arguments.permissionRecordRestriction.removePermission( this );    
	}
	
	// =============  END:  Bidirectional Helper Methods ===================

	// =============== START: Custom Validation Methods ====================
	
	// ===============  END: Custom Validation Methods =====================
	
	// =============== START: Custom Formatting Methods ====================
	
	// ===============  END: Custom Formatting Methods =====================

	// ================== START: Overridden Methods ========================
	
	public string function getSimpleRepresentation(){
		var simpleRep = "";
		if(!isNull(getPermissionGroup())){
			simpleRep &= getPermissionGroup().getPermissionGroupName() & ' - ';
		}
		if(getAccessType()=='entity'){
			simpleRep &= getEntityClassName();
		}
		return simpleRep;
	}
	
	// ==================  END:  Overridden Methods ========================
	
	// =================== START: ORM Event Hooks  =========================
	
	// ===================  END:  ORM Event Hooks  =========================
	
	// ================== START: Deprecated Methods ========================
	
	// ==================  END:  Deprecated Methods ========================
}
