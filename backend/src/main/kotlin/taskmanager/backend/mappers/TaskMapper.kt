package taskmanager.backend.mappers

import org.bson.types.ObjectId
import taskmanager.backend.dtos.response.TaskResponseDto
import taskmanager.backend.models.Tag
import taskmanager.backend.models.Task
import taskmanager.backend.models.User
import taskmanager.backend.models.Work
import taskmanager.backend.services.TagService
import taskmanager.backend.services.UserService
import taskmanager.backend.services.WorkService

class TaskMapper(
    private val tagService: TagService,
    private val workService: WorkService,
    private val userService: UserService
) {

    suspend fun convert(userId: ObjectId, tasks: List<Task>): List<TaskResponseDto> {
        val users: List<User> = userService.getByIds(tasks.map { it.assignedTo })
        val tags: List<Tag> = tagService.getByIds(tasks.map { it.tags }.flatten())
        val works: List<Work> = workService.getByIds(tasks.map { it.works }.flatten())

        return tasks.map { task ->
            val assignedUser: User? = users.find { user ->
                user._id.toString() == task.assignedTo.toString()
            }

            val taskTags: List<Tag> = tags.filter { tag ->
                task.tags.any { taskTagId -> taskTagId.toString() == tag._id.toString() }
            }

            var trackedTime: Long = 0

            works.forEach { work ->
                if (task.works.any { taskWorkId -> taskWorkId.toString() == work._id.toString() }) {
                    trackedTime += work.endDate.time - work.startDate.time
                }
            }

            TaskResponseDto(
                _id = task._id.toString(),
                createdBy = task.createdBy.toString(),
                project = task.project.toString(),
                assignedTo = assignedUser?.toResponseDto(),
                blockedBy = task.blockedBy.map { blocked -> blocked.toString() },
                commentsAmount = task.comments.size,
                notesAmount = task.notes.size,
                attachmentsAmount = task.attachments.size,
                tags = taskTags,
                title = task.title,
                description = task.description,
                color = task.color,
                priority = task.priority,
                status = task.status,
                expectedHours = task.expectedHours,
                createdAt = task.createdAt,
                updatedAt = task.updatedAt,
                canEdit = task.createdBy.toString() == userId.toString(),
                trackedTime = trackedTime
            )
        }
    }

    suspend fun convert(userId: ObjectId, task: Task): TaskResponseDto {
        return convert(userId, listOf(task))[0]
    }
}