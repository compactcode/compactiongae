package org.compaction.domain {
	import org.compaction.validation.IValidationBuilder;
	import org.compaction.validation.IValidator;
	
	public class ContactValidator implements IValidator  {
		public function validate(item:Object, builder:IValidationBuilder): void {
			var contact:Contact = Contact(item);
			builder.string(contact.name, "name").notEmpty();
			builder.string(contact.email, "email").validEmail();
			builder.number(contact.postcode, "postcode").lessThan(10000);
		}
	}
}