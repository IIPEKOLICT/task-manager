package taskmanager.backend.services.base.impl

import org.bson.types.ObjectId
import org.litote.kmongo.coroutine.CoroutineCollection
import taskmanager.backend.enums.CollectionInfo
import taskmanager.backend.models.interfaces.CreatedByUserEntity
import taskmanager.backend.services.base.CreatedByUserEntityService

abstract class CreatedByUserEntityServiceImpl<E : CreatedByUserEntity>(
    override val collection: CoroutineCollection<E>,
    collectionInfo: CollectionInfo
) : BaseServiceImpl<E>(collection, collectionInfo), CreatedByUserEntityService<E> {
    
    override fun isOwner(entity: E, userId: ObjectId): Boolean {
        return entity.createdBy.toString() == userId.toString()
    }
}