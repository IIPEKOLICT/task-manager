package taskmanager.backend.services.impl

import org.bson.types.ObjectId
import org.litote.kmongo.coroutine.CoroutineCollection
import org.litote.kmongo.setValue
import taskmanager.backend.enums.CollectionInfo
import taskmanager.backend.models.Comment
import taskmanager.backend.services.CommentService
import taskmanager.backend.services.base.impl.AttachedToTaskEntityServiceImpl

class CommentServiceImpl(
    override val collection: CoroutineCollection<Comment>
) : AttachedToTaskEntityServiceImpl<Comment>(collection, CollectionInfo.WORK), CommentService {

    override suspend fun create(userId: ObjectId, taskId: ObjectId, text: String): Comment {
        val comment = Comment(createdBy = userId, task = taskId, text = text)
        collection.save(comment)
        return comment
    }

    override suspend fun updateById(id: ObjectId, text: String): Comment {
        return updateById(id, setValue(Comment::text, text))
    }
}