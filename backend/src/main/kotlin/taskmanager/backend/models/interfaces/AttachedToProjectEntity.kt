package taskmanager.backend.models.interfaces

import org.bson.types.ObjectId

interface AttachedToProjectEntity : CreatedByUserEntity {
    val project: ObjectId
}