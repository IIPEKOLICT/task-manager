package taskmanager.backend.services.impl

import org.bson.types.ObjectId
import org.litote.kmongo.coroutine.CoroutineCollection
import org.litote.kmongo.eq
import org.litote.kmongo.setValue
import taskmanager.backend.enums.CollectionInfo
import taskmanager.backend.models.Tag
import taskmanager.backend.services.TagService
import taskmanager.backend.services.base.impl.CreatedByUserEntityServiceImpl

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
        return updateById(id, setValue(Tag::name, name))
    }

    override suspend fun deleteByProject(projectId: ObjectId) {
        collection.deleteMany(Tag::project eq projectId)
    }
}