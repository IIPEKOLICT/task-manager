package taskmanager.backend.models.interfaces

import org.bson.types.ObjectId
import taskmanager.backend.models.base.BaseEntity

interface CreatedByUserEntity : BaseEntity {
    val createdBy: ObjectId
}