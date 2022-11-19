package taskmanager.backend.services.base.impl

import com.mongodb.client.model.FindOneAndUpdateOptions
import com.mongodb.client.model.ReturnDocument
import org.bson.conversions.Bson
import org.bson.types.ObjectId
import org.litote.kmongo.*
import org.litote.kmongo.coroutine.CoroutineCollection
import taskmanager.backend.enums.CollectionInfo
import taskmanager.backend.exceptions.custom.EntityNotFoundException
import taskmanager.backend.models.base.impl.BaseEntityImpl
import taskmanager.backend.models.base.BaseEntity
import taskmanager.backend.services.base.BaseService
import java.util.*

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

    protected suspend fun updateById(id: ObjectId, vararg updates: Bson): E {
        return collection
            .findOneAndUpdate(
                filter = BaseEntity::_id eq id,
                update = combine(*updates, setValue(BaseEntity::updatedAt, Date())),
                options = FindOneAndUpdateOptions().returnDocument(ReturnDocument.AFTER)
            )
            ?: throw notFoundException
    }
}