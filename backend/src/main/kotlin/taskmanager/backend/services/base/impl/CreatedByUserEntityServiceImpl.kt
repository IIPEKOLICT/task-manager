package taskmanager.backend.services.base.impl

import org.bson.types.ObjectId
import taskmanager.backend.models.interfaces.CreatedByUserEntity
import taskmanager.backend.services.base.CreatedByUserEntityService

abstract class CreatedByUserEntityServiceImpl<E : CreatedByUserEntity> : CreatedByUserEntityService<E> {
    
    override fun isOwner(entity: E, userId: ObjectId): Boolean {
        return entity.createdBy.toString() == userId.toString()
    }
}