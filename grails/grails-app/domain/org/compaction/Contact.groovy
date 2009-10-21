package org.compaction

import javax.persistence.*

@Entity
class Contact {
    @Id @GeneratedValue (strategy = GenerationType.IDENTITY)
    Long id
    String name
    String email
    Integer postcode
}
