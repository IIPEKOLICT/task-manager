package taskmanager.backend.services.base.impl

import org.bson.types.ObjectId
import org.litote.kmongo.coroutine.CoroutineCollection
import org.litote.kmongo.eq
import taskmanager.backend.enums.CollectionInfo
import taskmanager.backend.exceptions.custom.EntityNotFoundException
import taskmanager.backend.models.base.BaseEntityImpl
import taskmanager.backend.models.interfaces.BaseEntity
import taskmanager.backend.services.base.BaseService

abstract class BaseServiceImpl<E : BaseEntity>(
    protected open val collection: CoroutineCollection<E>,
    collectionInfo: CollectionInfo
) : BaseService<E> {

    protected val notFoundException = EntityNotFoundException(collectionInfo.entityName)

    override suspend fun getAll(): List<E> {
        return collection.find().toList()
    }

    override suspend fun getById(id: ObjectId): E {
        return collection.findOneById(id) ?: throw notFoundException
    }

    override suspend fun deleteById(id: ObjectId): ObjectId {
        return collection.findOneAndDelete(BaseEntityImpl::_id eq id)?._id
            ?: throw notFoundException
    }
}