package taskmanager.backend.services.base.impl

import org.bson.conversions.Bson
import org.bson.types.ObjectId
import org.litote.kmongo.and
import org.litote.kmongo.coroutine.CoroutineCollection
import org.litote.kmongo.eq
import taskmanager.backend.enums.CollectionInfo
import taskmanager.backend.models.interfaces.CreatedByUserEntity
import taskmanager.backend.services.base.CreatedByUserEntityService

abstract class CreatedByUserEntityServiceImpl<E : CreatedByUserEntity>(
    override val collection: CoroutineCollection<E>,
    collectionInfo: CollectionInfo
) : BaseServiceImpl<E>(collection, collectionInfo), CreatedByUserEntityService<E> {

    override suspend fun canEdit(entityId: ObjectId, userId: ObjectId): Boolean {
        val conditions: Bson = and(
            CreatedByUserEntity::_id eq entityId,
            CreatedByUserEntity::createdBy eq userId
        )

        return collection.countDocuments(conditions).toInt() == 1
    }

    override suspend fun deleteByUser(userId: ObjectId) {
        collection.deleteMany(CreatedByUserEntity::createdBy eq userId)
    }
}