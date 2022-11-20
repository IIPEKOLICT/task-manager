package taskmanager.backend.services.base

import org.bson.types.ObjectId
import taskmanager.backend.models.interfaces.CreatedByUserEntity

interface CreatedByUserEntityService<E : CreatedByUserEntity> : BaseService<E> {
    fun isOwner(entity: E, userId: ObjectId): Boolean
}