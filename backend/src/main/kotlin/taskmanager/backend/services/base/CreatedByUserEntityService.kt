package taskmanager.backend.services.base

import org.bson.types.ObjectId
import taskmanager.backend.models.interfaces.CreatedByUserEntity

interface CreatedByUserEntityService<E : CreatedByUserEntity> {
    fun isOwner(entity: E, userId: ObjectId): Boolean
}