package org.compaction.domain {
	import org.compaction.grails.GrailsEntity;
	
	[RemoteClass(alias="org.compaction.Contact")]
	[Bindable]
	public class Contact extends GrailsEntity {
		public var name:String;
		public var email:String;
		public var postcode:int;
	}
}