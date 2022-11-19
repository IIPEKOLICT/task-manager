package taskmanager.backend.services.impl

import com.mongodb.client.model.FindOneAndUpdateOptions
import com.mongodb.client.model.ReturnDocument
import org.bson.types.ObjectId
import org.litote.kmongo.SetTo
import org.litote.kmongo.coroutine.CoroutineCollection
import org.litote.kmongo.eq
import org.litote.kmongo.set
import org.litote.kmongo.setValue
import taskmanager.backend.enums.CollectionInfo
import taskmanager.backend.models.Tag
import taskmanager.backend.services.TagService
import taskmanager.backend.services.base.impl.CreatedByUserEntityServiceImpl
import java.util.*

class TagServiceImpl(
    override val collection: CoroutineCollection<Tag>
) : CreatedByUserEntityServiceImpl<Tag>(collection, CollectionInfo.TAG), TagService {

    override suspend fun getByProject(projectId: ObjectId): List<Tag> {
        return collection.find(Tag::project eq projectId).toList()
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
                update = set(
                    SetTo(Tag::name, name),
                    SetTo(Tag::updatedAt, Date())
                ),
                options = FindOneAndUpdateOptions().returnDocument(ReturnDocument.AFTER)
            )
            ?: throw notFoundException
    }

    override suspend fun deleteByProject(projectId: ObjectId) {
        collection.deleteMany(Tag::project eq projectId)
    }
}