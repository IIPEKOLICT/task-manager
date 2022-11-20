package taskmanager.backend.services.base.impl

import org.bson.types.ObjectId
import org.litote.kmongo.coroutine.CoroutineCollection
import org.litote.kmongo.eq
import taskmanager.backend.enums.CollectionInfo
import taskmanager.backend.models.interfaces.AttachedToProjectEntity
import taskmanager.backend.models.interfaces.AttachedToTaskEntity
import taskmanager.backend.services.base.AttachedToProjectEntityService

abstract class AttachedToProjectEntityServiceImpl<E : AttachedToProjectEntity>(
    override val collection: CoroutineCollection<E>,
    collectionInfo: CollectionInfo
) : CreatedByUserEntityServiceImpl<E>(collection, collectionInfo), AttachedToProjectEntityService<E> {

    override suspend fun getByProject(projectId: ObjectId): List<E> {
        return collection.find(AttachedToTaskEntity::task eq projectId).toList()
    }

    override suspend fun deleteByProject(projectId: ObjectId) {
        collection.deleteMany(AttachedToTaskEntity::task eq projectId)
    }
}