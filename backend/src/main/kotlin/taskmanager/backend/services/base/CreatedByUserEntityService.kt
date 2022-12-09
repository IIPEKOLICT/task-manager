package taskmanager.backend.services.base

import org.bson.types.ObjectId
import taskmanager.backend.models.interfaces.CreatedByUserEntity

interface CreatedByUserEntityService<E : CreatedByUserEntity> : BaseService<E> {
    suspend fun canEdit(entityId: ObjectId, userId: ObjectId): Boolean
}