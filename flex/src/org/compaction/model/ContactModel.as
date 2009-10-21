package org.compaction.model {
	import org.compaction.domain.ContactValidator;
	import org.compaction.grails.GrailsListEditModel;
	
	public class ContactModel extends GrailsListEditModel {
		public function ContactModel() {
			modelName = "Contact";
			editModel.validator = new ContactValidator();
		}
	}
}