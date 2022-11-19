package taskmanager.backend.services.impl

import com.mongodb.client.model.FindOneAndUpdateOptions
import com.mongodb.client.model.ReturnDocument
import org.bson.types.ObjectId
import org.litote.kmongo.coroutine.CoroutineCollection
import org.litote.kmongo.coroutine.CoroutineDatabase
import org.litote.kmongo.eq
import org.litote.kmongo.setValue
import taskmanager.backend.enums.DBCollection
import taskmanager.backend.exceptions.custom.EntityNotFoundException
import taskmanager.backend.models.Tag
import taskmanager.backend.services.TagService
import taskmanager.backend.services.base.impl.CreatedByUserEntityServiceImpl

class TagServiceImpl(
    database: CoroutineDatabase
) : CreatedByUserEntityServiceImpl<Tag>(), TagService {

    private val collection: CoroutineCollection<Tag> = database.getCollection(
        DBCollection.TAG.collectionName
    )

    private val notFoundException = EntityNotFoundException(DBCollection.TAG.entityName)

    override suspend fun getAll(): List<Tag> {
        return collection.find().toList()
    }

    override suspend fun getByProject(projectId: ObjectId): List<Tag> {
        return collection.find(Tag::project eq projectId).toList()
    }

    override suspend fun getById(id: ObjectId): Tag {
        return collection.findOneById(id) ?: throw notFoundException
    }

    override suspend fun create(userId: ObjectId, projectId: ObjectId, name: String): Tag {
        val tag = Tag(
            createdBy = userId,
            project = projectId,
            name = name
        )

        collection.save(tag)
        return tag
    }

    override suspend fun updateById(id: ObjectId, name: String): Tag {
        return collection
            .findOneAndUpdate(
                filter = Tag::_id eq id,
                update = setValue(Tag::name, name),
                options = FindOneAndUpdateOptions().returnDocument(ReturnDocument.AFTER)
            )
            ?: throw notFoundException
    }

    override suspend fun deleteById(id: ObjectId): String {
        return collection.findOneAndDelete(Tag::_id eq id)?._id?.toString()
            ?: throw notFoundException
    }

    override suspend fun deleteByProject(projectId: ObjectId) {
        collection.deleteMany(Tag::project eq projectId)
    }
}