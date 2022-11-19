package taskmanager.backend.models.interfaces

import org.bson.types.ObjectId

interface CreatedByUserEntity : BaseEntity {
    val createdBy: ObjectId
}