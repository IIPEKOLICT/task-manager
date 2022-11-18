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

class TagServiceImpl(database: CoroutineDatabase) : TagService {

    private val collection: CoroutineCollection<Tag> = database.getCollection(DBCollection.TAG.nameInDB)
    private val notFoundException = EntityNotFoundException(DBCollection.TAG.entityName)

    override suspend fun getAll(): List<Tag> {
        return collection.find().toList()
    }

    override suspend fun getByProject(projectId: String): List<Tag> {
        return collection.find(Tag::project eq ObjectId(projectId)).toList()
    }

    override suspend fun getById(id: String): Tag {
        return collection.findOneById(ObjectId(id)) ?: throw notFoundException
    }

    override suspend fun isOwner(id: String, userId: ObjectId): Boolean {
        return getById(id).createdBy.toString() == userId.toString()
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

    override suspend fun updateById(id: String, name: String): Tag {
        return collection
            .findOneAndUpdate(
                filter = Tag::_id eq ObjectId(id),
                update = setValue(Tag::name, name),
                options = FindOneAndUpdateOptions().returnDocument(ReturnDocument.AFTER)
            )
            ?: throw notFoundException
    }

    override suspend fun deleteById(id: String): String {
        return collection.findOneAndDelete(Tag::_id eq ObjectId(id))?._id?.toString()
            ?: throw notFoundException
    }

    override suspend fun deleteByProject(projectId: String) {
        collection.deleteMany(Tag::project eq ObjectId(projectId))
    }
}