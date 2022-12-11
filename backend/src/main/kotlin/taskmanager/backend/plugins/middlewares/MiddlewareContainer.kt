package taskmanager.backend.plugins.middlewares

import com.github.iipekolict.knest.annotations.methods.Middleware
import com.github.iipekolict.knest.annotations.properties.Call
import com.github.iipekolict.knest.annotations.properties.MiddlewareAnnotation
import com.github.iipekolict.knest.annotations.properties.Param
import io.ktor.server.application.*
import io.ktor.server.auth.*
import io.ktor.server.auth.jwt.*
import org.bson.types.ObjectId
import taskmanager.backend.enums.EditableEntity
import taskmanager.backend.plugins.exceptions.custom.ForbiddenException
import taskmanager.backend.plugins.annotations.EditAccess
import taskmanager.backend.services.*
import taskmanager.backend.services.base.CreatedByUserEntityService

class MiddlewareContainer(
    private val projectService: ProjectService,
    private val tagService: TagService,
    private val taskService: TaskService,
    private val noteService: NoteService,
    private val commentService: CommentService,
    private val attachmentService: AttachmentService,
    private val workService: WorkService
) {

    @Middleware(EditAccess::class)
    suspend fun checkEditAccessMiddleware(
        @Call call: ApplicationCall,
        @Param("id") id: String,
        @MiddlewareAnnotation annotation: EditAccess?
    ) {
        val userId: String? = call.principal<JWTPrincipal>()?.get("_id")

        if (annotation == null || userId == null) return

        val service: CreatedByUserEntityService<*> = when (annotation.entity) {
            EditableEntity.PROJECT -> projectService
            EditableEntity.TAG -> tagService
            EditableEntity.TASK -> taskService
            EditableEntity.NOTE -> noteService
            EditableEntity.COMMENT -> commentService
            EditableEntity.ATTACHMENT -> attachmentService
            EditableEntity.WORK -> workService
            else -> throw RuntimeException("Unsupported entity type: ${annotation.entity}")
        }

        val canEdit: Boolean = service.canEdit(ObjectId(id), ObjectId(userId))

        if (!canEdit) {
            throw ForbiddenException(annotation.message.ifBlank { "Доступ запрещен" })
        }
    }
}