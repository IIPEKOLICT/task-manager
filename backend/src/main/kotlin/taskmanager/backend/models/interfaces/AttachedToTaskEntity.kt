package taskmanager.backend.models.interfaces

import org.bson.types.ObjectId

interface AttachedToTaskEntity : CreatedByUserEntity {
    val task: ObjectId
}