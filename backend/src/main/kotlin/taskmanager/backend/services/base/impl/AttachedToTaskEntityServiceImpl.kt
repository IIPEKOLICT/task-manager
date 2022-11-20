package taskmanager.backend.services.base.impl

import org.bson.types.ObjectId
import org.litote.kmongo.coroutine.CoroutineCollection
import org.litote.kmongo.eq
import taskmanager.backend.enums.CollectionInfo
import taskmanager.backend.models.interfaces.AttachedToTaskEntity
import taskmanager.backend.services.base.AttachedToTaskEntityService

abstract class AttachedToTaskEntityServiceImpl<E : AttachedToTaskEntity>(
    override val collection: CoroutineCollection<E>,
    collectionInfo: CollectionInfo
) : CreatedByUserEntityServiceImpl<E>(collection, collectionInfo), AttachedToTaskEntityService<E> {

    override suspend fun getByTask(taskId: ObjectId): List<E> {
        return collection.find(AttachedToTaskEntity::task eq taskId).toList()
    }

    override suspend fun deleteByTask(taskId: ObjectId) {
        collection.deleteMany(AttachedToTaskEntity::task eq taskId)
    }
}