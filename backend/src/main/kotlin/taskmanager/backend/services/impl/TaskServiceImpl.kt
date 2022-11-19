package taskmanager.backend.services.impl

import org.bson.types.ObjectId
import org.litote.kmongo.*
import org.litote.kmongo.coroutine.CoroutineCollection
import taskmanager.backend.dtos.request.CreateTaskDto
import taskmanager.backend.dtos.request.UpdateTaskInfoDto
import taskmanager.backend.enums.CollectionInfo
import taskmanager.backend.enums.Priority
import taskmanager.backend.enums.Status
import taskmanager.backend.models.Task
import taskmanager.backend.services.TaskService
import taskmanager.backend.services.base.impl.CreatedByUserEntityServiceImpl
import java.text.SimpleDateFormat

class TaskServiceImpl(
    override val collection: CoroutineCollection<Task>
) : CreatedByUserEntityServiceImpl<Task>(collection, CollectionInfo.TASK), TaskService {

    override suspend fun getByProject(projectId: ObjectId): List<Task> {
        return collection.find(Task::project eq projectId).toList()
    }

    override suspend fun create(userId: ObjectId, projectId: ObjectId, dto: CreateTaskDto): Task {
        val expectedTime = if (dto.expectedTime != null) {
            SimpleDateFormat().parse(dto.expectedTime)
        } else {
            null
        }

        val task = Task(
            createdBy = userId,
            project = projectId,
            assignedTo = ObjectId(dto.assignedTo),
            blockedBy = dto.blockedBy.map { ObjectId(it) }.toSet(),
            tags = dto.tags.map { ObjectId(it) }.toSet(),
            title = dto.title,
            description = dto.description,
            priority = dto.priority,
            status = dto.status,
            expectedTime = expectedTime
        )

        collection.save(task)
        return task
    }

    override suspend fun updateInfo(id: ObjectId, dto: UpdateTaskInfoDto): Task {
        return updateById(
            id,
            set(
                Task::title setTo dto.title,
                Task::description setTo dto.description
            )
        )
    }

    override suspend fun updateStatus(id: ObjectId, status: Status): Task {
        return updateById(id, setValue(Task::status, status.name))
    }

    override suspend fun updatePriority(id: ObjectId, priority: Priority): Task {
        return updateById(id, setValue(Task::priority, priority.name))
    }

    override suspend fun updateBlockedBy(id: ObjectId, blockedBy: List<ObjectId>): Task {
        return updateById(id, setValue(Task::blockedBy, blockedBy.toSet()))
    }

    override suspend fun updateTags(id: ObjectId, tags: List<ObjectId>): Task {
        return updateById(id, setValue(Task::tags, tags.toSet()))
    }

    override suspend fun addWork(id: ObjectId, workId: ObjectId) {
        updateById(id, addToSet(Task::works, workId))
    }

    override suspend fun addComment(id: ObjectId, commentId: ObjectId) {
        updateById(id, addToSet(Task::comments, commentId))
    }

    override suspend fun addNote(id: ObjectId, noteId: ObjectId) {
        updateById(id, addToSet(Task::notes, noteId))
    }

    override suspend fun addAttachment(id: ObjectId, attachmentId: ObjectId) {
        updateById(id, addToSet(Task::attachments, attachmentId))
    }

    override suspend fun removeWork(id: ObjectId, workId: ObjectId) {
        updateById(id, pull(Task::works, workId))
    }

    override suspend fun removeComment(id: ObjectId, commentId: ObjectId) {
        updateById(id, pull(Task::comments, commentId))
    }

    override suspend fun removeNote(id: ObjectId, noteId: ObjectId) {
        updateById(id, pull(Task::notes, noteId))
    }

    override suspend fun removeAttachment(id: ObjectId, attachmentId: ObjectId) {
        updateById(id, pull(Task::attachments, attachmentId))
    }

    override suspend fun deleteByProject(projectId: ObjectId) {
        collection.deleteMany(Task::project eq projectId)
    }
}