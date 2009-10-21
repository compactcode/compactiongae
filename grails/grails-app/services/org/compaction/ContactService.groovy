package org.compaction

class ContactService {
    def list() {
        Contact.list()
    }
    def create() {
        new Contact()
    }
    def save(Contact entity) {
        def saveable = entity;
        if(entity.id && entity.id > 0) {
            saveable = Contact.get(entity.id)
            saveable.properties = entity.properties
        } else {
            saveable.id = null;
        }
        if(!saveable.save()) {
            saveable.errors.each {println it}
        }
        saveable
    }
    def delete(Contact entity) {
        Contact.get(entity.id).delete()
    }
}
