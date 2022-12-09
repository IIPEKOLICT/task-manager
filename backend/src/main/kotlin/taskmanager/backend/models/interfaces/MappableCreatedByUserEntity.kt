package taskmanager.backend.models.interfaces

import org.bson.types.ObjectId
import taskmanager.backend.models.User

interface MappableCreatedByUserEntity<D> : CreatedByUserEntity {
    fun toResponseDto(userId: ObjectId, createdBy: User?): D
}