package taskmanager.backend.controllers

import com.github.iipekolict.knest.annotations.classes.Controller
import com.github.iipekolict.knest.annotations.methods.*
import com.github.iipekolict.knest.annotations.properties.Body
import com.github.iipekolict.knest.annotations.properties.Param
import io.ktor.http.content.*
import io.ktor.server.application.*
import io.ktor.server.plugins.*
import io.ktor.server.response.*
import kotlinx.coroutines.async
import kotlinx.coroutines.awaitAll
import kotlinx.coroutines.coroutineScope
import org.bson.types.ObjectId
import taskmanager.backend.dtos.request.*
import taskmanager.backend.dtos.response.GanttResponseDto
import taskmanager.backend.dtos.response.ProjectResponseDto
import taskmanager.backend.dtos.response.TaskResponseDto
import taskmanager.backend.dtos.response.UserResponseDto
import taskmanager.backend.enums.EditableEntity
import taskmanager.backend.mappers.GanttMapper
import taskmanager.backend.mappers.TaskMapper
import taskmanager.backend.models.Project
import taskmanager.backend.plugins.annotations.JwtUser
import taskmanager.backend.models.Tag
import taskmanager.backend.models.User
import taskmanager.backend.plugins.annotations.EditAccess
import taskmanager.backend.services.ProjectService
import taskmanager.backend.services.TagService
import taskmanager.backend.services.TaskService
import taskmanager.backend.services.UserService
import taskmanager.backend.shared.Endpoint

@Controller(Endpoint.PROJECTS)
class ProjectController(
    private val projectService: ProjectService,
    private val tagService: TagService,
    private val taskService: TaskService,
    private val userService: UserService,
    private val taskMapper: TaskMapper,
    private val ganttMapper: GanttMapper
) {

    @Get
    @Authentication(["auth-jwt"])
    suspend fun getAll(@JwtUser user: User): List<ProjectResponseDto> {
        return projectService.getByUser(user._id).map { it.toResponse(user._id) }
    }

    @Get("{id}")
    @Authentication(["auth-jwt"])
    suspend fun getById(
        @JwtUser user: User,
        @Param("id") id: String
    ): ProjectResponseDto {
        return projectService.getById(ObjectId(id)).toResponse(user._id)
    }

    @Get("{id}/tags")
    @Authentication(["auth-jwt"])
    suspend fun getProjectTags(@Param("id") id: String): List<Tag> {
        return tagService.getByProject(ObjectId(id))
    }

    @Get("{id}/tasks")
    @Authentication(["auth-jwt"])
    suspend fun getProjectTasks(
        @JwtUser user: User,
        @Param("id") id: String
    ): List<TaskResponseDto> {
        return taskMapper.convert(
            userId = user._id,
            tasks = taskService.getByProject(ObjectId(id))
        )
    }

    @Get("{id}/gantt-chart")
    @Authentication(["auth-jwt"])
    suspend fun getProjectGanttChart(
        @JwtUser user: User,
        @Param("id") id: String
    ): GanttResponseDto {
        val tasks: List<TaskResponseDto> = taskMapper.convert(
            userId = user._id,
            tasks = taskService.getByProject(ObjectId(id))
        )

        return ganttMapper.convert(tasks)
    }

    @Get("{id}/users")
    @Authentication(["auth-jwt"])
    suspend fun getProjectUsers(@Param("id") id: String): List<UserResponseDto> {
        val project: Project = projectService.getById(ObjectId(id))
        val ids: List<ObjectId> = listOf(project.createdBy, *project.members.toTypedArray())
        return userService.getByIds(ids).map { it.toResponseDto() }
    }

    @Post
    @Authentication(["auth-jwt"])
    suspend fun create(
        @JwtUser user: User,
        @Body(type = ProjectDto::class) dto: ProjectDto
    ): ProjectResponseDto {
        return projectService.create(user._id, dto).toResponse(user._id)
    }

    @Post("{id}/tags")
    @Authentication(["auth-jwt"])
    suspend fun createProjectTag(
        @JwtUser user: User,
        @Param("id") id: String,
        @Body("name") name: String
    ): Tag {
        return tagService.create(user._id, projectService.getById(ObjectId(id))._id, name)
    }

    @Post("{id}/tasks")
    @Authentication(["auth-jwt"])
    suspend fun createProjectTask(
        @JwtUser user: User,
        @Param("id") id: String,
        @Body(type = CreateTaskDto::class) dto: CreateTaskDto
    ): TaskResponseDto {
        dto.validate()
        return taskMapper.convert(
            userId = user._id,
            task = taskService.create(user._id, projectService.getById(ObjectId(id))._id, dto)
        )
    }

    @Put("{id}")
    @Authentication(["auth-jwt"])
    @EditAccess(EditableEntity.PROJECT, "Вы не можете изменять этот проект")
    suspend fun updateById(
        @JwtUser user: User,
        @Param("id") id: String,
        @Body(type = ProjectDto::class) dto: ProjectDto
    ): ProjectResponseDto {
        return projectService.updateById(ObjectId(id), dto).toResponse(user._id)
    }

    @Delete("{id}")
    @Authentication(["auth-jwt"])
    @EditAccess(EditableEntity.PROJECT, "Вы не можете удалить этот проект")
    suspend fun deleteById(@Param("id") id: String): DeleteDto {
        val project: Project = projectService.getById(ObjectId(id))

        coroutineScope {
            awaitAll(
                async {
                    tagService.deleteByProject(project._id)
                },
                async {
                    taskService.deleteByProject(project._id)
                }
            )
        }

        return DeleteDto(projectService.deleteById(project._id))
    }
}