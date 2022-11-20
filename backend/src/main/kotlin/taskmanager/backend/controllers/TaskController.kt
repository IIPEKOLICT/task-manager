package taskmanager.backend.controllers

import com.github.iipekolict.knest.annotations.classes.Controller
import com.github.iipekolict.knest.annotations.methods.*
import com.github.iipekolict.knest.annotations.properties.Body
import com.github.iipekolict.knest.annotations.properties.Param
import io.ktor.http.content.*
import io.ktor.server.application.*
import io.ktor.server.plugins.*
import io.ktor.server.response.*
import org.bson.types.ObjectId
import taskmanager.backend.dtos.request.*
import taskmanager.backend.enums.Priority
import taskmanager.backend.enums.Status
import taskmanager.backend.plugins.annotations.JwtUser
import taskmanager.backend.exceptions.custom.ForbiddenException
import taskmanager.backend.models.*
import taskmanager.backend.services.CommentService
import taskmanager.backend.services.NoteService
import taskmanager.backend.services.TaskService
import taskmanager.backend.services.WorkService

@Controller("tasks")
class TaskController(
    private val taskService: TaskService,
    private val workService: WorkService,
    private val commentService: CommentService,
    private val noteService: NoteService
) {

    @Get("{id}")
    @Authentication(["auth-jwt"])
    suspend fun getById(@Param("id") id: String): Task {
        return taskService.getById(ObjectId(id))
    }

    @Get("{id}/works")
    @Authentication(["auth-jwt"])
    suspend fun getTaskWorks(@Param("id") id: String): List<Work> {
        return workService.getByTask(ObjectId(id))
    }

    @Get("{id}/comments")
    @Authentication(["auth-jwt"])
    suspend fun getTaskComments(@Param("id") id: String): List<Comment> {
        return commentService.getByTask(ObjectId(id))
    }

    @Get("{id}/notes")
    @Authentication(["auth-jwt"])
    suspend fun getTaskNotes(@Param("id") id: String): List<Note> {
        return noteService.getByTask(ObjectId(id))
    }

    @Post("{id}/works")
    @Authentication(["auth-jwt"])
    suspend fun createTaskWork(
        @JwtUser user: User,
        @Param("id") id: String,
        @Body(type = WorkDto::class) dto: WorkDto
    ): Work {
        return workService.create(user._id, ObjectId(id), dto)
    }

    @Post("{id}/comments")
    @Authentication(["auth-jwt"])
    suspend fun createTaskComment(
        @JwtUser user: User,
        @Param("id") id: String,
        @Body("text") text: String
    ): Comment {
        return commentService.create(user._id, ObjectId(id), text)
    }

    @Post("{id}/notes")
    @Authentication(["auth-jwt"])
    suspend fun createTaskNote(
        @JwtUser user: User,
        @Param("id") id: String,
        @Body(type = NoteDto::class) dto: NoteDto
    ): Note {
        return noteService.create(user._id, ObjectId(id), dto)
    }

    @Patch("{id}/info")
    @Authentication(["auth-jwt"])
    suspend fun updateInfo(
        @Param("id") id: String,
        @Body(type = UpdateTaskInfoDto::class) dto: UpdateTaskInfoDto
    ): Task {
        return taskService.updateInfo(ObjectId(id), dto)
    }

    @Patch("{id}/status")
    @Authentication(["auth-jwt"])
    suspend fun updateStatus(
        @Param("id") id: String,
        @Body("status") status: String
    ): Task {
        return taskService.updateStatus(ObjectId(id), Status.valueOf(status))
    }

    @Patch("{id}/priority")
    @Authentication(["auth-jwt"])
    suspend fun updatePriority(
        @Param("id") id: String,
        @Body("priority") priority: String
    ): Task {
        return taskService.updatePriority(ObjectId(id), Priority.valueOf(priority))
    }

    @Patch("{id}/tags")
    @Authentication(["auth-jwt"])
    suspend fun updateTags(
        @Param("id") id: String,
        @Body("tags") tags: List<String>
    ): Task {
        return taskService.updateTags(ObjectId(id), tags.map { ObjectId(it) })
    }

    @Patch("{id}/blocked-by")
    @Authentication(["auth-jwt"])
    suspend fun updateBlockedBy(
        @Param("id") id: String,
        @Body("blockedBy") blockedBy: List<String>
    ): Task {
        return taskService.updateBlockedBy(ObjectId(id), blockedBy.map { ObjectId(it) })
    }

    @Delete("{id}")
    @Authentication(["auth-jwt"])
    suspend fun deleteById(
        @JwtUser user: User,
        @Param("id") id: String
    ): DeleteDto {
        val task: Task = taskService.getById(ObjectId(id))

        if (!taskService.isOwner(task, user._id)) {
            throw ForbiddenException("Вы не можете удалить эту задачу")
        }

        return DeleteDto(taskService.deleteById(task._id))
    }
}